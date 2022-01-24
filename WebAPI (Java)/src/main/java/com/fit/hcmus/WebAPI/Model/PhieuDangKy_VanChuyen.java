package com.fit.hcmus.WebAPI.Model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "v_PhieuDangKy_VanChuyen")
public class PhieuDangKy_VanChuyen
{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	
	@Column(name="maphieudkvc")
	private int MaPhieuDKVC;
	
	@Column(name="madvvc")
	private int MaDVVC;
	
	@Column(name="ngaydk")
	private String NgayDK; 
	
	@Column(name="trangthai")
	private String TrangThai;
	

	public PhieuDangKy_VanChuyen() 
	{
		
	}
	
	public PhieuDangKy_VanChuyen(int maphieudkvc, int madvvc, String ngaydk, String trangthai) 
	{
		this.MaPhieuDKVC = maphieudkvc;
		this.MaDVVC = madvvc;
		this.NgayDK = ngaydk;
		this.TrangThai = trangthai;
	}
	
	public int getMaPhieuDKVC()
	{
		return MaPhieuDKVC;
	}
	
	
	public int getMaDVVC()
	{
		return MaDVVC;
	}
	
	public void setMaDVVC(int madvvc)
	{
		this.MaDVVC = madvvc;
	}
	
	public String getNgayDK()
	{
		return NgayDK;
	}
	
	public void setNgayDK(String ngaydk)
	{
		this.NgayDK = ngaydk;
	}
	
	public String getTrangThai()
	{
		return TrangThai;
	}
	
	public void setTrangThai(String trangthai)
	{
		this.TrangThai = trangthai;
	}
	

	
	@Override
	public String toString() {
		return "PhieuDangKy_VanChuyen [MaDVVC = " + MaDVVC + 
				", NgayDK=" + NgayDK +
				", TrangThai=" + TrangThai +"]";
	}
}
