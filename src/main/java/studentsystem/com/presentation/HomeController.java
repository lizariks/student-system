package studentsystem.com.presentation;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.stereotype.Controller;
import studentsystem.com.data.Student;
import studentsystem.com.service.CustomUserDetailsService;

@Controller
public class HomeController {

    private final CustomUserDetailsService customUserDetailsService;

    public HomeController(CustomUserDetailsService customUserDetailsService) {
        this.customUserDetailsService = customUserDetailsService;
    }

    @GetMapping("/")
    public String homeRedirect(Authentication authentication) {
        if (authentication == null) {
            return "redirect:/login";
        }

        String role = authentication.getAuthorities().iterator().next().getAuthority();
        if (role.equals("ROLE_STUDENT")) {
            return "redirect:/student-home";
        } else if (role.equals("ROLE_TEACHER")) {
            return "redirect:/teacher-home";
        }
        else return "redirect:/access-denied";
    }

    @GetMapping("/student-home")
    public String studentHome(Model model, Authentication authentication) {
        String username = authentication.getName();
        UserDetails student = customUserDetailsService.loadUserByUsername(username);
        model.addAttribute("student", student);
        return "student/student-home";
    }

    @GetMapping("/teacher-home")
    public String teacherHome(Model model, Authentication authentication) {
        String username = authentication.getName();
        UserDetails teacher = customUserDetailsService.loadUserByUsername(username);
        model.addAttribute("teacher", teacher);
        return "teacher/teacher-home";
    }

    @GetMapping("/access-denied")
    public String accessDenied() {
        return "auth/access-denied";
    }
}