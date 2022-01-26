package com.fit.hcmus.WebAPI.Controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fit.hcmus.WebAPI.Model.PhieuDangKy_CungUng;
import com.fit.hcmus.WebAPI.Repository.PhieuDangKy_CungUngRepository;


@RestController
@RequestMapping("/api")

public class PhieuDangKy_CungUngController 
{
	@Autowired
	private PhieuDangKy_CungUngRepository phieuDangKyCungUngRepository;
	
	
	@GetMapping("/phieudkcu")
	
	public ResponseEntity<List<PhieuDangKy_CungUng>> getPhieuDangKyCungUng(@PathVariable("phieudk") int phieudk){
		try {
			List<PhieuDangKy_CungUng> phieudkcu = new ArrayList<PhieuDangKy_CungUng>();
			
			if(phieudk == 0) {
				phieuDangKyCungUngRepository.findAll().forEach(phieudkcu::add);
			}else {
				phieuDangKyCungUngRepository.findByMaPhieuDKCU(phieudk).forEach(phieudkcu::add);
			}
			
			if(phieudkcu.isEmpty()) {
				return new ResponseEntity<>(HttpStatus.NO_CONTENT);
			}
			
			return new ResponseEntity<>(phieudkcu, HttpStatus.OK);
		}catch(Exception e) {
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	
	
	

}