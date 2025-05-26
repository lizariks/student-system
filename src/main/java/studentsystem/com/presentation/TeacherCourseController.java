package studentsystem.com.presentation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import studentsystem.com.data.Course;
import studentsystem.com.data.Teacher;
import studentsystem.com.service.CourseService;
import studentsystem.com.service.TeacherService;

import java.security.Principal;
import java.util.Optional;

@Controller
@RequestMapping("/teacher/course")
public class TeacherCourseController {

    private final CourseService courseService;
    private final TeacherService teacherService;


    @Autowired
    public TeacherCourseController(CourseService courseService, TeacherService teacherService) {
        this.courseService = courseService;
        this.teacherService = teacherService;
    }
    @GetMapping
    public String viewCourses(Model model, Principal principal) {
        String username = principal.getName();
        Optional<Teacher> teacherOpt = teacherService.findTeacherByUsername(username);

        if (teacherOpt.isPresent()) {
            Teacher teacher = teacherOpt.get();
            model.addAttribute("courses", courseService.findCoursesByTeacher(teacher));
            return "teacher/teacher-courses";
        }

        return "access-denied";
    }

    @GetMapping("/create")
    public String showAddCourseForm(Model model) {
        model.addAttribute("course", new Course());
        return "teacher/add-course";
    }

    @PostMapping("/create")
    public String addCourse(@ModelAttribute("course") Course course, Principal principal) {
        String username = principal.getName();
        Optional<Teacher> teacherOpt = teacherService.findTeacherByUsername(username);

        if (teacherOpt.isPresent()) {
            courseService.createCourse(course, teacherOpt.get());
            return "redirect:/teacher/course";
        }

        return "error";
    }

    @GetMapping("/edit/{id}")
    public String showEditCourseForm(@PathVariable Long id, Model model) {
        Optional<Course> courseOpt = courseService.findCourseById(id);

        if (courseOpt.isPresent()) {
            model.addAttribute("course", courseOpt.get());
            return "teacher/edit-course";
        }

        return "error";
    }

    @PostMapping("/edit/{id}")
    public String updateCourse(@PathVariable Long id, @ModelAttribute("course") Course updatedCourse) {
        try {
            courseService.updateCourse(id, updatedCourse);
            return "redirect:/teacher/course";
        } catch (RuntimeException e) {
            return "error";
        }
    }

    @GetMapping("/delete/{id}")
    public String deleteCourse(@PathVariable Long id) {
        courseService.deleteCourse(id);
        return "redirect:/teacher/course";
    }
}

