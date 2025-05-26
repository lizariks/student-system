package studentsystem.com.presentation;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import studentsystem.com.data.Student;
import studentsystem.com.data.Teacher;
import studentsystem.com.repositories.TeacherRepository;
import studentsystem.com.service.CustomUserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;

@Controller
public class TeacherProfileController {

    private final CustomUserDetailsService customUserDetailsService;
    private final TeacherRepository teacherRepository;
    private final PasswordEncoder passwordEncoder;

    public TeacherProfileController(CustomUserDetailsService customUserDetailsService, TeacherRepository teacherRepository,PasswordEncoder passwordEncoder) {
        this.customUserDetailsService = customUserDetailsService;
        this.teacherRepository = teacherRepository;
        this.passwordEncoder = passwordEncoder;
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
    @PostMapping("/teacher/profile/update")
    public String updateProfile(@ModelAttribute("teacher") Teacher updatedTeacher,
                                @RequestParam(value = "newPassword", required = false) String newPassword,
                                Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        if (!authentication.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals("ROLE_TEACHER"))) {
            return "auth/access-denied";
        }

        String username = authentication.getName();
        Teacher existingTeacher = teacherRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Teacher not found"));

        existingTeacher.setFirstName(updatedTeacher.getFirstName());
        existingTeacher.setLastName(updatedTeacher.getLastName());
        existingTeacher.setEmail(updatedTeacher.getEmail());
        if (newPassword != null && !newPassword.isEmpty()) {
            String encodedPassword = passwordEncoder.encode(newPassword);
            existingTeacher.setPassword(encodedPassword);
        }

        teacherRepository.save(existingTeacher);

        return "redirect:/teacher/profile?success";
    }

}

