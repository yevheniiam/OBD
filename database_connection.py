import pyodbc
from tkinter import messagebox


class DBConnection:
    """Class for managing SQL Server connection"""
    _instance = None

    @classmethod
    def get_connection(cls):
        if cls._instance is None:
            try:
                cls._instance = pyodbc.connect(
                    'DRIVER={ODBC Driver 17 for SQL Server};'
                    'SERVER=DESKTOP-A3O4UAF;'
                    'DATABASE=INSURANCE_COMPANY;'
                    'Trusted_Connection=yes;'
                )
                print("Successfully connected to database")
            except pyodbc.Error as e:
                messagebox.showerror("Connection Error", f"Failed to connect to database:\n{str(e)}")
                raise
        return cls._instance