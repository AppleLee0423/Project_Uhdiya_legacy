package com.spring.Uhdiya.memJ;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;




@Service
public class MemJService {
	@Autowired MemJDAO memJDAO;
	
	public void addMember(MemJDTO memJ) {
		// TODO Auto-generated method stub
		memJDAO.addMember(memJ);
	}
	
	public MemJDTO login(MemJDTO memJ) {
		// TODO Auto-generated method stub
		return memJDAO.login(memJ);
	}


	
	
	
}