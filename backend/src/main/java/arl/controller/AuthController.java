package arl.controller;

import arl.entity.User;
import arl.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = {"http://localhost:4200", "http://localhost"})
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping("/register")
    public ResponseEntity<?> registerUser(@RequestBody User user) {
        try {
            // 1. Check if username already exists
            if (userRepository.existsByUsername(user.getUsername())) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(Map.of("message", "Username is already taken."));
            }

            // 2. Check if email already exists
            if (userRepository.existsByEmail(user.getEmail())) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(Map.of("message", "Email is already registered."));
            }

            // Encrypt plain text passwords into secure BCrypt hashes
            user.setPassword(passwordEncoder.encode(user.getPassword()));

            // CHANGED HERE: Dynamically extract the chosen role selection from registration
            // payload
            if (user.getRole() != null && !user.getRole().trim().isEmpty()) {
                // Formats to uppercase (e.g. "ADMIN" or "STUDENT") to match role authority
                // strings
                user.setRole(user.getRole().toUpperCase().trim());
            } else {
                // Default fallback if no choice is provided by front-end elements
                user.setRole("STUDENT");
            }

            User savedUser = userRepository.save(user);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedUser);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("message", "Error processing account creation: " + e.getMessage()));
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> loginUser(@RequestBody Map<String, String> credentials) {
        String username = credentials.get("username");
        String password = credentials.get("password");

        return userRepository.findByUsername(username)
                .filter(user -> passwordEncoder.matches(password, user.getPassword()))
                .map(user -> ResponseEntity.ok(Map.of(
                        "username", user.getUsername(),
                        "role", user.getRole(),
                        "status", "authenticated")))
                .orElse(ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(Map.of("message", "Invalid credentials")));
    }
}