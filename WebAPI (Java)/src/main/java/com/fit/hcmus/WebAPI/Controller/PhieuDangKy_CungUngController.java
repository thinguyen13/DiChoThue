package com.fit.hcmus.WebAPI.Controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fit.hcmus.WebAPI.Model.PhieuDangKy_CungUng;
import com.fit.hcmus.WebAPI.Repository.PhieuDangKy_CungUngRepository;


@RestController
@RequestMapping("/api")

public class PhieuDangKy_CungUngController 
{
	@Autowired
	private PhieuDangKy_CungUngRepository phieuDangKy_CungUngRepository;
	
	@GetMapping("/phieudkcu")

	public ResponseEntity<List<PhieuDangKy_CungUng>> getPhieuDangKy_CungUng()
	{
		List<PhieuDangKy_CungUng> phieudkcu = new ArrayList<PhieuDangKy_CungUng>();
		
		try
		{	
			phieuDangKy_CungUngRepository.findAll().forEach(phieudkcu::add);
			
			if(phieudkcu.isEmpty()) 
				return new ResponseEntity<>(HttpStatus.NO_CONTENT);
			
			return new ResponseEntity<>(phieudkcu, HttpStatus.OK);
		}
		catch (Exception e)
		{
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@PutMapping("/phieudkcu/{maphieudkcu}")
	public ResponseEntity<PhieuDangKy_CungUng> PutPhieuDangKy_CungUng(@PathVariable("maphieudkcu") String maphieudkcu, @RequestBody PhieuDangKy_CungUng
	phieudkcu) {	
	Optional<PhieuDangKy_CungUng> PhieuDangKy_CungUngData = phieuDangKy_CungUngRepository.findById(maphieudkcu);
	if (PhieuDangKy_CungUngData != null) {
	    //developer found       
	}
	if (PhieuDangKy_CungUngData.isPresent()) {
		PhieuDangKy_CungUng _PhieuDangKy_CungUng = PhieuDangKy_CungUngData.get();
	_PhieuDangKy_CungUng.setMaNCC(phieudkcu.getMaNCC());
	_PhieuDangKy_CungUng.setNgayDK(phieudkcu.getNgayDK());
	_PhieuDangKy_CungUng.setTrangThai(phieudkcu.getTrangThai());
	return new ResponseEntity<>(phieuDangKy_CungUngRepository.save(phieudkcu), HttpStatus.OK);
	} else {
	return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}
	}

}
