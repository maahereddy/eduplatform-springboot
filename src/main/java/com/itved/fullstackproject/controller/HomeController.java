package com.itved.fullstackproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.itved.fullstackproject.entity.*;
import com.itved.fullstackproject.repository.*;

import java.security.Principal;
import java.util.*;

@Controller
public class HomeController {

    @Autowired
    private CourseRepository repo;

    @Autowired
    private EnrollmentRepository enrollRepo;

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private BCryptPasswordEncoder encoder;

    @Autowired
    private CartRepository cartRepo;

    @Autowired
    private PaymentRepository paymentRepo;

    @Autowired
    private LessonRepo lessonRepo;

    // ================= HOME =================
    @Autowired
    private CourseRepository courseRepo;

    @GetMapping("/home")
    public String home(Model model) {

        List<Course> courses = courseRepo.findAll();

        model.addAttribute("courses", courses);

        return "home";
    }

    // ================= COURSES =================
    @GetMapping("/courses")
    public String courses(@RequestParam(required = false) String keyword,
                          Model model,
                          Principal principal) {

        String email = (principal != null) ? principal.getName() : null;

        if (keyword != null && !keyword.isEmpty()) {
            model.addAttribute("courses",
                    repo.findByTitleContainingIgnoreCase(keyword));
        } else {
            model.addAttribute("courses", repo.findAll());
        }

        if (email != null) {
            model.addAttribute("enrolledCourses",
                    enrollRepo.findByUserEmail(email));

            var cartItems = cartRepo.findByUserEmail(email);
            model.addAttribute("cartItems", cartItems);
            model.addAttribute("cartCount", cartItems.size());

        } else {
            model.addAttribute("enrolledCourses", Collections.emptyList());
            model.addAttribute("cartItems", Collections.emptyList());
            model.addAttribute("cartCount", 0);
        }

        return "courses";
    }

    // ================= ENROLL =================
    @PostMapping("/enroll")
    public String enroll(@RequestParam Long courseId, Principal principal) {

        if (principal == null) return "redirect:/login";

        String email = principal.getName();

        if (!enrollRepo.existsByCourseIdAndUserEmail(courseId, email)) {
            Enrollment e = new Enrollment();
            e.setCourseId(courseId);
            e.setUserEmail(email);
            enrollRepo.save(e);
        }

        return "redirect:/courses";
    }

    // ================= LOGIN =================
    @GetMapping("/login")
    public String login() {
        return "login";
    }

    // ================= REGISTER =================
    @GetMapping("/register")
    public String register() {
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@RequestParam String name,
                               @RequestParam String email,
                               @RequestParam String password,
                               @RequestParam String confirmPassword,
                               @RequestParam String address,
                               @RequestParam String mobileNo,
                               Model model) {

        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match!");
            return "register";
        }

        if (password.length() < 6) {
            model.addAttribute("error", "Password must be at least 6 characters!");
            return "register";
        }

        if (userRepo.findByEmail(email) != null) {
            model.addAttribute("error", "Email already registered!");
            return "register";
        }

        User user = new User();
        user.setName(name.trim());
        user.setEmail(email.trim());
        user.setPassword(encoder.encode(password));
        user.setRole("USER");
        user.setAddress(address);
        user.setMobile(mobileNo);

        userRepo.save(user);

        return "redirect:/login?success=true";
    }

    // ================= MY COURSES =================
    @GetMapping("/my-courses")
    public String myCourses(Model model, Principal principal) {

        if (principal == null) return "redirect:/login";

        model.addAttribute("myCourses",
                enrollRepo.findByUserEmail(principal.getName()));

        return "my-courses";
    }

    // ================= CHECKOUT =================
    @GetMapping("/checkout")
    public String checkout(Model model, Principal principal) {

        if (principal == null) return "redirect:/login";

        List<Cart> cartItems = cartRepo.findByUserEmail(principal.getName());

        double total = 0;
        for (Cart c : cartItems) {
            Course course = repo.findById(c.getCourseId()).orElse(null);
            if (course != null) total += course.getPrice();
        }

        model.addAttribute("total", total);

        return "checkout";
    }

    // ================= PAYMENT HISTORY =================
    @GetMapping("/payment-history")
    public String paymentHistory(Model model, Principal principal) {

        if (principal == null) return "redirect:/login";

        var payments = paymentRepo.findByUserEmail(principal.getName());

        List<Map<String, Object>> paymentDetails = new ArrayList<>();

        for (var p : payments) {
            Map<String, Object> map = new HashMap<>();

            var course = repo.findById(p.getCourseId()).orElse(null);

            map.put("courseName", course != null ? course.getTitle() : "N/A");
            map.put("amount", p.getAmount());
            map.put("paymentId", p.getPaymentId());
            map.put("status", p.getStatus());
            map.put("date", p.getPaymentDate());

            paymentDetails.add(map);
        }

        model.addAttribute("payments", paymentDetails);

        return "payment-history";
    }

    // ================= COURSE DETAILS =================
    @GetMapping("/course/{id}")
    public String courseDetails(@PathVariable Long id,
                                Model model,
                                Principal principal) {

        Course course = repo.findById(id).orElse(null);

        // ✅ FIX COURSE VIDEO URL
        if (course != null && course.getVideoUrl() != null) {
            String url = course.getVideoUrl();

            if (url.contains("watch?v=")) {
                url = url.replace("watch?v=", "embed/");
            } else if (url.contains("youtu.be/")) {
                url = url.replace("youtu.be/", "www.youtube.com/embed/");
            } else if (url.contains("youtube.com/live/")) {
                url = url.replace("youtube.com/live/", "youtube.com/embed/");
            }

            course.setVideoUrl(url);
        }

        // ✅ Lessons
        List<Lesson> lessons = lessonRepo.findByCourseIdOrderByPositionAsc(id);

        for (Lesson l : lessons) {
            String url = l.getVideoUrl();

            if (url != null) {
                if (url.contains("watch?v=")) {
                    url = url.replace("watch?v=", "embed/");
                } else if (url.contains("youtu.be/")) {
                    url = url.replace("youtu.be/", "www.youtube.com/embed/");
                } else if (url.contains("youtube.com/live/")) {
                    url = url.replace("youtube.com/live/", "youtube.com/embed/");
                }
            }

            l.setVideoUrl(url);
        }

        boolean isEnrolled = false;
        if (principal != null) {
            isEnrolled = enrollRepo.existsByCourseIdAndUserEmail(
                    id, principal.getName());
        }

        model.addAttribute("course", course);
        model.addAttribute("lessons", lessons);
        model.addAttribute("isEnrolled", isEnrolled);

        return "course-details";
    }
}