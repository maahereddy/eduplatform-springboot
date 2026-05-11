package com.itved.fullstackproject.controller;

import com.razorpay.*;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.Map;

import com.itved.fullstackproject.entity.Cart;
import com.itved.fullstackproject.entity.Course;
import com.itved.fullstackproject.entity.Enrollment;
import com.itved.fullstackproject.entity.Payment;
import com.itved.fullstackproject.repository.CartRepository;
import com.itved.fullstackproject.repository.CourseRepository;
import com.itved.fullstackproject.repository.EnrollmentRepository;
import com.itved.fullstackproject.repository.PaymentRepository;

@RestController
public class PaymentController {
    @Autowired
    private CourseRepository courseRepo;

    @Autowired
    private CartRepository cartRepo;

    @Autowired
    private EnrollmentRepository enrollRepo;

    @Autowired
    private PaymentRepository paymentRepo;

    // ================= CREATE ORDER =================
    @PostMapping("/create-order")
    public String createOrder(@RequestParam double amount) throws Exception {

        RazorpayClient client = new RazorpayClient(
                "rzp_test_SfFKZ5fuiQKiTO",
                "Etih5svZm2XdgTGJjwOJT3eL"
        );

        JSONObject options = new JSONObject();
        options.put("amount", (int)(amount * 100));
        options.put("currency", "INR");
        options.put("receipt", "txn_123");

        Order order = client.orders.create(options);

        return order.toString();
    }

    // ================= VERIFY PAYMENT =================
    @PostMapping("/verify-payment")
    public String verifyPayment(@RequestBody Map<String, String> data,
                                Principal principal) throws Exception {

        if (principal == null) {
            return "fail";
        }

        String orderId = data.get("orderId");
        String paymentId = data.get("paymentId");
        String signature = data.get("signature");

        String secret = "Etih5svZm2XdgTGJjwOJT3eL";

        String payload = orderId + "|" + paymentId;

        String generatedSignature =
                new org.apache.commons.codec.digest.HmacUtils(
                        org.apache.commons.codec.digest.HmacAlgorithms.HMAC_SHA_256,
                        secret
                ).hmacHex(payload);

        // ✅ VERIFY
        if (generatedSignature.equals(signature)) {

            String email = principal.getName();

            var cartItems = cartRepo.findByUserEmail(email);

            for (Cart c : cartItems) {

                // 💳 SAVE PAYMENT
                Payment p = new Payment();
                p.setUserEmail(email);
                p.setCourseId(c.getCourseId());
                p.setPaymentId(paymentId);
                p.setOrderId(orderId);
                Course course = courseRepo.findById(c.getCourseId()).orElse(null);

                if (course != null) {
                    p.setAmount(course.getPrice()); 
                }
                p.setStatus("SUCCESS");
                p.setPaymentDate(LocalDateTime.now());

                paymentRepo.save(p);

                // 🎓 ENROLL USER
                Enrollment e = new Enrollment();
                e.setCourseId(c.getCourseId());
                e.setUserEmail(email);
                enrollRepo.save(e);
            }

            // 🧹 CLEAR CART
            cartRepo.deleteAll(cartItems);

            return "success";
        }

        return "fail";
    }

}