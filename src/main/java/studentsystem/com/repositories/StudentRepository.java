package studentsystem.com.repositories;

import org.springframework.data.repository.CrudRepository;
import studentsystem.com.data.Student;


import org.springframework.data.jpa.repository.JpaRepository;
import studentsystem.com.data.Student;

import java.util.List;
import java.util.Optional;

public interface StudentRepository extends CrudRepository<Student, Long> {
    Optional<Student> findByUsername(String username);
    List<Student> findByGroupId(Long groupId);

    List<Student> findByFirstNameContainingIgnoreCaseOrLastNameContainingIgnoreCaseOrEmailContainingIgnoreCase(
            String firstNameKeyword, String lastNameKeyword, String emailKeyword
    );
}

