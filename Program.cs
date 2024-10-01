using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;

namespace SchoolSearch
{
    class Student
    {
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public int Grade { get; set; }
        public int Classroom { get; set; }
        public int Bus { get; set; }

        public static Student Parse(string line)
        {
            var parts = line.Split(',');
            return new Student
            {
                LastName = parts[0].Trim(),
                FirstName = parts[1].Trim(),
                Grade = int.Parse(parts[2]),
                Classroom = int.Parse(parts[3]),
                Bus = int.Parse(parts[4])
            };
        }

        public override string ToString()
        {
            return $"{FirstName} {LastName}, Grade: {Grade}, Classroom: {Classroom}, Bus: {Bus}";
        }
    }

    class Teacher
    {
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public int Classroom { get; set; }

        public static Teacher Parse(string line)
        {
            var parts = line.Split(',');
            return new Teacher
            {
                LastName = parts[0].Trim(),
                FirstName = parts[1].Trim(),
                Classroom = int.Parse(parts[2])
            };
        }

        public override string ToString()
        {
            return $"{FirstName} {LastName}, Classroom: {Classroom}";
        }
    }

    class Program
    {
        static List<Student> students = new List<Student>();
        static List<Teacher> teachers = new List<Teacher>();

        static void Main(string[] args)
        {
            string studentFilePath = @"D:\универ\БД\pract2\list.txt";
            string teacherFilePath = @"D:\универ\БД\pract2\teachers.txt";

            if (!LoadData(studentFilePath, teacherFilePath))
            {
                Console.WriteLine("Error: Files not found. Program will exit.");
                return;
            }

            while (true)
            {
                ShowMenu();
                var input = Console.ReadLine();
                if (input == null || input.Trim() == "8")
                    break;

                ProcessCommand(input);
            }
        }

        static void ShowMenu()
        {
            Console.WriteLine("\n--- Student Search Menu ---");
            Console.WriteLine("1. Search student by last name");
            Console.WriteLine("2. Search bus by student last name");
            Console.WriteLine("3. Search students by teacher last name");
            Console.WriteLine("4. Search students by classroom number");
            Console.WriteLine("5. Search students by bus number");
            Console.WriteLine("6. Search student by full name");
            Console.WriteLine("7. Search students by classroom and bus number");
            Console.WriteLine("8. Exit");
            Console.Write("Choose an option: ");
        }

        static bool LoadData(string studentFilePath, string teacherFilePath)
        {
            if (File.Exists(studentFilePath))
            {
                var studentLines = File.ReadAllLines(studentFilePath);
                foreach (var line in studentLines)
                {
                    students.Add(Student.Parse(line));
                }
            }
            else
            {
                Console.WriteLine("Student file not found.");
                return false;
            }

            if (File.Exists(teacherFilePath))
            {
                var teacherLines = File.ReadAllLines(teacherFilePath);
                foreach (var line in teacherLines)
                {
                    teachers.Add(Teacher.Parse(line));
                }
            }
            else
            {
                Console.WriteLine("Teacher file not found.");
                return false;
            }

            Console.WriteLine("Data successfully loaded.");
            return true;
        }

        static void ProcessCommand(string input)
        {
            switch (input)
            {
                case "1":
                    Console.Write("Enter student last name: ");
                    var studentLastName = Console.ReadLine();
                    MeasureTime(() => FindStudent(studentLastName));
                    break;

                case "2":
                    Console.Write("Enter student last name: ");
                    var studentLastNameBus = Console.ReadLine();
                    MeasureTime(() => FindStudentBus(studentLastNameBus));
                    break;

                case "3":
                    Console.Write("Enter teacher last name: ");
                    var teacherLastName = Console.ReadLine();
                    MeasureTime(() => FindStudentsByTeacher(teacherLastName));
                    break;

                case "4":
                    Console.Write("Enter classroom number: ");
                    if (int.TryParse(Console.ReadLine(), out var classroom))
                    {
                        MeasureTime(() => FindStudentsByClassroom(classroom));
                    }
                    else
                    {
                        Console.WriteLine("Invalid classroom number.");
                    }
                    break;

                case "5":
                    Console.Write("Enter bus number: ");
                    if (int.TryParse(Console.ReadLine(), out var busNumber))
                    {
                        MeasureTime(() => FindStudentsByBus(busNumber));
                    }
                    else
                    {
                        Console.WriteLine("Invalid bus number.");
                    }
                    break;

                case "6":
                    Console.Write("Enter student full name (First Last): ");
                    var fullName = Console.ReadLine();
                    var nameParts = fullName.Split(' ');
                    if (nameParts.Length == 2)
                    {
                        MeasureTime(() => FindStudentByFullName(nameParts[0], nameParts[1]));
                    }
                    else
                    {
                        Console.WriteLine("Please enter a valid full name (First Last).");
                    }
                    break;

                case "7":
                    Console.Write("Enter classroom number: ");
                    if (int.TryParse(Console.ReadLine(), out var classNum))
                    {
                        Console.Write("Enter bus number: ");
                        if (int.TryParse(Console.ReadLine(), out var busNum))
                        {
                            MeasureTime(() => FindStudentsByClassroomAndBus(classNum, busNum));
                        }
                        else
                        {
                            Console.WriteLine("Invalid bus number.");
                        }
                    }
                    else
                    {
                        Console.WriteLine("Invalid classroom number.");
                    }
                    break;

                default:
                    Console.WriteLine("Unknown command. Please try again.");
                    break;
            }
        }

        static void MeasureTime(Action searchAction)
        {
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();  // Початок вимірювання часу

            searchAction.Invoke();  // Виклик пошуку

            stopwatch.Stop();  // Зупинка вимірювання часу
            Console.WriteLine($"Time taken for this operation: {stopwatch.ElapsedMilliseconds} ms");
        }

        static void FindStudent(string lastName)
        {
            var foundStudents = students.Where(s => s.LastName.ToUpper() == lastName.ToUpper()).ToList();
            if (foundStudents.Count > 0)
            {
                foreach (var student in foundStudents)
                {
                    Console.WriteLine(student);
                }
            }
            else
            {
                Console.WriteLine("Student not found.");
            }
        }

        static void FindStudentBus(string lastName)
        {
            var foundStudents = students.Where(s => s.LastName.ToUpper() == lastName.ToUpper()).ToList();
            if (foundStudents.Count > 0)
            {
                foreach (var student in foundStudents)
                {
                    Console.WriteLine($"{student.FirstName} {student.LastName}, Bus: {student.Bus}");
                }
            }
            else
            {
                Console.WriteLine("Student not found.");
            }
        }

        static void FindStudentsByTeacher(string teacherLastName)
        {
            var teacherClassrooms = teachers
                .Where(t => t.LastName.ToUpper() == teacherLastName.ToUpper())
                .Select(t => t.Classroom)
                .ToList();

            var foundStudents = students.Where(s => teacherClassrooms.Contains(s.Classroom)).ToList();

            if (foundStudents.Count > 0)
            {
                foreach (var student in foundStudents)
                {
                    Console.WriteLine($"{student.FirstName} {student.LastName}");
                }
            }
            else
            {
                Console.WriteLine("No students found for this teacher.");
            }
        }

        static void FindStudentsByClassroom(int classroom)
        {
            var foundStudents = students.Where(s => s.Classroom == classroom).ToList();
            if (foundStudents.Count > 0)
            {
                foreach (var student in foundStudents)
                {
                    Console.WriteLine($"{student.FirstName} {student.LastName}");
                }
            }
            else
            {
                Console.WriteLine("No students found in this classroom.");
            }
        }

        static void FindStudentsByBus(int busNumber)
        {
            var foundStudents = students.Where(s => s.Bus == busNumber).ToList();
            if (foundStudents.Count > 0)
            {
                foreach (var student in foundStudents)
                {
                    Console.WriteLine($"{student.FirstName} {student.LastName}, Classroom: {student.Classroom}");
                }
            }
            else
            {
                Console.WriteLine("No students found for this bus route.");
            }
        }

        static void FindStudentByFullName(string firstName, string lastName)
        {
            var foundStudents = students.Where(s => s.FirstName.ToUpper() == firstName.ToUpper() && s.LastName.ToUpper() == lastName.ToUpper()).ToList();
            if (foundStudents.Count > 0)
            {
                foreach (var student in foundStudents)
                {
                    Console.WriteLine(student);
                }
            }
            else
            {
                Console.WriteLine("Student not found.");
            }
        }

        static void FindStudentsByClassroomAndBus(int classroom, int bus)
        {
            var foundStudents = students.Where(s => s.Classroom == classroom && s.Bus == bus).ToList();
            if (foundStudents.Count > 0)
            {
                foreach (var student in foundStudents)
                {
                    Console.WriteLine(student);
                }
            }
            else
            {
                Console.WriteLine("No students found for this classroom and bus combination.");
            }
        }
    }
}
