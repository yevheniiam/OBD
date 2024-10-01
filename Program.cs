using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;

namespace SchoolSearch
{
    // Клас для зберігання інформації про студента
    class Student
    {
        public string LastName { get; set; }  // Прізвище студента
        public string FirstName { get; set; }  // Ім'я студента
        public int Grade { get; set; }  // Клас, у якому навчається студент
        public int Classroom { get; set; }  // Номер класної кімнати
        public int Bus { get; set; }  // Номер автобуса

        // Метод для перетворення рядка з файлу у об'єкт Student
        public static Student Parse(string line)
        {
            // Розділяємо дані про студента через кому
            var parts = line.Split(',');
            return new Student
            {
                LastName = parts[0].Trim(),  // Прізвище
                FirstName = parts[1].Trim(),  // Ім'я
                Grade = int.Parse(parts[2]),  // Клас
                Classroom = int.Parse(parts[3]),  // Класна кімната
                Bus = int.Parse(parts[4])  // Автобус
            };
        }

        // Метод для зручного виведення інформації про студента
        public override string ToString()
        {
            return $"{FirstName} {LastName}, Grade: {Grade}, Classroom: {Classroom}, Bus: {Bus}";
        }
    }

    // Клас для зберігання інформації про вчителя
    class Teacher
    {
        public string LastName { get; set; }  // Прізвище вчителя
        public string FirstName { get; set; }  // Ім'я вчителя
        public int Classroom { get; set; }  // Номер класної кімнати

        // Метод для перетворення рядка з файлу у об'єкт Teacher
        public static Teacher Parse(string line)
        {
            // Розділяємо дані про вчителя через кому
            var parts = line.Split(',');
            return new Teacher
            {
                LastName = parts[0].Trim(),  // Прізвище
                FirstName = parts[1].Trim(),  // Ім'я
                Classroom = int.Parse(parts[2])  // Класна кімната
            };
        }

        // Метод для зручного виведення інформації про вчителя
        public override string ToString()
        {
            return $"{FirstName} {LastName}, Classroom: {Classroom}";
        }
    }

    class Program
    {
        // Список студентів
        static List<Student> students = new List<Student>();
        // Список вчителів
        static List<Teacher> teachers = new List<Teacher>();

        static void Main(string[] args)
        {
            // Шляхи до файлів з даними
            string studentFilePath = @"D:\универ\БД\pract2\list.txt";
            string teacherFilePath = @"D:\универ\БД\pract2\teachers.txt";

            // Завантаження даних про студентів та вчителів з файлів
            if (!LoadData(studentFilePath, teacherFilePath))
            {
                Console.WriteLine("Error: Files not found. Program will exit.");
                return;
            }

            // Основний цикл програми
            while (true)
            {
                ShowMenu();  // Виведення меню на екран
                var input = Console.ReadLine();  // Отримання вибору користувача
                if (input == null || input.Trim() == "8")  // Вихід з програми, якщо вибрано 8
                    break;

                // Обробка введеної команди
                ProcessCommand(input);
            }
        }

        // Метод для виведення меню користувача
        static void ShowMenu()
        {
            Console.WriteLine("\n--- Student Search Menu ---");
            Console.WriteLine("1. Search student by last name");  // Пошук студента за прізвищем
            Console.WriteLine("2. Search bus by student last name");  // Пошук автобуса за прізвищем студента
            Console.WriteLine("3. Search students by teacher last name");  // Пошук студентів за прізвищем вчителя
            Console.WriteLine("4. Search students by classroom number");  // Пошук студентів за номером класу
            Console.WriteLine("5. Search students by bus number");  // Пошук студентів за номером автобуса
            Console.WriteLine("6. Search student by full name");  // Пошук студента за повним ім'ям
            Console.WriteLine("7. Search students by classroom and bus number");  // Пошук студентів за класом та автобусом
            Console.WriteLine("8. Exit");  // Вихід з програми
            Console.Write("Choose an option: ");
        }

        // Метод для завантаження даних з файлів
        static bool LoadData(string studentFilePath, string teacherFilePath)
        {
            // Завантаження даних про студентів
            if (File.Exists(studentFilePath))
            {
                var studentLines = File.ReadAllLines(studentFilePath);
                foreach (var line in studentLines)
                {
                    students.Add(Student.Parse(line));  // Додавання студентів у список
                }
            }
            else
            {
                Console.WriteLine("Student file not found.");
                return false;  // Повертаємо false, якщо файл не знайдено
            }

            // Завантаження даних про вчителів
            if (File.Exists(teacherFilePath))
            {
                var teacherLines = File.ReadAllLines(teacherFilePath);
                foreach (var line in teacherLines)
                {
                    teachers.Add(Teacher.Parse(line));  // Додавання вчителів у список
                }
            }
            else
            {
                Console.WriteLine("Teacher file not found.");
                return false;  // Повертаємо false, якщо файл не знайдено
            }

            Console.WriteLine("Data successfully loaded.");
            return true;  // Повертаємо true, якщо дані успішно завантажені
        }

        // Метод для обробки команди користувача
        static void ProcessCommand(string input)
        {
            switch (input)
            {
                case "1":  // Пошук студента за прізвищем
                    Console.Write("Enter student last name: ");
                    var studentLastName = Console.ReadLine();
                    MeasureTime(() => FindStudent(studentLastName));  // Вимірюємо час пошуку
                    break;

                case "2":  // Пошук автобуса за прізвищем студента
                    Console.Write("Enter student last name: ");
                    var studentLastNameBus = Console.ReadLine();
                    MeasureTime(() => FindStudentBus(studentLastNameBus));  // Вимірюємо час пошуку
                    break;

                case "3":  // Пошук студентів за прізвищем вчителя
                    Console.Write("Enter teacher last name: ");
                    var teacherLastName = Console.ReadLine();
                    MeasureTime(() => FindStudentsByTeacher(teacherLastName));  // Вимірюємо час пошуку
                    break;

                case "4":  // Пошук студентів за номером класної кімнати
                    Console.Write("Enter classroom number: ");
                    if (int.TryParse(Console.ReadLine(), out var classroom))
                    {
                        MeasureTime(() => FindStudentsByClassroom(classroom));  // Вимірюємо час пошуку
                    }
                    else
                    {
                        Console.WriteLine("Invalid classroom number.");  // Виводимо повідомлення про помилку
                    }
                    break;

                case "5":  // Пошук студентів за номером автобуса
                    Console.Write("Enter bus number: ");
                    if (int.TryParse(Console.ReadLine(), out var busNumber))
                    {
                        MeasureTime(() => FindStudentsByBus(busNumber));  // Вимірюємо час пошуку
                    }
                    else
                    {
                        Console.WriteLine("Invalid bus number.");  // Виводимо повідомлення про помилку
                    }
                    break;

                case "6":  // Пошук студента за повним ім'ям
                    Console.Write("Enter student full name (First Last): ");
                    var fullName = Console.ReadLine();
                    var nameParts = fullName.Split(' ');
                    if (nameParts.Length == 2)
                    {
                        MeasureTime(() => FindStudentByFullName(nameParts[0], nameParts[1]));  // Вимірюємо час пошуку
                    }
                    else
                    {
                        Console.WriteLine("Please enter a valid full name (First Last).");  // Виводимо повідомлення про помилку
                    }
                    break;

                case "7":  // Пошук студентів за номером класної кімнати і автобуса
                    Console.Write("Enter classroom number: ");
                    if (int.TryParse(Console.ReadLine(), out var classNum))
                    {
                        Console.Write("Enter bus number: ");
                        if (int.TryParse(Console.ReadLine(), out var busNum))
                        {
                            MeasureTime(() => FindStudentsByClassroomAndBus(classNum, busNum));  // Вимірюємо час пошуку
                        }
                        else
                        {
                            Console.WriteLine("Invalid bus number.");  // Виводимо повідомлення про помилку
                        }
                    }
                    else
                    {
                        Console.WriteLine("Invalid classroom number.");  // Виводимо повідомлення про помилку
                    }
                    break;

                default:
                    Console.WriteLine("Unknown command. Please try again.");  // Виводимо повідомлення про помилку, якщо команда невідома
                    break;
            }
        }

        // Метод для вимірювання часу виконання пошуку
        static void MeasureTime(Action searchAction)
        {
            Stopwatch stopwatch = new Stopwatch();  // Створюємо об'єкт для вимірювання часу
            stopwatch.Start();  // Початок вимірювання часу

            searchAction.Invoke();  // Виконання пошукової дії

            stopwatch.Stop();  // Зупинка вимірювання часу
            Console.WriteLine($"Time taken for this operation: {stopwatch.ElapsedMilliseconds} ms");  // Виведення часу виконання
        }

        // Методи пошуку студентів за різними критеріями
        static void FindStudent(string lastName)
        {
            var foundStudents = students.Where(s => s.LastName.ToUpper() == lastName.ToUpper()).ToList();
            if (foundStudents.Count > 0)
            {
                foreach (var student in foundStudents)
                {
                    Console.WriteLine(student);  // Виводимо інформацію про кожного знайденого студента
                }
            }
            else
            {
                Console.WriteLine("Student not found.");  // Виводимо повідомлення, якщо студент не знайдений
            }
        }

        static void FindStudentBus(string lastName)
        {
            var foundStudents = students.Where(s => s.LastName.ToUpper() == lastName.ToUpper()).ToList();
            if (foundStudents.Count > 0)
            {
                foreach (var student in foundStudents)
                {
                    Console.WriteLine($"{student.FirstName} {student.LastName}, Bus: {student.Bus}");  // Виводимо номер автобуса студента
                }
            }
            else
            {
                Console.WriteLine("Student not found.");  // Виводимо повідомлення, якщо студент не знайдений
            }
        }

        static void FindStudentsByTeacher(string teacherLastName)
        {
            // Знаходимо всі класи, які викладає цей вчитель
            var teacherClassrooms = teachers
                .Where(t => t.LastName.ToUpper() == teacherLastName.ToUpper())
                .Select(t => t.Classroom)
                .ToList();

            // Знаходимо всіх студентів, що навчаються у класах цього вчителя
            var foundStudents = students.Where(s => teacherClassrooms.Contains(s.Classroom)).ToList();

            if (foundStudents.Count > 0)
            {
                foreach (var student in foundStudents)
                {
                    Console.WriteLine($"{student.FirstName} {student.LastName}");  // Виводимо інформацію про знайдених студентів
                }
            }
            else
            {
                Console.WriteLine("No students found for this teacher.");  // Виводимо повідомлення, якщо студенти не знайдені
            }
        }

        static void FindStudentsByClassroom(int classroom)
        {
            var foundStudents = students.Where(s => s.Classroom == classroom).ToList();
            if (foundStudents.Count > 0)
            {
                foreach (var student in foundStudents)
                {
                    Console.WriteLine($"{student.FirstName} {student.LastName}");  // Виводимо інформацію про знайдених студентів
                }
            }
            else
            {
                Console.WriteLine("No students found in this classroom.");  // Виводимо повідомлення, якщо студенти не знайдені
            }
        }

        static void FindStudentsByBus(int busNumber)
        {
            var foundStudents = students.Where(s => s.Bus == busNumber).ToList();
            if (foundStudents.Count > 0)
            {
                foreach (var student in foundStudents)
                {
                    Console.WriteLine($"{student.FirstName} {student.LastName}, Classroom: {student.Classroom}");  // Виводимо інформацію про знайдених студентів
                }
            }
            else
            {
                Console.WriteLine("No students found for this bus route.");  // Виводимо повідомлення, якщо студенти не знайдені
            }
        }

        static void FindStudentByFullName(string firstName, string lastName)
        {
            var foundStudents = students.Where(s => s.FirstName.ToUpper() == firstName.ToUpper() && s.LastName.ToUpper() == lastName.ToUpper()).ToList();
            if (foundStudents.Count > 0)
            {
                foreach (var student in foundStudents)
                {
                    Console.WriteLine(student);  // Виводимо інформацію про знайденого студента
                }
            }
            else
            {
                Console.WriteLine("Student not found.");  // Виводимо повідомлення, якщо студент не знайдений
            }
        }

        static void FindStudentsByClassroomAndBus(int classroom, int bus)
        {
            var foundStudents = students.Where(s => s.Classroom == classroom && s.Bus == bus).ToList();
            if (foundStudents.Count > 0)
            {
                foreach (var student in foundStudents)
                {
                    Console.WriteLine(student);  // Виводимо інформацію про знайдених студентів
                }
            }
            else
            {
                Console.WriteLine("No students found for this classroom and bus combination.");  // Виводимо повідомлення, якщо студенти не знайдені
            }
        }
    }
}
