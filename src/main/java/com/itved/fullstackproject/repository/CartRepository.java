package com.itved.fullstackproject.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.itved.fullstackproject.entity.Cart;

public interface CartRepository extends JpaRepository<Cart, Long> {

    List<Cart> findByUserEmail(String email);

    boolean existsByCourseIdAndUserEmail(Long courseId, String email);

    void deleteByCourseIdAndUserEmail(Long courseId, String email);
}