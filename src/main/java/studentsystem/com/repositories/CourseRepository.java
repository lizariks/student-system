package studentsystem.com.repositories;


import org.springframework.data.repository.CrudRepository;
import studentsystem.com.data.Course;
import studentsystem.com.data.Teacher;

import java.util.List;

public interface CourseRepository extends CrudRepository<Course, Long> {
    List<Course> findByTeacher(Teacher teacher);
}
