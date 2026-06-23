package arl.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;
import java.util.List;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                // 1. Configure explicit CORS mappings and disable CSRF for Angular request
                // compatibility
                .cors(cors -> cors.configurationSource(corsConfigurationSource()))
                .csrf(csrf -> csrf.disable())

                // 2. Configure endpoint rules - explicit ordering rules apply
                .authorizeHttpRequests(auth -> auth
                        // Permit all standard pre-flight OPTIONS network pings
                        .requestMatchers(HttpMethod.OPTIONS, "/**").permitAll()

                        // Permit open authorization endpoints publicly without an entry check
                        // FIXED: Enforces that /api/auth/login and /api/auth/register completely bypass
                        // default basic auth filters
                        .requestMatchers("/api/auth/login", "/api/auth/register", "/api/auth/**").permitAll()

                        // Secure operational rules mapping your book resource actions (Anyone can view)
                        // Allows clean parameter ingestion (e.g., ?page=0&size=6) directly to the
                        // controller
                        .requestMatchers(HttpMethod.GET, "/api/books").permitAll()
                        .requestMatchers(HttpMethod.GET, "/api/books/**").permitAll()

                        // 🔒 STRICT DATA PROTECTION: Only users with ADMIN authority can change records
                        .requestMatchers(HttpMethod.POST, "/api/books").hasAnyAuthority("ADMIN", "ROLE_ADMIN")
                        .requestMatchers(HttpMethod.POST, "/api/books/**").hasAnyAuthority("ADMIN", "ROLE_ADMIN")
                        .requestMatchers(HttpMethod.PUT, "/api/books/**").hasAnyAuthority("ADMIN", "ROLE_ADMIN")
                        .requestMatchers(HttpMethod.DELETE, "/api/books/**").hasAnyAuthority("ADMIN", "ROLE_ADMIN")

                        // All miscellaneous endpoints require authentication
                        .anyRequest().authenticated())

                // 3. Standard REST-compliant HTTP Basic processing config
                // Stripped out the internal requestDispatcher forward loops to prevent query
                // parameters from breaking routes
                .httpBasic(basic -> basic.authenticationEntryPoint((request, response, authException) -> {
                    response.sendError(401, "Unauthorized");
                }));

        return http.build();
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(List.of("http://localhost:4200", "http://localhost")); // Angular local and Docker web url
        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        configuration.setAllowedHeaders(Arrays.asList("Authorization", "Cache-Control", "Content-Type"));
        configuration.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        // Enforces structural integrity of password validation using a standard BCrypt
        // algorithm framework
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration) throws Exception {
        return configuration.getAuthenticationManager();
    }
}