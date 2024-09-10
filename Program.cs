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
        public string TeacherLastName { get; set; }
        public string TeacherFirstName { get; set; }

        public static Student Parse(string line)
        {
            var parts = line.Split(',');
            return new Student
            {
                LastName = parts[0],
                FirstName = parts[1],
                Grade = int.Parse(parts[2]),
                Classroom = int.Parse(parts[3]),
                Bus = int.Parse(parts[4]),
                TeacherLastName = parts[5],
                TeacherFirstName = parts[6]
            };
        }

        public override string ToString()
        {
            return $"{FirstName} {LastName}, Grade: {Grade}, Classroom: {Classroom}, Bus: {Bus}, Teacher: {TeacherFirstName} {TeacherLastName}";
        }
    }

    class Program
    {
        static List<Student> students = new List<Student>();

        static void Main(string[] args)
        {
            // Check if the data file is available and load data
            string filePath = "../../students.txt";
            if (!LoadData(filePath))
            {
                Console.WriteLine("Error: File 'students.txt' not found. Program will exit.");
                return;  // Terminate the program if the file is not found
            }

            // Main menu
            while (true)
            {
                ShowMenu();
                var input = Console.ReadLine();

                if (input == null || input.Trim() == "6")
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
            Console.WriteLine("6. Exit");
            Console.Write("Choose an option: ");
        }

        static bool LoadData(string filePath)
        {
            if (File.Exists(filePath))
            {
                var lines = File.ReadAllLines(filePath);
                foreach (var line in lines)
                {
                    students.Add(Student.Parse(line));
                }
                Console.WriteLine("Data successfully loaded from 'students.txt'.");
                return true;
            }
            else
            {
                return false;
            }
        }

        static void ProcessCommand(string input)
        {
            switch (input)
            {
                case "1":
                    Console.Write("Enter student last name: ");
                    var studentLastName = Console.ReadLine();
                    FindStudent(studentLastName);
                    break;

                case "2":
                    Console.Write("Enter student last name: ");
                    var studentLastNameBus = Console.ReadLine();
                    FindStudentBus(studentLastNameBus);
                    break;

                case "3":
                    Console.Write("Enter teacher last name: ");
                    var teacherLastName = Console.ReadLine();
                    FindStudentsByTeacher(teacherLastName);
                    break;

                case "4":
                    Console.Write("Enter classroom number: ");
                    if (int.TryParse(Console.ReadLine(), out var classroom))
                    {
                        FindStudentsByClassroom(classroom);
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
                        FindStudentsByBus(busNumber);
                    }
                    else
                    {
                        Console.WriteLine("Invalid bus number.");
                    }
                    break;

                default:
                    Console.WriteLine("Unknown command. Please try again.");
                    break;
            }
        }

        // Tracking time for finding a student
        static void FindStudent(string lastName)
        {
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();  // Start timing the search

            var foundStudents = students.Where(s => s.LastName.ToUpper() == lastName.ToUpper()).ToList();

            stopwatch.Stop();  // Stop timing the search
            TimeSpan timeTaken = stopwatch.Elapsed;

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

            // Print the time taken
            Console.WriteLine($"Time taken for search: {timeTaken.TotalMilliseconds} ms\n");
        }

        // Tracking time for finding bus route by student last name
        static void FindStudentBus(string lastName)
        {
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();  // Start timing the search

            var foundStudents = students.Where(s => s.LastName.ToUpper() == lastName.ToUpper()).ToList();

            stopwatch.Stop();  // Stop timing the search
            TimeSpan timeTaken = stopwatch.Elapsed;

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

            // Print the time taken
            Console.WriteLine($"Time taken for search: {timeTaken.TotalMilliseconds} ms\n");
        }

        // Tracking time for finding students by teacher
        static void FindStudentsByTeacher(string teacherLastName)
        {
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();  // Start timing the search

            var foundStudents = students.Where(s => s.TeacherLastName.ToUpper() == teacherLastName.ToUpper()).ToList();

            stopwatch.Stop();  // Stop timing the search
            TimeSpan timeTaken = stopwatch.Elapsed;

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

            // Print the time taken
            Console.WriteLine($"Time taken for search: {timeTaken.TotalMilliseconds} ms\n");
        }

        // Tracking time for finding students by classroom number
        static void FindStudentsByClassroom(int classroom)
        {
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();  // Start timing the search

            var foundStudents = students.Where(s => s.Classroom == classroom).ToList();

            stopwatch.Stop();  // Stop timing the search
            TimeSpan timeTaken = stopwatch.Elapsed;

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

            // Print the time taken
            Console.WriteLine($"Time taken for search: {timeTaken.TotalMilliseconds} ms\n");
        }

        // Tracking time for finding students by bus number
        static void FindStudentsByBus(int busNumber)
        {
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();  // Start timing the search

            var foundStudents = students.Where(s => s.Bus == busNumber).ToList();

            stopwatch.Stop();  // Stop timing the search
            TimeSpan timeTaken = stopwatch.Elapsed;

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

            // Print the time taken
            Console.WriteLine($"Time taken for search: {timeTaken.TotalMilliseconds} ms\n");
        }
    }
}
