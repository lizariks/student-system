package studentsystem.com.data;


import org.springframework.security.core.userdetails.UserDetails;

public interface UserDetailsBase extends UserDetails {
    String getUsername();
    String getPassword();
}
