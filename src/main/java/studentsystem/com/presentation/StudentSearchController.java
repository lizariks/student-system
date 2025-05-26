package studentsystem.com.presentation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import studentsystem.com.data.Student;
import studentsystem.com.service.TeacherService;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/teacher")
public class StudentSearchController {

    private final TeacherService teacherService;

    @Autowired
    public StudentSearchController(TeacherService teacherService) {
        this.teacherService = teacherService;
    }

    @GetMapping("/group/{groupId}")
    public String viewStudentsByGroup(@PathVariable Long groupId, Model model) {
        List<Student> students = teacherService.findStudentsByGroupId(groupId);
        model.addAttribute("students", students);
        return "students-by-group";
    }

    @GetMapping("/search")
    public String searchStudents(@RequestParam(required = false) String keyword, Model model) {
        List<Student> students;

        if (keyword == null || keyword.isBlank()) {
            students = List.of();
        } else {
            students = teacherService.searchStudents(keyword);
        }

        model.addAttribute("students", students);
        return "teacher/search-student";
    }


    @GetMapping("/{studentId:\\d+}")
    public String viewStudent(@PathVariable Long studentId, Model model) {
        Optional<Student> studentOpt = teacherService.findStudentById(studentId);

        if (studentOpt.isPresent()) {
            model.addAttribute("student", studentOpt.get());
            return "view-student";
        }

        return "error";
    }
}
