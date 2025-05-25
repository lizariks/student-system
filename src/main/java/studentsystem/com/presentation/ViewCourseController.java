package studentsystem.com.presentation;

import studentsystem.com.data.Course;
import studentsystem.com.data.Student;
import studentsystem.com.repositories.CourseRepository;
import studentsystem.com.repositories.StudentRepository;
import studentsystem.com.service.CustomUserDetailsService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
@RequestMapping("/student/course")
public class ViewCourseController {

    private final StudentRepository studentRepository;
    private final CourseRepository courseRepository;
    private final CustomUserDetailsService customUserDetailsService;

    public ViewCourseController(StudentRepository studentRepository,
                                CourseRepository courseRepository,
                                CustomUserDetailsService customUserDetailsService) {
        this.studentRepository = studentRepository;
        this.courseRepository = courseRepository;
        this.customUserDetailsService = customUserDetailsService;
    }

    @GetMapping("/{courseId}")
    public String viewCourseDetails(@PathVariable Long courseId, Model model, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        if (!authentication.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals("ROLE_STUDENT"))) {
            return "auth/access-denied";
        }

        String username = authentication.getName();
        Optional<Student> studentOpt = studentRepository.findByUsername(username);
        if (studentOpt.isEmpty()) {
            model.addAttribute("student", null);
            model.addAttribute("course", null);
            return "student/student-courses-details";
        }

        Student student = studentOpt.get();
        Optional<Course> courseOpt = courseRepository.findById(courseId);
        if (courseOpt.isEmpty()) {
            model.addAttribute("student", student);
            model.addAttribute("course", null);
            return "student/student-courses-details";
        }

        Course course = courseOpt.get();
        if (!student.getCourses().contains(course)) {
            model.addAttribute("student", student);
            model.addAttribute("course", null);
            return "student/student-courses-details";
        }

        model.addAttribute("student", student);
        model.addAttribute("course", course);
        return "student/student-courses-details";
    }
}

