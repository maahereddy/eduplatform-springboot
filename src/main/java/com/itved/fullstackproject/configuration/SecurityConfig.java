package com.itved.fullstackproject.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;



@Configuration
public class SecurityConfig {

	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

	    http
	        .csrf(csrf -> csrf.disable())

	        .authorizeHttpRequests(auth -> auth

	            // ✅ Public
	            .requestMatchers("/", "/home", "/courses", "/login", "/register", "/create-admin").permitAll()

	            // ✅ Admin only
	            .requestMatchers("/admin/**").hasRole("ADMIN")

	            // ✅ User only
	            .requestMatchers("/my-courses", "/enroll", "/add-to-cart").hasRole("USER")
	            .requestMatchers("/checkout", "/cart", "/add-to-cart", "/payment-success")
	            .hasRole("USER")
	            

	            // ✅ everything else
	            .anyRequest().permitAll()
	        )

	        .formLogin(form -> form
	        	    .loginPage("/login")
	        	    .loginProcessingUrl("/login")
	        	    .successHandler(successHandler)
	        	    .permitAll()
	        	)

	        .logout(logout -> logout
	            .logoutSuccessUrl("/login")
	            .permitAll()
	        );

	    return http.build();
	}
	@Autowired
	private CustomSuccessHandler successHandler;
    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
    
}