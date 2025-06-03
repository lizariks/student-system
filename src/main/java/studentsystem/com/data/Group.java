package studentsystem.com.data;

import jakarta.persistence.*;

import java.util.*;
import studentsystem.com.data.Student;

@Entity
@Table(name = "groups")
public class Group {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", nullable = false)
    private String groupName;

    @Column(nullable = false)
    private int year;

    @OneToMany(mappedBy = "group")
    private List<Student> students = new ArrayList<>();

    public Group() {}

    public Group(String groupName, int year) {
        this.groupName = groupName;
        this.year = year;
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return groupName;
    }

    public String getGroupName() {
        return groupName;
    }

    public int getYear() {
        return year;
    }

    public List<Student> getStudents() {
        return students;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public void setStudents(List<Student> students) {
        this.students = students;
    }

    public void addStudent(Student student) {
        students.add(student);
        student.setGroup(this);
    }

    public void removeStudent(Student student) {
        students.remove(student);
        student.setGroup(null);
    }
}
