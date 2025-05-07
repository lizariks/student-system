package studentsystem.com.presentation;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import studentsystem.com.data.Group;
import studentsystem.com.data.Role;
import studentsystem.com.data.Student;
import studentsystem.com.data.Teacher;
import studentsystem.com.dto.StudentSignupDTO;
import studentsystem.com.repositories.StudentRepository;
import studentsystem.com.repositories.TeacherRepository;
import studentsystem.com.repositories.GroupRepository;
import studentsystem.com.repositories.TeacherRepository;
import studentsystem.com.dto.TeacherSignupDTO;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Controller
@RequestMapping("/signup")
public class RegistrationController {
    private static final Logger logger = LoggerFactory.getLogger(RegistrationController.class);
    private final StudentRepository studentRepo;
    private final TeacherRepository teacherRepo;
    private final GroupRepository groupRepository;
    private final PasswordEncoder passwordEncoder;

    public RegistrationController(StudentRepository studentRepo,
                                  TeacherRepository teacherRepo,
                                  GroupRepository groupRepository,
                                  PasswordEncoder passwordEncoder) {
        this.studentRepo = studentRepo;
        this.teacherRepo = teacherRepo;
        this.groupRepository = groupRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/students")
    public String showStudentForm(Model model) {
        StudentSignupDTO dto = new StudentSignupDTO();
        model.addAttribute("student", dto);
        model.addAttribute("userType", "student");

        List<Group> groups = StreamSupport
                .stream(groupRepository.findAll().spliterator(), false)
                .collect(Collectors.toList());
        logger.debug("Loaded {} groups for form", groups.size());
        model.addAttribute("groups", groups);
        return "auth/signup-student";
    }

    @PostMapping("/students")
    public String registerStudent(@ModelAttribute StudentSignupDTO dto, Model model) {
        if (studentRepo.findByUsername(dto.getUsername()).isPresent()) {
            addSignupModelAttributesStudent(model, dto, "Username already registered");
            return "auth/signup-student";
        }

        try {
            Student student = new Student();
            student.setUsername(dto.getUsername());
            student.setPassword(passwordEncoder.encode(dto.getPassword()));
            student.setEmail(dto.getEmail());
            student.setFirstName(dto.getFirstName());
            student.setLastName(dto.getLastName());

            if (dto.getGroupId() != null) {
                groupRepository.findById(dto.getGroupId())
                        .ifPresent(student::setGroup);
            }

            student.setRole(Role.STUDENT);
            studentRepo.save(student);

            return "redirect:/login?registered";
        } catch (Exception e) {
            addSignupModelAttributesStudent(model, dto, "Registration failed: " + e.getMessage());
            return "auth/signup-student";
        }
    }

    private void addSignupModelAttributesStudent(Model model, StudentSignupDTO dto, String errorMessage) {
        model.addAttribute("error", errorMessage);
        model.addAttribute("userType", "student");
        model.addAttribute("student", dto);
        model.addAttribute("groups", groupRepository.findAll());
    }

    @GetMapping("/teachers")
    public String showTeacherForm(Model model) {
        TeacherSignupDTO dto = new TeacherSignupDTO();
        model.addAttribute("teacher", dto);
        model.addAttribute("userType", "teacher");
        return "auth/signup-teacher";
    }

    @PostMapping("/teachers")
    public String registerTeacher(@ModelAttribute TeacherSignupDTO dto, Model model) {
        if (teacherRepo.findByUsername(dto.getUsername()).isPresent()) {
            addSignupModelAttributesTeacher(model, dto, "Username already registered");
            return "auth/signup-teacher";
        }

        try {
            Teacher teacher = new Teacher();
            teacher.setUsername(dto.getUsername());
            teacher.setPassword(passwordEncoder.encode(dto.getPassword()));
            teacher.setEmail(dto.getEmail());
            teacher.setFirstName(dto.getFirstName());
            teacher.setLastName(dto.getLastName());
            teacher.setRole(Role.TEACHER);
            teacherRepo.save(teacher);
            return "redirect:/login?registered";
        } catch (Exception e) {
            addSignupModelAttributesTeacher(model, dto, "Registration failed: " + e.getMessage());
            return "auth/signup-teacher";
        }
    }
    private void addSignupModelAttributesTeacher(Model model, TeacherSignupDTO dto, String errorMessage) {
        model.addAttribute("error", errorMessage);
        model.addAttribute("userType", "teacher");
        model.addAttribute("teacher", dto);
    }
}