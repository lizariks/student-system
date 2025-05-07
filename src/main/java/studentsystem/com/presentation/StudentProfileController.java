package studentsystem.com.presentation;


import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import studentsystem.com.service.CustomUserDetailsService;

@Controller
public class StudentProfileController {

    private final CustomUserDetailsService customUserDetailsService;

    public StudentProfileController(CustomUserDetailsService customUserDetailsService) {
        this.customUserDetailsService = customUserDetailsService;
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
}
