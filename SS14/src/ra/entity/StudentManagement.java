package ra.entity;

import java.util.*;

public class StudentManagement {
    private final List<Student> studentList;

    public StudentManagement() {
        studentList = new ArrayList<>();
    }

    public List<Student> getStudentList() {
        return studentList;
    }

    public void addStudents(Scanner scanner) {
        System.out.println("Nhập só lượng cần thêm");
        String text;
        int number;
        while (true) {
            try {
                text = scanner.nextLine();
                number = Integer.parseInt(text);
                break;
            } catch (NumberFormatException e) {
                System.err.println("Lỗi : input phải là số ! ");
            }
        }
        for (int i = 0; i < number; i++) {
            Student student = new Student();

            student.inputData(scanner, getStudentList());
            studentList.add(student);
            System.out.println(ColorText.GREEN_BRIGHT + "Thêm thành công" + ColorText.RESET);
        }
    }

    //
    public void evaluateStudents() {
        for (Student student : studentList) {
            System.out.println("Sinh viên " + student.getStudentName() + ": " + student.getStudentRank());
        }
    }

    public void displayAllStudents() {
        if (studentList.isEmpty()) {
            System.err.println("Chưa có sinh viên nào ");
            return;
        }
        System.out.println("--------------------------------------");
        System.out.println();
        for (Student student : studentList) {
            student.displayData();
        }
        System.out.println();
        System.out.println("--------------------------------------");

    }

    public void sortByAgeLowToHight() {
        studentList.sort(Comparator.comparingInt(Student::getAge));
        System.out.println("Danh sách sinh viên sau khi sắp xếp theo tuổi tăng dần :");
        displayAllStudents();
    }

    public void statisticsStudentByRank() {
        Map<String, Integer> rankCount = new HashMap<>();
        rankCount.put("Yếu", 0);
        rankCount.put("Trung bình", 0);
        rankCount.put("Khá", 0);
        rankCount.put("Giỏi", 0);
        rankCount.put("Xuất sắc", 0);

        for (Student student : studentList) {
            String rank = student.getStudentRank();
            rankCount.put(rank, rankCount.get(rank) + 1);
        }

        System.out.println("Thống kê sinh viên theo xếp loại:");
        for (Map.Entry<String, Integer> entry : rankCount.entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }
    }

    //
    public void updateStudentById(Scanner scanner) {
        try {
            System.out.println("** Hãy nhập hoặc mã sinh viên để thực hiện cập nhật thông tin");
            String input = scanner.nextLine();
            // logic
            Student foundStudent = studentList.stream()
                    .filter(student -> student.getStudentID().equals(input))
                    .findFirst().get();
            if (foundStudent == null) {
                System.err.println(" Không tìm thấy sinh viên, vui lòng nhập chính xác id SV !");
            }
            System.out.println(ColorText.GREEN_BRIGHT + "Đã tìm thấy sinh viên : " + foundStudent.getStudentName() + ColorText.RESET);
            System.out.println("***** Tiến hành cập nhật *****");
            foundStudent.inputData(scanner, studentList);
            System.out.println(ColorText.GREEN_BRIGHT + "Đã sửa đổi xong" + ColorText.RESET);
        } catch (NullPointerException e) {
            System.err.println("Danh mục đang chọn bị NUll");
        }
    }
    //

    public void searchStudentByName(Scanner scanner) {
        System.out.println("Nhập tên tên sinh viên cần tìm ");
        String input = scanner.nextLine();
        List<Student> filteredListStudent = studentList.stream().filter(student -> student.getStudentName().equalsIgnoreCase(input)).toList();
        filteredListStudent.forEach(Student::displayData);
        System.out.println(" -------- Tìm thấy " + filteredListStudent.size() + " SV --------");
        if (filteredListStudent.size() == 0) {
            System.err.println("Không tìm thấy sinh viên có tên " + input);
        }
    }

    public void calAgeStudents() {
        studentList.forEach(Student::calAge);
        System.out.println(ColorText.GREEN_BRIGHT + "Đã tính tuổi xong" + ColorText.RESET);
    }

    public void calAvgMarkToSetRank() {
        studentList.forEach(Student::calAvgMark_Rank);
        System.out.println(ColorText.GREEN_BRIGHT + "Đã thực hiện xong" + ColorText.RESET);
    }
}
