package com.fit.hcmus.WebAPI.Repository;

import java.util.List;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.fit.hcmus.WebAPI.Model.PhieuDangKy_VanChuyen;

public interface PhieuDangKy_VanChuyenRepository  extends JpaRepository<PhieuDangKy_VanChuyen, Integer>  
{
	/*@Query("SELECT v FROM v_PhieuDangKy_VanChuyen v")
    List<PhieuDangKy_VanChuyen> findByMaDVVC(@Param("madvvc") Integer madvvc);*/

}
