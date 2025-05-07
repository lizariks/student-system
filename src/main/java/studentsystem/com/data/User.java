package studentsystem.com.data;


import jakarta.persistence.*;
import lombok.*;

@MappedSuperclass
@Getter @Setter
public abstract class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected Long id;

    @Column(nullable = false)
    protected String username;

    @Column(nullable = false)
    protected String password;

    @Column(nullable = false)
    protected String email;

    @Enumerated(EnumType.STRING)
    protected Role role;
}
