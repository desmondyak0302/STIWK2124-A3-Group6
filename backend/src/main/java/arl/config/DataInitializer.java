package arl.config;

import arl.entity.User;
import arl.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) throws Exception {
        // Checks if the admin profile is missing to prevent duplication bugs
        if (userRepository.findByUsername("admin").isEmpty()) {
            User admin = new User();
            admin.setUsername("admin");
            admin.setPassword(passwordEncoder.encode("admin123")); // Securely encrypts password
            admin.setEmail("admin@arl.com");
            admin.setRole("ADMIN"); // Saved as ADMIN in your db table string column

            userRepository.save(admin);
            System.out.println("======================================================================");
            System.out.println(">>> Verified: Admin user initialized (admin / admin123) successfully!");
            System.out.println("======================================================================");
        }
    }
}