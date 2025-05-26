package studentsystem.com.service;


import studentsystem.com.data.Course;
import studentsystem.com.data.Teacher;

import java.util.List;
import java.util.Optional;

public interface CourseService {
    Course createCourse(Course course, Teacher teacher);

    Course updateCourse(Long id, Course updatedCourse);

    void deleteCourse(Long id);

    List<Course> findCoursesByTeacher(Teacher teacher);

    Optional<Course> findCourseById(Long id);
}
