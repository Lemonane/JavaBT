package ra.entity;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Scanner;

public class Student implements IEntity<Student> {
    private LocalDate birthday;
    private String studentID;
    private String studentName;
    private int age;
    private float mark_html;
    private float mark_css;
    private float mark_javascript;
    private boolean gender;
    private String studentRank;
    private float avgMark;


    // setter , getter
    public LocalDate getBirthday() {
        return birthday;
    }

    public void setBirthday(LocalDate birthday) {
        this.birthday = birthday;
    }

    public String getStudentID() {
        return studentID;
    }

    public void setStudentID(String studentID) {
        this.studentID = studentID;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public float getMark_html() {
        return mark_html;
    }

    public void setMark_html(float mark_html) {
        this.mark_html = mark_html;
    }

    public float getMark_css() {
        return mark_css;
    }

    public void setMark_css(float mark_css) {
        this.mark_css = mark_css;
    }

    public float getMark_javascript() {
        return mark_javascript;
    }

    public void setMark_javascript(float mark_javascript) {
        this.mark_javascript = mark_javascript;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getStudentRank() {
        return studentRank;
    }

    public void setStudentRank(String studentRank) {
        this.studentRank = studentRank;
    }

    public float getAvgMark() {
        return avgMark;
    }

    public void setAvgMark(float avgMark) {
        this.avgMark = avgMark;
    }

    public Student() {
    }

    public Student(LocalDate birthday, String studentID, String studentName,
                   int age, float mark_html, float mark_css, float mark_javascript,
                   boolean gender, String studentRank, float avgMark) {
        this.birthday = birthday;
        this.studentID = studentID;
        this.studentName = studentName;
        this.age = age;
        this.mark_html = mark_html;
        this.mark_css = mark_css;
        this.mark_javascript = mark_javascript;
        this.gender = gender;
        this.studentRank = studentRank;
        this.avgMark = avgMark;
    }

    /**
     * Input student infomation
     *
     * @param scanner : scanner
     */
    @Override
    public void inputData(Scanner scanner, List<Student> list) {
        // ID student validate
        System.out.print("Nhập Mã sinh viên (phải bắt đầu bằng 'S' và gồm 4 ký tự): ");
        studentID = scanner.nextLine();
        while (!studentID.matches("^S\\w{3}$")) {
            System.err.print("Mã sinh viên không hợp lệ! Vui lòng nhập lại: ");
            studentID = scanner.nextLine();
        }

        // tên validate
        System.out.print("Nhập Tên sinh viên (6-50 ký tự): ");
        studentName = scanner.nextLine();
        while (studentName.length() < 6 || studentName.length() > 50) {
            System.err.print("Tên sinh viên không hợp lệ! Vui lòng nhập lại: ");
            studentName = scanner.nextLine();
        }
        // validate birthday

        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate birthday = null;
        boolean validDate = false;

        while (!validDate) {
            System.out.print("Nhập ngày sinh (yyyy-MM-dd): ");
            String dateString = scanner.nextLine();

            try {
                birthday = LocalDate.parse(dateString, dateFormatter);
                if (birthday.getYear() >= 2005) {
                    System.out.println("Năm sinh phải trước năm 2005.");
                } else {
                    validDate = true;
                }
            } catch (Exception e) {
                System.err.println("Ngày không hợp lệ. Vui lòng nhập lại.");
            }
        }

        this.birthday = birthday;


        System.out.print("Nhập Điểm HTML (0-10): ");
        mark_html = scanner.nextFloat();
        while (mark_html < 0 || mark_html > 10) {
            System.err.print("Điểm HTML không hợp lệ! Vui lòng nhập lại: ");
            mark_html = scanner.nextFloat();
        }

        System.out.print("Nhập Điểm CSS (0-10): ");
        mark_css = scanner.nextFloat();
        while (mark_css < 0 || mark_css > 10) {
            System.err.print("Điểm CSS không hợp lệ! Vui lòng nhập lại: ");
            mark_css = scanner.nextFloat();
        }

        System.out.print("Nhập Điểm JavaScript (0-10): ");
        mark_javascript = scanner.nextFloat();
        while (mark_javascript < 0 || mark_javascript > 10) {
            System.err.print("Điểm JavaScript không hợp lệ! Vui lòng nhập lại: ");
            mark_javascript = scanner.nextFloat();
        }

        scanner.nextLine(); // Tiêu thụ ký tự xuống dòng
        System.out.print("Nhập Giới tính sinh viên (true cho nam, false cho nữ): ");
        String gender;
        gender = scanner.nextLine().toLowerCase();
        while (true) {
            if (gender.equals("true")) {
                this.gender = true;
                break;
            } else if (gender.equals("false")) {
                this.gender = false;
                break;
            }
        }
    }

    @Override
    // Display data method
    public void displayData() {
        System.out.println("Student ID: " + studentID);
        System.out.println("Student Name: " + studentName);
        System.out.println("Birthday: " + birthday);
        System.out.println("Age: " + age);
        System.out.println("HTML Mark: " + mark_html);
        System.out.println("CSS Mark: " + mark_css);
        System.out.println("JavaScript Mark: " + mark_javascript);
        System.out.println("Average Mark: " + String.format("%.2f",avgMark) );
        System.out.println("Gender: " + (gender ? "Male" : "Female"));
        System.out.println("Student Rank: " + studentRank);
        System.out.println();
    }

    // Calculate average mark method
    public float calAvgMark() {
        return (mark_html + mark_css + mark_javascript) / 3;
    }

    // Calculate student rank method
    public String calRank() {
        if (avgMark >= 9) {
            return "Xuất sắc";
        } else if (avgMark >= 8) {
            return "Giỏi";
        } else if (avgMark >= 7) {
            return "Khá";
        } else if (avgMark >= 5) {
            return "Trung bình";
        } else {
            return "Yếu";
        }
    }

    // Calculate student status method
    @Override
    public void calAge() {
        age = LocalDate.now().getYear() - birthday.getYear();
    }

    @Override
    public void calAvgMark_Rank() {
        avgMark = calAvgMark();
        studentRank = calRank();
    }
}
