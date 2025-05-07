package studentsystem.com.service;


import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import studentsystem.com.data.User;
import studentsystem.com.data.UserDetailsBase;
import studentsystem.com.repositories.StudentRepository;
import studentsystem.com.repositories.TeacherRepository;

import java.util.Optional;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final StudentRepository studentRepo;
    private final TeacherRepository teacherRepo;

    public CustomUserDetailsService(StudentRepository s, TeacherRepository t) {
        this.studentRepo = s;
        this.teacherRepo = t;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<? extends UserDetailsBase> userOpt = studentRepo.findByUsername(username)
                .map(s -> (UserDetailsBase) s)
                .or(() -> teacherRepo.findByUsername(username).map(t -> (UserDetailsBase) t));

        return userOpt.orElseThrow(() -> new UsernameNotFoundException("User not found: " + username));
    }
}
