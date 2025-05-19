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

    public String getName() {
        return groupName;
    }

    public Long getId() {
        return id;
    }
}
