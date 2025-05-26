package studentsystem.com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studentsystem.com.data.Group;
import studentsystem.com.repositories.GroupRepository;

import java.util.List;
import java.util.Optional;
import java.util.ArrayList;

@Service
public class GroupService {

    @Autowired
    private GroupRepository groupRepository;

    public List<Group> getAllGroups() {
        Iterable<Group> groupsIterable = groupRepository.findAll();
        List<Group> groups = new ArrayList<>();
        groupsIterable.forEach(groups::add);
        return groups;
    }

    public Group getGroupById(Long id) {
        Optional<Group> group = groupRepository.findById(id);
        return group.orElse(null);
    }
}