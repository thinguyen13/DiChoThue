package com.fit.hcmus.WebAPI.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.fit.hcmus.WebAPI.Model.PhieuDangKy_CungUng;

public interface PhieuDangKy_CungUngRepository  extends JpaRepository<PhieuDangKy_CungUng, Integer>  
{
	@Query("SELECT v FROM v_PhieuDangKy_CungUng v")
	List<PhieuDangKy_CungUng> findByMaPhieuDKCU(@Param("phieudk") Integer phieudk);


}