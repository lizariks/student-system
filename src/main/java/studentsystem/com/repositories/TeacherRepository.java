package studentsystem.com.repositories;


import org.springframework.data.repository.CrudRepository;
import studentsystem.com.data.Course;
import studentsystem.com.data.Teacher;

import java.util.List;
import java.util.Optional;

public interface TeacherRepository extends CrudRepository<Teacher, Long> {
    Optional<Teacher> findByUsername(String username);
}
