using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace UngDung_DiChoThue.Controllers
{
    public class TiepNhanYCVCController : ApiController
    {
        // GET: TiepNhanYCVC
        SqlConnection con = new SqlConnection(@"Data Source=.;Initial Catalog=QL_DiChoThue;Integrated Security=True");

        [Route("api/KhachHang/{MaKH}")]
        public HttpResponseMessage GetKH(int MaKH)
        {
            string query = @"
            select KH.MaKH, KH.TenKH, KH.DiaChi, KH.SDT
            from KhachHang KH
            where KH.MaKH = '" + MaKH + "' ";
            return GetData(query);

        }
        [Route("api/DVVC")]
        public HttpResponseMessage GetDVVC()
        {
            string query = @"
            select MaDVVC, TenDVVC
            from DonViVanChuyen";
            return GetData(query);

        }

        [Route("api/TiepNhanYCVC/KH/{MaKH}")]
        public HttpResponseMessage GetPYCKH(int MaKH)
        {
            string query = @"
            select	DH.MaDH, KH.TenKH, KH.DiaChi, KH.SDT, DVVC.TenDVVC, DH.HinhThucThanhToan, DH.TrangThai, DH.YeuCauVanChuyen, DH.PhiVanChuyen, DH.TongTien
            from	DonHang DH, DonViVanChuyen DVVC, KhachHang KH
            where	DH.MaKH = KH.MaKH
	            and DH.MaDVVC = DVVC.MaDVVC
            group by DH.MaDH, KH.TenKH, KH.DiaChi, KH.SDT, DVVC.TenDVVC, DH.HinhThucThanhToan, DH.TrangThai, DH.YeuCauVanChuyen, DH.PhiVanChuyen, DH.TongTien, KH.MaKH
            having DH.YeuCauVanChuyen = N'Chờ tiếp nhận' and DH.TrangThai = N'Đang giao' or DH.TrangThai = N'Đổi trả'
	            and KH.MaKH = '" + MaKH + "' ";
            return GetData(query);
        }

        [Route("api/TiepNhanYCVC/DVVC/{MaDVVC}")]
            public HttpResponseMessage GetPYCDVVC(int MaDVVC)
            {
            string query = @"
            select	DH.MaDH, KH.TenKH, KH.DiaChi, KH.SDT, DVVC.TenDVVC, DH.HinhThucThanhToan, DH.TrangThai, DH.YeuCauVanChuyen,  DH.PhiVanChuyen, DH.TongTien
            from	DonHang DH, DonViVanChuyen DVVC, KhachHang KH
            where	DH.MaKH = KH.MaKH
	            and DH.MaDVVC = DVVC.MaDVVC
                and DVVC.MaDVVC = '" + MaDVVC + "'" +
       "group by DH.MaDH, KH.TenKH, KH.DiaChi, KH.SDT, DVVC.TenDVVC, DH.HinhThucThanhToan, DH.TrangThai, DH.YeuCauVanChuyen, DH.PhiVanChuyen, DH.TongTien, DVVC.MaDVVC" +
       " having DH.YeuCauVanChuyen = N'Chờ tiếp nhận' and DH.TrangThai = N'Đang giao' or DH.TrangThai = N'Đổi trả'";
                return GetData(query);

            }

        [Route("api/DVVC/0")]
        public HttpResponseMessage GetDVVC1()
        {
            string query = @"
            select	DH.MaDH, KH.TenKH, KH.DiaChi, KH.SDT, DVVC.TenDVVC, DH.HinhThucThanhToan, DH.TrangThai, DH.YeuCauVanChuyen, DH.PhiVanChuyen, DH.TongTien
            from	DonHang DH, DonViVanChuyen DVVC, KhachHang KH
            where	DH.MaKH = KH.MaKH
	            and DH.MaDVVC = DVVC.MaDVVC";
            return GetData(query);
        }

        [Route("api/DVVC/{MaDVVC}")]
        public HttpResponseMessage GetDVVC1(int MaDVVC)
        {
            string query = @"
            select	DH.MaDH, KH.TenKH, KH.DiaChi, KH.SDT, DVVC.TenDVVC, DH.HinhThucThanhToan, DH.TrangThai, DH.YeuCauVanChuyen, DH.PhiVanChuyen, DH.TongTien
            from	DonHang DH, DonViVanChuyen DVVC, KhachHang KH
            where	DH.MaKH = KH.MaKH
	            and DH.MaDVVC = DVVC.MaDVVC
                and DVVC.MaDVVC = '" + MaDVVC + "'";
            return GetData(query);

        }

        public HttpResponseMessage GetData(string query)
        {
            SqlDataAdapter da = new SqlDataAdapter(query, con);

            DataTable dt = new DataTable();
            da.Fill(dt);

            return Request.CreateResponse(HttpStatusCode.OK, dt);
        }
    }
}