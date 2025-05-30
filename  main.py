import tkinter as tk
from tkinter import ttk, messagebox
import pyodbc
from decimal import Decimal
import re
from typing import Dict, List, Optional, Any
from database_connection import DBConnection


class DataTable(ttk.Treeview):
    """Custom table widget with double scrollbars"""

    def __init__(self, parent, *args, **kwargs):
        super().__init__(parent, *args, **kwargs)

        # Configure scrollbars
        scroll_y = ttk.Scrollbar(parent, orient="vertical", command=self.yview)
        scroll_y.pack(side="right", fill="y")
        self.configure(yscrollcommand=scroll_y.set)

        scroll_x = ttk.Scrollbar(parent, orient="horizontal", command=self.xview)
        scroll_x.pack(side="bottom", fill="x")
        self.configure(xscrollcommand=scroll_x.set)

        self.pack(fill="both", expand=True)


class RecordDialog:
    """Dialog window for adding/editing records"""

    def __init__(self, parent, title: str, columns: List[str], column_info: Dict,
                 values: Optional[List] = None):
        self.parent = parent
        self.result = {"confirmed": False, "values": []}

        self.window = tk.Toplevel(parent)
        self.window.title(title)
        self.window.geometry("500x600")
        self.window.transient(parent)
        self.window.grab_set()

        self._center_window()
        self._create_form(columns, column_info, values)
        self._add_buttons()

    def _center_window(self):
        """Centers the window relative to parent"""
        self.window.update_idletasks()
        width = self.window.winfo_width()
        height = self.window.winfo_height()
        x = (self.window.winfo_screenwidth() // 2) - (width // 2)
        y = (self.window.winfo_screenheight() // 2) - (height // 2)
        self.window.geometry(f'+{x}+{y}')

    def _create_form(self, columns: List[str], column_info: Dict, values: Optional[List]):
        """Creates form with input fields"""
        main_frame = tk.Frame(self.window)
        main_frame.pack(fill="both", expand=True, padx=10, pady=10)

        # Scrollable area
        canvas = tk.Canvas(main_frame)
        scrollbar = ttk.Scrollbar(main_frame, orient="vertical", command=canvas.yview)
        form_frame = tk.Frame(canvas)

        form_frame.bind("<Configure>", lambda e: canvas.configure(scrollregion=canvas.bbox("all")))
        canvas.create_window((0, 0), window=form_frame, anchor="nw")
        canvas.configure(yscrollcommand=scrollbar.set)

        self.fields = []
        for idx, column in enumerate(columns):
            frame = tk.Frame(form_frame)
            frame.pack(fill="x", padx=5, pady=5)

            info = column_info.get(column, {})
            label_text = f"{column} ({info.get('type', 'TEXT')})"
            if info.get('primary_key'):
                label_text += " [PK]"

            tk.Label(frame, text=label_text).pack(anchor="w")

            field = tk.Entry(frame, width=50)
            if values and idx < len(values):
                field.insert(0, str(values[idx]) if values[idx] is not None else "")
            elif info.get('identity'):
                field.insert(0, "Auto-generated")
                field.config(state="readonly")

            field.pack(fill="x")
            self.fields.append(field)

        canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")

    def _add_buttons(self):
        """Adds confirmation/cancel buttons"""
        button_frame = tk.Frame(self.window)
        button_frame.pack(fill="x", pady=10)

        tk.Button(
            button_frame, text="Save", command=self._on_ok,
            bg="#4CAF50", fg="white", width=12
        ).pack(side="left", padx=5)

        tk.Button(
            button_frame, text="Cancel", command=self._on_cancel,
            bg="#f44336", fg="white", width=12
        ).pack(side="left", padx=5)

    def _on_ok(self):
        """OK button handler"""
        self.result["confirmed"] = True
        self.result["values"] = [field.get() for field in self.fields]
        self.window.destroy()

    def _on_cancel(self):
        """Cancel button handler"""
        self.window.destroy()

    def show(self):
        """Shows dialog and returns result"""
        self.window.wait_window()
        return self.result


class MainWindow(tk.Tk):
    """Main application window"""

    def __init__(self):
        super().__init__()
        self.title("Insurance Company - Database Management")
        self.geometry("1000x700")
        self._setup_interface()
        self._load_initial_data()

    def _setup_interface(self):
        """Sets up user interface"""
        # Control panel
        control_panel = tk.Frame(self)
        control_panel.pack(fill="x", padx=10, pady=10)

        tk.Label(control_panel, text="Table:").pack(side="left")

        self.table_selector = ttk.Combobox(
            control_panel,
            values=[
                "Agent", "Agent_Cabinet", "Cabinet",
                "Client", "Insurance_event",
                "Agent_Type_of_insurance", "Contract", "Type_of_insurance"
            ]
        )
        self.table_selector.pack(side="left", padx=5)
        self.table_selector.current(0)
        self.table_selector.bind("<<ComboboxSelected>>", lambda e: self.load_data())

        buttons = [
            ("Load", self.load_data),
            ("Add", self.add_record),
            ("Edit", self.edit_record),
            ("Delete", self.delete_record),
            ("Cascade Delete", self.cascade_delete),
            ("Structure", self.show_structure)
        ]

        for text, command in buttons:
            tk.Button(
                control_panel,
                text=text,
                command=command
            ).pack(side="left", padx=5)

        # Data table
        self.table_frame = tk.Frame(self)
        self.table_frame.pack(fill="both", expand=True, padx=10, pady=10)

        self.data_table = DataTable(
            self.table_frame,
            columns=(),
            show="headings",
            selectmode="browse"
        )

    def _load_initial_data(self):
        """Loads initial data when program starts"""
        self.load_data()

    def _get_column_info(self, table_name: str) -> Dict:
        """Gets metadata about table columns"""
        try:
            connection = DBConnection.get_connection()
            cursor = connection.cursor()

            # FIXED QUERY
            query = """
            SELECT 
                c.COLUMN_NAME,
                c.DATA_TYPE,
                c.IS_NULLABLE,
                CASE WHEN c.COLUMN_DEFAULT LIKE '%identity%' OR 
                          COLUMNPROPERTY(OBJECT_ID(c.TABLE_SCHEMA + '.' + c.TABLE_NAME), c.COLUMN_NAME, 'IsIdentity') = 1 
                     THEN 1 ELSE 0 END AS is_identity,
                CASE WHEN tc.CONSTRAINT_TYPE = 'PRIMARY KEY' THEN 1 ELSE 0 END AS is_primary_key
            FROM INFORMATION_SCHEMA.COLUMNS c
            LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu 
                ON c.TABLE_NAME = kcu.TABLE_NAME 
                AND c.COLUMN_NAME = kcu.COLUMN_NAME
                AND c.TABLE_SCHEMA = kcu.TABLE_SCHEMA
            LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc 
                ON kcu.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
                AND kcu.TABLE_SCHEMA = tc.TABLE_SCHEMA
                AND tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
            WHERE c.TABLE_NAME = ?
            ORDER BY c.ORDINAL_POSITION
            """

            cursor.execute(query, (table_name,))
            column_info = cursor.fetchall()

            result = {}
            for column in column_info:
                result[column[0]] = {
                    'type': column[1],
                    'null': column[2] == 'YES',
                    'identity': bool(column[3]),
                    'primary_key': bool(column[4])
                }

            # Debug output
            print(f"Column info for table {table_name}:")
            for name, info in result.items():
                if info['primary_key']:
                    print(f"  {name}: PK={info['primary_key']}, Identity={info['identity']}")

            return result

        except Exception as e:
            messagebox.showerror("Error", f"Failed to get column info:\n{str(e)}")
            print(f"Error getting column info: {e}")
            return {}

    def _clean_value(self, value):
        """Cleans value from problematic characters"""
        if value is None:
            return ""
        if isinstance(value, str):
            return re.sub(r"[\'\";]", "", value.strip())
        if isinstance(value, Decimal):
            return float(value)
        return value

    def load_data(self):
        """Loads data from selected table"""
        table_name = self.table_selector.get()
        if not table_name:
            return

        try:
            connection = DBConnection.get_connection()
            cursor = connection.cursor()

            # Get data
            cursor.execute(f"SELECT * FROM {table_name}")
            rows = cursor.fetchall()

            # Get column names
            columns = [column[0] for column in cursor.description]

            # Clear and configure table
            self.data_table.delete(*self.data_table.get_children())
            self.data_table["columns"] = columns

            for column in columns:
                self.data_table.heading(column, text=column)
                self.data_table.column(column, width=120, minwidth=50, stretch=True)

            # Fill with data
            for row in rows:
                processed_row = [self._clean_value(value) for value in row]
                self.data_table.insert("", "end", values=processed_row)

        except pyodbc.Error as e:
            error = str(e)
            if "quotes" in error:
                error = "Data format error: invalid quotes in fields"
            messagebox.showerror("Error", f"Failed to load {table_name}:\n{error}")
        except Exception as e:
            messagebox.showerror("Error", f"Critical error:\n{str(e)}")

    def show_structure(self):
        """Shows structure of all tables"""
        try:
            connection = DBConnection.get_connection()
            cursor = connection.cursor()

            query = """
            SELECT 
                c.TABLE_NAME as table_name,
                c.COLUMN_NAME as column_name,
                c.DATA_TYPE as data_type,
                c.IS_NULLABLE as is_nullable,
                CASE WHEN COLUMNPROPERTY(OBJECT_ID(c.TABLE_SCHEMA + '.' + c.TABLE_NAME), c.COLUMN_NAME, 'IsIdentity') = 1 
                     THEN 1 ELSE 0 END as is_identity,
                CASE WHEN tc.CONSTRAINT_TYPE = 'PRIMARY KEY' THEN 1 ELSE 0 END as is_primary_key
            FROM INFORMATION_SCHEMA.COLUMNS c
            LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu 
                ON c.TABLE_NAME = kcu.TABLE_NAME 
                AND c.COLUMN_NAME = kcu.COLUMN_NAME
            LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc 
                ON kcu.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
                AND tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
            WHERE c.TABLE_NAME IN ('Agent', 'Agent_Cabinet', 'Cabinet', 'Client', 
                                   'Insurance_event', 'Agent_Type_of_insurance', 'Contract', 'Type_of_insurance')
            ORDER BY c.TABLE_NAME, c.ORDINAL_POSITION
            """

            cursor.execute(query)
            rows = cursor.fetchall()

            # Create new window for display
            result_window = tk.Toplevel(self)
            result_window.title("Structure of all tables")
            result_window.geometry("800x600")

            # Table for output
            tree = ttk.Treeview(
                result_window,
                columns=("Table", "Column", "Type", "NULL", "Identity", "PK"),
                show="headings"
            )
            tree.heading("Table", text="Table")
            tree.heading("Column", text="Column")
            tree.heading("Type", text="Data Type")
            tree.heading("NULL", text="NULL")
            tree.heading("Identity", text="Identity")
            tree.heading("PK", text="PK")

            tree.column("Table", width=150)
            tree.column("Column", width=150)
            tree.column("Type", width=100)
            tree.column("NULL", width=50, anchor="center")
            tree.column("Identity", width=50, anchor="center")
            tree.column("PK", width=50, anchor="center")

            for row in rows:
                tree.insert("", "end", values=row)

            scrollbar = ttk.Scrollbar(result_window, orient="vertical", command=tree.yview)
            tree.configure(yscrollcommand=scrollbar.set)
            tree.pack(fill="both", expand=True)
            scrollbar.pack(side="right", fill="y")

        except Exception as e:
            messagebox.showerror("Error", f"Failed to load table structure:\n{str(e)}")

    def add_record(self):
        """Adds new record"""
        table_name = self.table_selector.get()
        if not table_name or not self.data_table["columns"]:
            messagebox.showwarning("Warning", "Please load a table first")
            return

        columns = self.data_table["columns"]
        column_info = self._get_column_info(table_name)

        dialog = RecordDialog(self, "Add Record", columns, column_info)
        result = dialog.show()

        if result["confirmed"]:
            try:
                connection = DBConnection.get_connection()
                cursor = connection.cursor()

                # Filter columns and values
                columns_to_insert = []
                values_to_insert = []

                for column, value in zip(columns, result["values"]):
                    info = column_info.get(column, {})

                    # Skip identity columns with empty values
                    if info.get('identity') and not value:
                        continue

                    columns_to_insert.append(column)
                    values_to_insert.append(value)

                if columns_to_insert:
                    placeholders = ", ".join(["?"] * len(columns_to_insert))
                    query = f"""
                    INSERT INTO {table_name} 
                    ({', '.join(columns_to_insert)}) 
                    VALUES ({placeholders})
                    """
                    cursor.execute(query, values_to_insert)
                else:
                    query = f"INSERT INTO {table_name} DEFAULT VALUES"
                    cursor.execute(query)

                connection.commit()
                self.load_data()
                messagebox.showinfo("Success", "Record added successfully")

            except Exception as e:
                messagebox.showerror("Error", f"Failed to add record:\n{str(e)}")

    def edit_record(self):
        """Edits selected record"""
        selected = self.data_table.selection()
        if not selected:
            messagebox.showwarning("Warning", "Select a record to edit")
            return

        table_name = self.table_selector.get()
        columns = self.data_table["columns"]
        values = self.data_table.item(selected)["values"]
        column_info = self._get_column_info(table_name)

        # FIXED PRIMARY KEY LOGIC
        pk_columns = [column for column in columns
                      if column_info.get(column, {}).get('primary_key')]

        if not pk_columns:
            # If PK not found, try standard names
            standard_pks = ['id', 'ID', f'{table_name}_id', f'{table_name}_ID']
            pk_columns = [col for col in columns if col in standard_pks]

            if not pk_columns:
                # Use first column as PK
                pk_columns = [columns[0]] if columns else []
                messagebox.showwarning("Warning",
                                       f"Primary key not found. Using column '{pk_columns[0]}' as key.")

        if not pk_columns:
            messagebox.showerror("Error", "Failed to determine key column for update")
            return

        pk_column = pk_columns[0]  # Take first found PK

        dialog = RecordDialog(self, "Edit Record", columns, column_info, values)
        result = dialog.show()

        if result["confirmed"]:
            try:
                connection = DBConnection.get_connection()
                cursor = connection.cursor()

                # Form SET part of query (all columns except PK)
                set_parts = []
                new_values = []
                pk_value = None

                for column, new_value in zip(columns, result["values"]):
                    if column == pk_column:
                        pk_value = new_value
                        continue

                    set_parts.append(f"{column} = ?")
                    new_values.append(new_value)

                new_values.append(pk_value)  # For WHERE condition

                query = f"""
                UPDATE {table_name} 
                SET {', '.join(set_parts)} 
                WHERE {pk_column} = ?
                """
                cursor.execute(query, new_values)
                connection.commit()

                self.load_data()
                messagebox.showinfo("Success", "Record updated successfully")

            except Exception as e:
                messagebox.showerror("Error", f"Failed to update record:\n{str(e)}")

    def _check_dependencies(self, table_name: str, pk_column: str, pk_value) -> List[str]:
        """Checks dependencies before deletion"""
        try:
            connection = DBConnection.get_connection()
            cursor = connection.cursor()

            # Find all FKs referencing this table
            fk_query = """
            SELECT 
                fk.name AS FK_Name,
                tp.name AS Parent_Table,
                cp.name AS Parent_Column,
                tr.name AS Referenced_Table,
                cr.name AS Referenced_Column
            FROM sys.foreign_keys fk
            INNER JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
            INNER JOIN sys.tables tp ON fkc.parent_object_id = tp.object_id
            INNER JOIN sys.columns cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
            INNER JOIN sys.tables tr ON fkc.referenced_object_id = tr.object_id
            INNER JOIN sys.columns cr ON fkc.referenced_object_id = cr.object_id AND fkc.referenced_column_id = cr.column_id
            WHERE tr.name = ?
            """

            cursor.execute(fk_query, (table_name,))
            dependencies = cursor.fetchall()

            problem_dependencies = []

            for dependency in dependencies:
                parent_table = dependency[1]
                parent_column = dependency[2]

                # Check if there are records referencing this one
                cursor.execute(
                    f"SELECT COUNT(*) FROM {parent_table} WHERE {parent_column} = ?",
                    (pk_value,)
                )
                count = cursor.fetchone()[0]

                if count > 0:
                    problem_dependencies.append(f"Table '{parent_table}' contains {count} records referencing this one")

            return problem_dependencies

        except Exception as e:
            print(f"Dependency check error: {e}")
            return []

    def delete_record(self):
        """Deletes selected record"""
        selected = self.data_table.selection()
        if not selected:
            messagebox.showwarning("Warning", "Select a record to delete")
            return

        table_name = self.table_selector.get()
        columns = self.data_table["columns"]
        values = self.data_table.item(selected)["values"]
        column_info = self._get_column_info(table_name)

        # FIXED PRIMARY KEY LOGIC
        pk_columns = [column for column in columns
                      if column_info.get(column, {}).get('primary_key')]

        if not pk_columns:
            # If PK not found, try standard names
            standard_pks = ['id', 'ID', f'{table_name}_id', f'{table_name}_ID']
            pk_columns = [col for col in columns if col in standard_pks]

            if not pk_columns:
                # Use first column as PK
                pk_columns = [columns[0]] if columns else []
                messagebox.showwarning("Warning",
                                       f"Primary key not found. Using column '{pk_columns[0]}' for deletion.")

        if not pk_columns:
            messagebox.showerror("Error", "Failed to determine key column for deletion")
            return

        pk_column = pk_columns[0]  # Take first found PK
        pk_value = values[columns.index(pk_column)]

        # Check dependencies
        dependencies = self._check_dependencies(table_name, pk_column, pk_value)

        confirmation_msg = f"Are you sure you want to delete record {pk_column} = {pk_value}?"

        if dependencies:
            confirmation_msg += f"\n\nWARNING! Found dependencies:\n" + "\n".join(dependencies)
            confirmation_msg += "\n\nDeletion may cause errors. Continue?"

        if messagebox.askyesno("Confirmation", confirmation_msg):
            try:
                connection = DBConnection.get_connection()
                cursor = connection.cursor()

                cursor.execute(
                    f"DELETE FROM {table_name} WHERE {pk_column} = ?",
                    (pk_value,)
                )
                connection.commit()

                self.load_data()
                messagebox.showinfo("Success", "Record deleted successfully")

            except pyodbc.IntegrityError as e:
                error_msg = str(e)
                if "REFERENCE constraint" in error_msg or "DELETE statement conflicted" in error_msg:
                    messagebox.showerror(
                        "Data Integrity Error",
                        "Cannot delete record because it's referenced by other records in the database.\n\n"
                        "First delete all dependent records or change their references."
                    )
                else:
                    messagebox.showerror("Error", f"Data integrity error:\n{error_msg}")
            except Exception as e:
                messagebox.showerror("Error", f"Failed to delete record:\n{str(e)}")

    def cascade_delete(self):
        """Cascade deletion of record with dependencies"""
        selected = self.data_table.selection()
        if not selected:
            messagebox.showwarning("Warning", "Select a record for cascade deletion")
            return

        table_name = self.table_selector.get()
        columns = self.data_table["columns"]
        values = self.data_table.item(selected)["values"]
        column_info = self._get_column_info(table_name)

        # Find primary key
        pk_columns = [column for column in columns
                      if column_info.get(column, {}).get('primary_key')]

        if not pk_columns:
            standard_pks = ['id', 'ID', f'{table_name}_id', f'{table_name}_ID']
            pk_columns = [col for col in columns if col in standard_pks]

            if not pk_columns:
                pk_columns = [columns[0]] if columns else []

        if not pk_columns:
            messagebox.showerror("Error", "Failed to determine key column")
            return

        pk_column = pk_columns[0]
        pk_value = values[columns.index(pk_column)]

        # Get list of dependencies
        dependencies = self._check_dependencies(table_name, pk_column, pk_value)

        if not dependencies:
            messagebox.showinfo("Information", "No dependencies found. Use regular deletion.")
            return

        message = f"CASCADE DELETE of record {pk_column} = {pk_value}\n\n"
        message += "The following dependent records will be deleted:\n" + "\n".join(dependencies)
        message += "\n\nThis is IRREVERSIBLE! Continue?"

        if messagebox.askyesno("WARNING: Cascade Delete", message):
            try:
                connection = DBConnection.get_connection()
                cursor = connection.cursor()

                # First delete dependent records
                try:
                    # Find and delete dependent records
                    fk_query = """
                    SELECT 
                        tp.name AS Parent_Table,
                        cp.name AS Parent_Column
                    FROM sys.foreign_keys fk
                    INNER JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
                    INNER JOIN sys.tables tp ON fkc.parent_object_id = tp.object_id
                    INNER JOIN sys.columns cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
                    INNER JOIN sys.tables tr ON fkc.referenced_object_id = tr.object_id
                    WHERE tr.name = ?
                    """

                    cursor.execute(fk_query, (table_name,))
                    dependent_tables = cursor.fetchall()

                    deleted_records = 0

                    for dependent_table in dependent_tables:
                        parent_table = dependent_table[0]
                        parent_column = dependent_table[1]

                        cursor.execute(
                            f"DELETE FROM {parent_table} WHERE {parent_column} = ?",
                            (pk_value,)
                        )
                        deleted_records += cursor.rowcount

                    # Now delete the main record
                    cursor.execute(
                        f"DELETE FROM {table_name} WHERE {pk_column} = ?",
                        (pk_value,)
                    )
                    deleted_records += cursor.rowcount

                    connection.commit()
                    self.load_data()

                    messagebox.showinfo("Success",
                                        f"Cascade delete completed!\n"
                                        f"Total records deleted: {deleted_records}")

                except Exception as e:
                    connection.rollback()
                    raise e

            except Exception as e:
                messagebox.showerror("Error", f"Cascade delete error:\n{str(e)}")


if __name__ == "__main__":
    app = MainWindow()
    app.mainloop()