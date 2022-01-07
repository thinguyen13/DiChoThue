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
    public class ThongTinDonHangController : ApiController
    {
        // GET: ThongTinDonHang
        SqlConnection con = new SqlConnection(@"Data Source=.;Initial Catalog=QL_DiChoThue;Integrated Security=True");

        [Route("api/ThongTinDonHang/0")]
        public HttpResponseMessage Get()
        {
            string query = @"SELECT * FROM DonHang";

            return GetData(query);

        }
        //GET api/ThongTinDonHang/MaDH
        [Route("api/ThongTinDonHang/{MaKH}")]
        public HttpResponseMessage Get(int MaKH)
        {
            string query = @"
            SELECT DH.MaDH, SP.TenSP, NCC.TenNCC,  CTDH.SoLuong, SPNCC.Gia
            FROM SanPham SP, ChiTietDonHang CTDH, NhaCungCap NCC, DonHang DH, SanPham_NCC SPNCC
            Where	CTDH.MaNCC = NCC.MaNCC
	            AND CTDH.MaSP = SP.MaSP
	            AND CTDH.MaDH = DH.MaDH
	            AND SPNCC.MaNCC = NCC.MaNCC
	            AND SPNCC.MaSP = SP.MaSP
	            AND DH.MaKH = '" + MaKH + "' ";

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
