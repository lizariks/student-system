package studentsystem.com.service;


import studentsystem.com.data.Teacher;
import studentsystem.com.data.Student;

import java.util.List;
import java.util.Optional;

public interface TeacherService {
    List<Student> findStudentsByGroupId(Long groupId);

    Optional<Student> findStudentById(Long studentId);

    List<Student> searchStudents(String keyword);

    Optional<Teacher> findTeacherByUsername(String username);
}
