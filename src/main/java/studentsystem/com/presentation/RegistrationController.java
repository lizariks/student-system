package studentsystem.com.presentation;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import studentsystem.com.data.Role;
import studentsystem.com.data.Student;
import studentsystem.com.data.Teacher;
import studentsystem.com.repositories.StudentRepository;
import studentsystem.com.repositories.TeacherRepository;

@Controller
@RequestMapping("/register")
public class RegistrationController {

    private final StudentRepository studentRepo;
    private final TeacherRepository teacherRepo;
    private final PasswordEncoder passwordEncoder;

    public RegistrationController(StudentRepository s, TeacherRepository t, PasswordEncoder p) {
        this.studentRepo = s;
        this.teacherRepo = t;
        this.passwordEncoder = p;
    }

    @GetMapping("/student")
    public String showStudentForm(Model model) {
        model.addAttribute("student", new Student());
        return "register-student"; // Thymeleaf view
    }

    @PostMapping("/student")
    public String registerStudent(@ModelAttribute Student student) {
        student.setPassword(passwordEncoder.encode(student.getPassword()));
        student.setRole(Role.STUDENT);
        studentRepo.save(student);
        return "redirect:/login";
    }

    @GetMapping("/teacher")
    public String showTeacherForm(Model model) {
        model.addAttribute("teacher", new Teacher());
        return "register-teacher"; // Thymeleaf view
    }

    @PostMapping("/teacher")
    public String registerTeacher(@ModelAttribute Teacher teacher) {
        teacher.setPassword(passwordEncoder.encode(teacher.getPassword()));
        teacher.setRole(Role.TEACHER);
        teacherRepo.save(teacher);
        return "redirect:/login";
    }
}

