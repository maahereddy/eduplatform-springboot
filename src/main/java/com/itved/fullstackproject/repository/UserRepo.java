package com.itved.fullstackproject.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.itved.fullstackproject.entity.User;

@Repository
public interface UserRepo extends JpaRepository<User, Long> {

    User findByEmail(String email);   // ✅ correct

}