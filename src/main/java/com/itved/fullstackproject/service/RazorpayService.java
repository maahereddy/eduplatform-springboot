package com.itved.fullstackproject.service;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;



@Service
public class RazorpayService {
@Value("${razorpay.api.key}")
private String apiKey ;
@Value("${razorpay.api.secret}")
private String apiSecret ;
public Map<String, Object> createOrder(int amount, String currency, String receipt) throws
RazorpayException {
RazorpayClient client = new RazorpayClient(apiKey, apiSecret);
JSONObject options = new JSONObject();
options.put("amount", amount*100);
options.put("currency", currency);
options.put("receipt", receipt);
Order order = client.orders.create(options);
Map<String, Object> response = new HashMap<>();
response.put("id", order.get("id"));
response.put("amount", order.get("amount"));
response.put("currency", order.get("currency"));
return response;
}
}
