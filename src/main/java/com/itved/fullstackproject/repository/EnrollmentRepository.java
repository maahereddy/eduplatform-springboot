package com.itved.fullstackproject.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.itved.fullstackproject.entity.Enrollment;

public interface EnrollmentRepository extends JpaRepository<Enrollment, Long> {

    // 🔥 Check if user already enrolled
    boolean existsByCourseIdAndUserEmail(Long courseId, String userEmail);

    // 🔥 Get all enrollments of user
    List<Enrollment> findByUserEmail(String userEmail);
}