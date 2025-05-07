package studentsystem.com.repositories;


import org.springframework.data.repository.CrudRepository;
import studentsystem.com.data.Course;

public interface CourseRepository extends CrudRepository<Course, Long> {
}
