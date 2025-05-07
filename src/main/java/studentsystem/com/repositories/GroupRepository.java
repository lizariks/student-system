package studentsystem.com.repositories;


import org.springframework.data.repository.CrudRepository;
import studentsystem.com.data.Group;
import java.util.*;

import java.util.Optional;

public interface GroupRepository extends CrudRepository<Group, Long> {
}

