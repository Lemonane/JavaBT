import ra.entity.Student;
import ra.entity.StudentManagement;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        StudentManagement studentManagement = new StudentManagement();
        List<Student> studentList = studentManagement.getStudentList();
        // Đọc thông tin sinh viên từ file listStudent.txt và thêm vào danh sách
        try (BufferedReader reader = new BufferedReader(new FileReader("listStudent.txt"))) {
            String line;
            //
            LocalDate birthday = null;
            String studentID = "";
            String studentName = "";
            int age = 0;
            float mark_html = 0;
            float mark_css = 0;
            float mark_javascript = 0;
            boolean gender = false;
            String studentRank = "";
            float avgMark = 0;
            Student student;
            //
            while ((line = reader.readLine()) != null) {
                if (line.startsWith("StudentID: ")) {
                    studentID = line.substring(11);
                } else if (line.startsWith("Student Name: ")) {
                    studentName = line.substring(14);
                } else if (line.startsWith("Birthday: ")) {
                    birthday = LocalDate.parse(line.substring(10));
                } else if (line.startsWith("Gender: ")) {
                    gender = Boolean.parseBoolean(line.substring(8));
                } else if (line.startsWith("Age: ")) {
                    age = Integer.parseInt(line.substring(5));
                } else if (line.startsWith("Mark HTML: ")) {
                    mark_html = Float.parseFloat(line.substring(11));
                } else if (line.startsWith("Mark CSS: ")) {
                    mark_css = Float.parseFloat(line.substring(9));
                } else if (line.startsWith("Mark JavaScript: ")) {
                    mark_javascript = Float.parseFloat(line.substring(17));
                } else if (line.startsWith("Rank: ")) {
                    studentRank = line.substring(6);
                } else if (line.trim().isEmpty()) {
                    student = new Student(birthday, studentID, studentName, age, mark_html, mark_css, mark_javascript,
                            gender, studentRank, avgMark);
                    studentList.add(student);
                }
            }

        } catch (IOException e) {
            System.out.println("Error reading from file: " + e.getMessage());
        }


        int choice = 0;
        do {
            try {
                System.out.println("*****************************MENU************************");
                System.out.println("1. Nhập thông tin các sinh viên");
                System.out.println("2. Tính tuổi các sinh viên");
                System.out.println("3. Tính điểm trung bình và xếp loại sinh viên");
                System.out.println("4. Hiển thị tất cả sinh viên đã lưu");
                System.out.println("5. Sắp xếp sinh viên theo tuổi tăng dần");
                System.out.println("6. Thống kê sinh viên theo xếp loại sinh viên");
                System.out.println("7. Cập nhật thông tin sinh viên theo mã sinh viên");
                System.out.println("8. Tìm kiếm sinh viên theo tên sinh viên");
                System.out.println("9. Thoát");
                System.out.print("Nhập lựa chọn: ");
                if (scanner.hasNextInt()) {
                    choice = scanner.nextInt();
                    scanner.nextLine();
                    switch (choice) {
                        case 1 -> studentManagement.addStudents(scanner);
                        case 2 -> studentManagement.calAgeStudents();
                        case 3 -> studentManagement.calAvgMarkToSetRank();
                        case 4 -> studentManagement.displayAllStudents();
                        case 5 ->
                            // Sắp xếp danh sách sinh viên theo tuổi tăng dần
                                studentManagement.sortByAgeLowToHight();
                        case 6 ->
                            // Thống kê sinh viên theo xếp loại sinh viên
                                studentManagement.statisticsStudentByRank();
                        case 7 ->
                            // Cập nhật thông tin sinh viên theo mã sinh viên
                                studentManagement.updateStudentById(scanner);

                        case 8 -> {
                            // Tìm kiếm sinh viên theo tên sinh viên
                            studentManagement.searchStudentByName(scanner);
                        }
                        case 9 -> {
                            // Thoát
                            try (PrintWriter writer = new PrintWriter("listStudent.txt")) {

                                for (Student student : studentList) {
                                    writer.println("StudentID: " + student.getStudentID());
                                    writer.println("Student Name: " + student.getStudentName());
                                    writer.println("Birthday: " + student.getBirthday());
                                    writer.println("Gender: " + student.isGender());
                                    writer.println("Age: " + student.getAge());
                                    writer.println("Mark HTML: " + student.getMark_html());
                                    writer.println("Mark CSS: " + student.getMark_css());
                                    writer.println("Mark JavaScript: " + student.getMark_javascript());
                                    writer.println("Rank: " + student.getAvgMark());
                                    writer.println();
                                }
                                System.out.println("Đã lưu về listStudent.txt");
                            } catch (IOException e) {
                                System.out.println("Error saving to file: " + e.getMessage());
                            }
                        }
                        default -> System.out.println("Lựa chọn không hợp lệ!");
                    }
                } else {
                    System.out.println("Lựa chọn không hợp lệ! Vui lòng nhập số.");
                    scanner.nextLine();
                }
            } catch (InputMismatchException e) {
                System.out.println("Error: " + e.getMessage());
                choice = 0;
            }
        } while (choice != 9);
    }
}
