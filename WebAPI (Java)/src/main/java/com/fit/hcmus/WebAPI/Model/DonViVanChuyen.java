package com.fit.hcmus.WebAPI.Model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "v_DonViVanChuyen")
public class DonViVanChuyen
{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	
	@Column(name="madvvc")
	private int MaDVVC;
	
	@Column(name="tendvvc")
	private String TenDVVC;
	
	@Column(name="giayphepkinhdoanh")
	private String GiayPhepKinhDoanh; 
	
	@Column(name="sotaikhoannganhang")
	private String SoTaiKhoanNganHang;

	@Column(name="sdt")
	private String SDT;
	
	@Column(name="diachi")
	private String DiaChi;
	
	@Column(name="email")
	private String Email;
	
	@Column(name="phivanchuyen_km")
	private float PhiVanChuyen_KM;
	
	@Column(name="taikhoan")
	private int TaiKhoan;

	public DonViVanChuyen() 
	{
		
	}
	
	public DonViVanChuyen(int madvvc, String tendvvc, String giayphepkinhdoanh, String sotaikhoannganhang, String sdt, String diachi, String email, float phivanchuyen_km, int taikhoan) 
	{
		this.MaDVVC = madvvc;
		this.TenDVVC = tendvvc;
		this.GiayPhepKinhDoanh = giayphepkinhdoanh;
		this.SoTaiKhoanNganHang = sotaikhoannganhang;
		this.SDT = sdt;
		this.DiaChi = diachi;
		this.Email = email;
		this.PhiVanChuyen_KM = phivanchuyen_km;
		this.TaiKhoan = taikhoan;
	}
	
	
	public int getMaDVVC()
	{
		return MaDVVC;
	}
	
	public String getTenDVVC()
	{
		return TenDVVC;
	}
	
	public void setTenDVVC(String tendvvc)
	{
		this.TenDVVC = tendvvc;
	}
	
	public String getGiayPhepKinhDoanh()
	{
		return GiayPhepKinhDoanh;
	}
	
	public void setGiayPhepKinhDoanh(String giayphepkinhdoanh)
	{
		this.GiayPhepKinhDoanh = giayphepkinhdoanh;
	}
	
	public String getSoTaiKhoanNganHang()
	{
		return SoTaiKhoanNganHang;
	}
	
	public void setSoTaiKhoanNganHang(String sotaikhoannganhang)
	{
		this.SoTaiKhoanNganHang = sotaikhoannganhang;
	}
	
	public String getSDT()
	{
		return SDT;
	}
	
	public void setSDT(String sdt)
	{
		this.SDT = sdt;
	}
	
	public String getDiaChi()
	{
		return DiaChi;
	}
	
	public void setDiaChi(String diachi)
	{
		this.DiaChi = diachi;
	}
	
	public String getEmail()
	{
		return Email;
	}
	
	public void setEmail(String email)
	{
		this.Email = email;
	}
	
	public float getPhiVanChuyen_KM()
	{
		return PhiVanChuyen_KM;
	}
	
	public void setPhiVanChuyen_KM(float phivanchuyen_km)
	{
		this.PhiVanChuyen_KM = phivanchuyen_km;
	}
	
	public int getTaiKhoan()
	{
		return TaiKhoan;
	}
	
	public void setTaiKhoan(int taikhoan)
	{
		this.TaiKhoan = taikhoan;
	}
	

	
	@Override
	public String toString() {
		return "DonViVanChuyen [TenDVVC = " + TenDVVC + 
				", GiayPhepKinhDoanh=" + GiayPhepKinhDoanh +
				", SoTaiKhoanNganHang=" + SoTaiKhoanNganHang +
				", SDT=" + SDT +
				", DiaChi=" + DiaChi +
				", Email=" + Email +
				", PhiVanChuyen_KM=" + PhiVanChuyen_KM +
				", TaiKhoan=" + TaiKhoan +"]";
	}
}


