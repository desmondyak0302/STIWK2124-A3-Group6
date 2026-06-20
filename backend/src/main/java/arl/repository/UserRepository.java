package arl.repository;

import arl.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    // Custom query loader to pull database user profiles by username
    Optional<User> findByUsername(String username);
}