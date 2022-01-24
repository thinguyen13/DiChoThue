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

import com.fit.hcmus.WebAPI.Model.DonViVanChuyen;
import com.fit.hcmus.WebAPI.Repository.DonViVanChuyenRepository;


@RestController
@RequestMapping("/api")

public class DonViVanChuyenController 
{
	@Autowired
	private DonViVanChuyenRepository donViVanChuyenRepository;
	
	@GetMapping("/dvvc")

	public ResponseEntity<List<DonViVanChuyen>> getPhieuDangKy_VanChuyen()
	{
		List<DonViVanChuyen> dvvc = new ArrayList<DonViVanChuyen>();
		
		try
		{	
			donViVanChuyenRepository.findAll().forEach(dvvc::add);
			
			if(dvvc.isEmpty()) 
				return new ResponseEntity<>(HttpStatus.NO_CONTENT);
			
			return new ResponseEntity<>(dvvc, HttpStatus.OK);
		}
		catch (Exception e)
		{
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@PostMapping("/dkvc")
	public ResponseEntity<DonViVanChuyen> postPhieuDangKy_VanChuyen(@RequestBody DonViVanChuyen dvvc)
	{
		try {
			DonViVanChuyen _dvvc = donViVanChuyenRepository.save(new DonViVanChuyen(dvvc.getMaDVVC(), dvvc.getTenDVVC(), dvvc.getGiayPhepKinhDoanh(),
				dvvc.getSoTaiKhoanNganHang(), dvvc.getSDT(), dvvc.getDiaChi(), dvvc.getEmail(), dvvc.getPhiVanChuyen_KM(), dvvc.getTaiKhoan()));
		return new ResponseEntity<>(_dvvc, HttpStatus.CREATED);
		} catch (Exception e) {
		return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		}


}
