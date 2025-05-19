package studentsystem.com.presentation;

import jakarta.servlet.http.HttpSession;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import studentsystem.com.data.Course;
import studentsystem.com.data.Student;
import studentsystem.com.repositories.CourseRepository;
import studentsystem.com.repositories.StudentRepository;
import studentsystem.com.service.CustomUserDetailsService;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Controller
@RequestMapping("/student/course")
public class StudentCourseController {

    private final StudentRepository studentRepository;
    private final CourseRepository courseRepository;
    private final CustomUserDetailsService customUserDetailsService;

    public StudentCourseController(StudentRepository studentRepository, CourseRepository courseRepository, CustomUserDetailsService customUserDetailsService) {
        this.studentRepository = studentRepository;
        this.courseRepository = courseRepository;
        this.customUserDetailsService = customUserDetailsService;
    }

    @GetMapping("/register")
    public String showCourseRegistration(Model model, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        if (!authentication.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals("ROLE_STUDENT"))) {
            return "auth/access-denied";
        }

        String username = authentication.getName();
        Optional<Student> optionalStudent = studentRepository.findByUsername(username);

        if (optionalStudent.isEmpty()) {
            return "redirect:/login";
        }

        Student student = optionalStudent.get();

        List<Course> allCourses = (List<Course>) courseRepository.findAll();
        List<Course> availableCourses = allCourses.stream()
                .filter(course -> !student.getCourses().contains(course))
                .toList();

        model.addAttribute("student", student);
        model.addAttribute("courses", availableCourses);

        return "student/course-register";
    }


    @PostMapping("/register/{courseId}")
    public String registerCourse(@PathVariable Long courseId, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        String username = authentication.getName();

        Optional<Student> optionalStudent = studentRepository.findByUsername(username);
        if (optionalStudent.isEmpty()) {
            return "redirect:/login";
        }

        Student student = optionalStudent.get();

        Optional<Course> optionalCourse = courseRepository.findById(courseId);
        if (optionalCourse.isPresent()) {
            Course course = optionalCourse.get();

            if (student.getCourses() == null) {
                student.setCourses(new HashSet<>());
            }

            if (!student.getCourses().contains(course)) {
                student.getCourses().add(course);
                studentRepository.save(student);
            }
        }

        return "redirect:/student-home";
    }

}

