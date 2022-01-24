package com.fit.hcmus.WebAPI.Repository;

import java.util.List;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.fit.hcmus.WebAPI.Model.DonViVanChuyen;

public interface DonViVanChuyenRepository  extends JpaRepository<DonViVanChuyen, Integer>  
{
	/*@Query("SELECT v FROM v_DonViVanChuyen v")
    List<DonViVanChuyen> findByMaDVVC(@Param("madvvc") Integer madvvc);*/

}
