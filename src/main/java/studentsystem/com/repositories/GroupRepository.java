package studentsystem.com.repositories;


import org.springframework.data.repository.CrudRepository;
import studentsystem.com.data.Group;

public interface GroupRepository extends CrudRepository<Group, Long> {
}

