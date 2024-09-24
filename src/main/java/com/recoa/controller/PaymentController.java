package com.recoa.controller;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.recoa.model.vo.PaymentDesc;

@Controller
public class PaymentController {

	private static final String apiKey = "";
	private static final String apiSecret = "";
	
	@PostMapping("/payments/verify")
	public ResponseEntity<String> verify(@RequestBody PaymentDesc payment){
		System.out.println("payment : " + payment);
		String impUid = payment.getImp_uid();
		String accessToken = getAccessToken();
		
		if (accessToken == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("토큰 발급 실패");
        }

		if (impUid == null || impUid.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("imp_uid가 없습니다.");
        }

        // 결제 검증 API 호출
        String verifyUrl = "https://api.iamport.kr/payments/" + impUid;
        System.out.println("verifyUrl : " + verifyUrl);
        
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);

        HttpEntity<String> entity = new HttpEntity<>(headers);
        System.out.println("entity : " + entity);
        
        ResponseEntity<String> response = restTemplate.exchange(verifyUrl, HttpMethod.GET, entity, String.class);

        
        if (response.getStatusCode() == HttpStatus.OK) {
            return ResponseEntity.ok(response.getBody());
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("결제 검증 실패");
        }
	}
	
	// 아임포트 API 토큰 발급 메서드
    private String getAccessToken() {
        RestTemplate restTemplate = new RestTemplate();
        String tokenUrl = "https://api.iamport.kr/users/getToken";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String body = "{\"imp_key\":\"" + apiKey + "\", \"imp_secret\":\"" + apiSecret + "\"}";
        HttpEntity<String> request = new HttpEntity<>(body, headers);

        ResponseEntity<String> response = restTemplate.postForEntity(tokenUrl, request, String.class);

        if (response.getStatusCode() == HttpStatus.OK) {
            String responseBody = response.getBody();
            
            System.out.println("responseBody : " + responseBody);
            String accessToken = extractAccessTokenFromResponse(responseBody);
            
            return accessToken;
        } else {
            return null;
        }
    }

    private String extractAccessTokenFromResponse(String responseBody) {
    	
    	JsonParser parser = new JsonParser();
    	Object obj = parser.parse(responseBody);
    	JsonObject jsonObj = (JsonObject) obj;
    	JsonElement response = jsonObj.get("response");
    	String accessToken = response.getAsJsonObject().get("access_token").getAsString();
    	
    	System.out.println("accessToken : " + accessToken);
        
        return accessToken; 
    }
}
