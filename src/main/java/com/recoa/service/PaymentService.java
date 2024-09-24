package com.recoa.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.ReserveGuestDAO;
import com.recoa.model.dao.ReserveLibraryDAO;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.Payment;

@Service
public class PaymentService {

	private String apiKey = "3642014760823884";
	private String apiSecret = "spwLiMfVtK1wcLtTcT3RGSoy7sl9CCR2b7YUQYXJkoHfLFK1eV9SaeWKDzLSsVDgLx6P9hGnuWd3BXRq";
	
	@Autowired
	private ReserveGuestDAO guestDao;
	
	@Autowired
	private ReserveLibraryDAO libraryDao;
	
    public Payment getPayment(String impUid) throws IamportResponseException, IOException {
    	IamportClient client = new IamportClient(apiKey, apiSecret);
    	System.out.println("client : " + client);
    	return client.paymentByImpUid(impUid).getResponse();
    }
    
    // 해당 월을 받아서 reservelibrary, reserveguest 조회해서 업데이트 
    
    
}
