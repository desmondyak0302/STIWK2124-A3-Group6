package arl.service;

import arl.entity.User;
import arl.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    /**
     * Registers a new account profile if the username is available.
     */
    public User registerUser(User user) {
        if (userRepository.findByUsername(user.getUsername()).isPresent()) {
            throw new RuntimeException("Username is already taken!");
        }
        return userRepository.save(user);
    }

    /**
     * Authenticates plain-text credentials against records stored in the MySQL
     * table.
     */
    public boolean authenticate(String username, String password) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            // Performs exact string matching
            return user.getPassword().equals(password);
        }
        return false;
    }
}