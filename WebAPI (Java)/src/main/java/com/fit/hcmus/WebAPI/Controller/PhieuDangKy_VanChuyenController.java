package com.fit.hcmus.WebAPI.Controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fit.hcmus.WebAPI.Model.PhieuDangKy_VanChuyen;
import com.fit.hcmus.WebAPI.Repository.PhieuDangKy_VanChuyenRepository;


@RestController
@RequestMapping("/api")

public class PhieuDangKy_VanChuyenController 
{
	@Autowired
	private PhieuDangKy_VanChuyenRepository phieuDangKy_VanChuyenRepository;
	
	@GetMapping("/phieudkvc")

	public ResponseEntity<List<PhieuDangKy_VanChuyen>> getPhieuDangKy_VanChuyen()
	{
		List<PhieuDangKy_VanChuyen> phieudkvc = new ArrayList<PhieuDangKy_VanChuyen>();
		
		try
		{	
			phieuDangKy_VanChuyenRepository.findAll().forEach(phieudkvc::add);
			
			if(phieudkvc.isEmpty()) 
				return new ResponseEntity<>(HttpStatus.NO_CONTENT);
			
			return new ResponseEntity<>(phieudkvc, HttpStatus.OK);
		}
		catch (Exception e)
		{
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@PostMapping("/dangkivanchuyen")
	public ResponseEntity<PhieuDangKy_VanChuyen> postPhieuDangKy_VanChuyen(@RequestBody PhieuDangKy_VanChuyen phieudkvc)
	{
		try {
		PhieuDangKy_VanChuyen _phieudkvc = phieuDangKy_VanChuyenRepository.save(new PhieuDangKy_VanChuyen(phieudkvc.getMaPhieuDKVC(), phieudkvc.getMaDVVC(),
				phieudkvc.getNgayDK(), phieudkvc.getTrangThai()));
		return new ResponseEntity<>(_phieudkvc, HttpStatus.CREATED);
		} catch (Exception e) {
		return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		}


}
