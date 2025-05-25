package studentsystem.com.presentation;


import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import studentsystem.com.data.Student;
import studentsystem.com.repositories.StudentRepository;
import studentsystem.com.service.CustomUserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;


@Controller
public class StudentProfileController {

    private final CustomUserDetailsService customUserDetailsService;
    private final StudentRepository studentRepository;
    private final PasswordEncoder passwordEncoder;

    public StudentProfileController(CustomUserDetailsService customUserDetailsService,  StudentRepository studentRepository, PasswordEncoder passwordEncoder) {
        this.customUserDetailsService = customUserDetailsService;
        this.studentRepository=studentRepository;
        this.passwordEncoder=passwordEncoder;
    }

    @GetMapping("/student/profile")
    public String studentProfile(Model model, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        if (!authentication.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals("ROLE_STUDENT"))) {
            return "auth/access-denied";
        }

        String username = authentication.getName();
        UserDetails student = customUserDetailsService.loadUserByUsername(username);
        model.addAttribute("student", student);

        return "student/student-profile";
    }

    @PostMapping("/student/profile/update")
    public String updateProfile(@ModelAttribute("student") Student updatedStudent,
                                @RequestParam(value = "newPassword", required = false) String newPassword,
                                Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        if (!authentication.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals("ROLE_STUDENT"))) {
            return "auth/access-denied";
        }

        String username = authentication.getName();
        Student existingStudent = studentRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Student not found"));

        existingStudent.setFirstName(updatedStudent.getFirstName());
        existingStudent.setLastName(updatedStudent.getLastName());
        existingStudent.setEmail(updatedStudent.getEmail());
        if (newPassword != null && !newPassword.isEmpty()) {
            String encodedPassword = passwordEncoder.encode(newPassword);
            existingStudent.setPassword(encodedPassword);
        }

        studentRepository.save(existingStudent);

        return "redirect:/student/profile?success";
    }


}
