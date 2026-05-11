package com.itved.fullstackproject.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import com.itved.fullstackproject.entity.Course;
public interface CourseRepository extends JpaRepository<Course, Long> {
	 List<Course> findByTitleContainingIgnoreCase(String keyword);
}