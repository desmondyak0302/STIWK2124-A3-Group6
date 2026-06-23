package arl.repository;

import arl.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {

    /**
     * Custom query loader to pull database user profiles by username.
     * Crucial for verifying identity records against credentials data.
     */
    Optional<User> findByUsername(String username);

    /**
     * Verification checker helper method to protect registration
     * boundaries against duplicate unique username conflicts.
     */
    boolean existsByUsername(String username);

    /**
     * Verification checker helper method to protect registration
     * boundaries against duplicate unique email conflicts.
     */
    boolean existsByEmail(String email);
}