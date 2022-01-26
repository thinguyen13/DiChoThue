package com.fit.hcmus.WebAPI.Model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "v_PhieuDangKy_CungUng")
public class PhieuDangKy_CungUng
{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	
	@Column(name="maphieudkcu")
	private int MaPhieuDKCU;
	
	@Column(name="mancc")
	private int MaNCC;
	
	@Column(name="ngaydk")
	private String NgayDK; 
	
	@Column(name="trangthai")
	private String TrangThai;
	

	public PhieuDangKy_CungUng() 
	{
		
	}
	
	public PhieuDangKy_CungUng(int maphieudkcu, int mancc, String ngaydk, String trangthai) 
	{
		this.MaPhieuDKCU = maphieudkcu;
		this.MaNCC = mancc;
		this.NgayDK = ngaydk;
		this.TrangThai = trangthai;
	}
	
	public int getMaPhieuDKCU()
	{
		return MaPhieuDKCU;
	}
	
	
	public int getMaNCC()
	{
		return MaNCC;
	}
	
	public void setMaNCC(int mancc)
	{
		this.MaNCC = mancc;
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
		return "PhieuDangKy_CungUng [MaDVVC = " + MaNCC + 
				", NgayDK=" + NgayDK +
				", TrangThai=" + TrangThai +"]";
	}
}

