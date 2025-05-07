package studentsystem.com.presentation;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import studentsystem.com.service.CustomUserDetailsService;

@Controller
public class TeacherProfileController {

    private final CustomUserDetailsService customUserDetailsService;

    public TeacherProfileController(CustomUserDetailsService customUserDetailsService) {
        this.customUserDetailsService = customUserDetailsService;
    }

    @GetMapping("/teacher/profile")
    public String teacherProfile(Model model, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        if (!authentication.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals("ROLE_TEACHER"))) {
            return "auth/access-denied";
        }

        String username = authentication.getName();
        UserDetails teacher = customUserDetailsService.loadUserByUsername(username);
        model.addAttribute("teacher", teacher);

        return "teacher/teacher-profile";
    }
}

