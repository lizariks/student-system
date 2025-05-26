package studentsystem.com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studentsystem.com.data.Student;
import studentsystem.com.data.Teacher;
import studentsystem.com.repositories.StudentRepository;
import studentsystem.com.repositories.TeacherRepository;

import java.util.List;
import java.util.Optional;

@Service
public class TeacherServiceImpl implements TeacherService {

    private final StudentRepository studentRepository;
    private final TeacherRepository teacherRepository;

    @Autowired
    public TeacherServiceImpl(StudentRepository studentRepository, TeacherRepository teacherRepository) {
        this.studentRepository = studentRepository;
        this.teacherRepository = teacherRepository;
    }

    @Override
    public List<Student> findStudentsByGroupId(Long groupId) {
        return studentRepository.findByGroupId(groupId);
    }

    @Override
    public Optional<Student> findStudentById(Long studentId) {
        return studentRepository.findById(studentId);
    }

    @Override
    public List<Student> searchStudents(String keyword) {
        return studentRepository.findByFirstNameContainingIgnoreCaseOrLastNameContainingIgnoreCaseOrEmailContainingIgnoreCase(
                keyword, keyword, keyword
        );
    }

    @Override
    public Optional<Teacher> findTeacherByUsername(String username) {
        return teacherRepository.findByUsername(username);
    }
}

