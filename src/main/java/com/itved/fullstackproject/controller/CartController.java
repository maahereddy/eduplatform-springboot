package com.itved.fullstackproject.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.itved.fullstackproject.entity.Cart;
import com.itved.fullstackproject.entity.Course;
import com.itved.fullstackproject.entity.Enrollment;
import com.itved.fullstackproject.repository.CartRepository;
import com.itved.fullstackproject.repository.CourseRepository;
import com.itved.fullstackproject.repository.EnrollmentRepository;

@Controller
public class CartController {

    @Autowired
    private CartRepository cartRepo;

    // Add to cart
    @PostMapping("/add-to-cart")
    public String addToCart(@RequestParam Long courseId,
                           java.security.Principal principal) {

        if (principal == null) {
            return "redirect:/login"; // 🔥 important
        }

        String email = principal.getName();

        boolean exists =
            cartRepo.existsByCourseIdAndUserEmail(courseId, email);

        if (!exists) {
            Cart c = new Cart();
            c.setCourseId(courseId);
            c.setUserEmail(email);
            cartRepo.save(c);
        }

        return "redirect:/courses";
    }

    // View cart
    @GetMapping("/cart")
    public String viewCart(Model model, java.security.Principal principal) {

        String email = principal.getName();

        // 1️⃣ Get cart items
        var cartItems = cartRepo.findByUserEmail(email);

        // 2️⃣ Get course details
        var courses = courseRepo.findAllById(
                cartItems.stream()
                         .map(c -> c.getCourseId())
                         .toList()
        );

        // 3️⃣ Calculate total
        double total = courses.stream()
                .mapToDouble(c -> c.getPrice())
                .sum();

        // 4️⃣ Send to JSP
        model.addAttribute("cartCourses", courses);
        model.addAttribute("total", total);

        return "cart";
    }
    // Remove from cart

@Transactional
    @PostMapping("/remove-from-cart")
    public String remove(@RequestParam Long courseId,
                         java.security.Principal principal) {

        String email = principal.getName();

        cartRepo.deleteByCourseIdAndUserEmail(courseId, email);

        return "redirect:/cart";
    }
    @Autowired
    private CourseRepository courseRepo;

    
    @GetMapping("/payment-success")
    public String paymentSuccess(Principal principal) {

        String email = principal.getName();

        // 1️⃣ Get cart items
        var cartItems = cartRepo.findByUserEmail(email);

        // 2️⃣ Save to enrollment table
        for (Cart c : cartItems) {
            Enrollment e = new Enrollment();
            e.setCourseId(c.getCourseId());
            e.setUserEmail(email);
            enrollRepo.save(e);
        }

        // 3️⃣ Clear cart
        cartRepo.deleteAll(cartItems);

        return "redirect:/my-courses";
    }
    @Autowired
    private EnrollmentRepository enrollRepo; 
  
    
}