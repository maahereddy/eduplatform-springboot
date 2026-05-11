package com.itved.fullstackproject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.itved.fullstackproject.entity.User;
import com.itved.fullstackproject.repository.UserRepo;

@Service
public class UserService implements UserDetailsService {
	@Autowired
	UserRepo repo;
	@Override
	public UserDetails loadUserByUsername(String username) {
	    User user = repo.findByEmail(username);

	    if (user == null) {
	        throw new UsernameNotFoundException("User not found");
	    }

	    return user;
	}
}
