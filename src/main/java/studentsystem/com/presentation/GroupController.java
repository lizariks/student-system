package studentsystem.com.presentation;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import studentsystem.com.data.Group;
import studentsystem.com.data.Teacher;
import studentsystem.com.repositories.TeacherRepository;
import studentsystem.com.service.GroupService;

import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/teacher/groups")
public class GroupController {

    @Autowired
    private GroupService groupService;

    @Autowired
    private TeacherRepository teacherRepository;

    @GetMapping
    public String viewAllGroups(Model model, Principal principal, HttpSession session) {
        String username = principal.getName();
        Teacher teacher = teacherRepository.findByUsername(username).orElse(null);

        if (teacher == null) {
            return "redirect:/login";
        }
        session.setAttribute("teacher", teacher);

        List<Group> groups = groupService.getAllGroups();
        model.addAttribute("teacher", teacher);
        model.addAttribute("groups", groups);
        return "teacher/groups";
    }

    @GetMapping("/{id}")
    public String viewGroupDetails(@PathVariable Long id, Model model, Principal principal, HttpSession session) {
        String username = principal.getName();
        Teacher teacher = teacherRepository.findByUsername(username).orElse(null);

        if (teacher == null) {
            return "redirect:/auth/login";
        }

        Group group = groupService.getGroupById(id);
        if (group == null) {
            return "redirect:/teacher/groups";
        }
        session.setAttribute("teacher", teacher);

        model.addAttribute("teacher", teacher);
        model.addAttribute("group", group);
        return "teacher/group-details";
    }
}
