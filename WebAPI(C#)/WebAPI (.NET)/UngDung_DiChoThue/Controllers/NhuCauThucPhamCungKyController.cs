using Newtonsoft.Json;
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
    public class NhuCauThucPhamCungKyController : ApiController
    {
        SqlConnection con = new SqlConnection(@"Data Source=.;Initial Catalog=QL_DiChoThue;Integrated Security=True");

        //GET api/NhuCauThucPhamCungKy/[MaSP]/[MaNCC]/[type]/[value]
        [Route("api/NhuCauThucPhamCungKy/{MaSP}/{MaNCC}/{type}/{value}")]
        public HttpResponseMessage Get(int MaSP, int MaNCC, string type, int value)
        {
            if (MaSP != 0)
            {
                if (MaNCC == 0) // Không lọc theo NCC
                {
                    if (type == "ChooseYearAllQuarter")
                    {
                        string query = @"
                        SELECT V.Quy, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia, sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Nam = '" + value + "' AND V.MaSP = '" + MaSP + "' " +
                            "GROUP BY V.Quy, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia ";
                        return GetData(query);
                    }
                    else if (type == "ChooseYearAllMonth")
                    {
                        string query = @"
                        SELECT V.Thang,V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia, sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Nam = '" + value + "' AND V.MaSP = '" + MaSP + "' " +
                            "GROUP BY V.Thang, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia";
                        return GetData(query);
                    }
                    else if (type == "ChooseQuarterAllYear")
                    {
                        string query = @"
                        SELECT V.Nam,V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia, sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Quy = '" + value + "' AND V.MaSP = '" + MaSP + "' " +
                            "GROUP BY V.Nam, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia";
                        return GetData(query);
                    }
                    else // ChooseMonthAllYear
                    {
                        string query = @"
                        SELECT V.Nam, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia,  sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Thang = '" + value + "' AND V.MaSP = '" + MaSP + "' " +
                            "GROUP BY V.Nam, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia";
                        return GetData(query);
                    }
                }
                else //  lọc thêm NCC
                {
                    if (type == "ChooseYearAllQuarter")
                    {
                        string query = @"
                        SELECT V.Quy, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia, sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Nam = '" + value + "' AND V.MaSP = '" + MaSP + "' AND V.MaNCC = '" + MaNCC + "' " +
                            "GROUP BY V.Quy, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia ";
                        return GetData(query);
                    }
                    else if (type == "ChooseYearAllMonth")
                    {
                        string query = @"
                        SELECT V.Thang, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia, sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Nam = '" + value + "' AND V.MaSP = '" + MaSP + "' AND V.MaNCC = '" + MaNCC + "' " +
                            "GROUP BY V.Thang, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia ";
                        return GetData(query);
                    }
                    else if (type == "ChooseQuarterAllYear")
                    {
                        string query = @"
                        SELECT V.Nam, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia, sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Quy = '" + value + "' AND V.MaSP = '" + MaSP + "' AND V.MaNCC = '" + MaNCC + "' " +
                            "GROUP BY V.Nam,V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia";
                        return GetData(query);
                    }
                    else // ChooseMonthAllYear
                    {
                        string query = @"
                        SELECT V.Nam, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia,  sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Thang = '" + value + "' AND V.MaSP = '" + MaSP + "' AND V.MaNCC = '" + MaNCC + "' " +
                            "GROUP BY V.Nam, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia";
                        return GetData(query);
                    }
                }
            }
            else // MaSP == 0
            {
                if (MaNCC == 0)
                {
                    if (type == "ChooseYearAllQuarter")
                    {
                        string query = @"
                        SELECT V.Quy, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia,  sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Nam = '" + value + "' " +
                            "GROUP BY V.Quy, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia";
                        return GetData(query);
                    }
                    else if (type == "ChooseYearAllMonth")
                    {
                        string query = @"
                        SELECT V.Thang,V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia,  sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Nam = '" + value + "' " +
                            "GROUP BY V.Thang, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia";
                        return GetData(query);
                    }
                    else if (type == "ChooseQuarterAllYear")
                    {
                        string query = @"
                        SELECT V.Nam, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia, sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Quy = '" + value + "' AND '" +
                            "GROUP BY V.Nam,V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia";
                        return GetData(query);
                    }
                    else // ChooseMonthAllYear
                    {
                        string query = @"
                        SELECT V.Nam, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia,  sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Thang = '" + value + "' " +
                            "GROUP BY V.Nam, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia, ";
                        return GetData(query);
                    }
                }
                else // MaNCC != 0
                {
                    if (type == "ChooseYearAllQuarter")
                    {
                        string query = @"
                        SELECT V.Quy, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia, sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Nam = '" + value + "' AND V.MaNCC = '" + MaNCC + "' " +
                            "GROUP BY V.Quy, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia, ";
                        return GetData(query);
                    }
                    else if (type == "ChooseYearAllMonth")
                    {
                        string query = @"
                        SELECT V.Thang, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia, sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Nam = '" + value + "' AND V.MaSP = '" + MaSP + "' AND V.MaNCC = '" + MaNCC + "' " +
                            "GROUP BY V.Thang, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia, ";
                        return GetData(query);
                    }
                    else if (type == "ChooseQuarterAllYear")
                    {
                        string query = @"
                        SELECT V.Nam, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia, sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Quy = '" + value + "' AND V.MaSP = '" + MaSP + "' AND V.MaNCC = '" + MaNCC + "' " +
                            "GROUP BY V.Nam, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia, ";
                        return GetData(query);
                    }
                    else // ChooseMonthAllYear
                    {
                        string query = @"
                        SELECT V.Nam, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia,  sum(V.SLBanRa) AS 'SLBanRa'
                        FROM V_ThongKe_NhuCau_CungKy V
                        WHERE V.Thang = '" + value + "' AND V.MaSP = '" + MaSP + "' AND V.MaNCC = '" + MaNCC + "' " +
                            "GROUP BY V.Nam, V.MaSP, V.TenSP, V.MaNCC, V.TenNCC, V.DonViTinh, V.Gia, ";
                        return GetData(query);
                    }
                }
            }
        }

        // Thống kê tất cả SP của tất cả NCC theo năm hoặc tất cả năm
        //GET api/NhuCauThucPhamCungKy/[type]
        [Route("api/NhuCauThucPhamCungKy/{type}")]
        public HttpResponseMessage Get(string type)
        {
            string query = "";
            if (type == "Year")
            {
                query = @"SELECT DISTINCT Nam FROM V_ThongKe_NhuCau_CungKy";
            }
            else if (type == "All")
            {
                query = @"SELECT * FROM V_ThongKe_NhuCau_CungKy";
            }
            return GetData(query);

        }

        // Thống kê nhu cầu của SanPham của NCC theo tất cả các năm
        //GET api/NhuCauThucPhamCungKy/All/[MaSP]/[MaNCC]
        [Route("api/NhuCauThucPhamCungKy/All/{MaSP}/{MaNCC}")]
        public HttpResponseMessage Get(int MaSP, int MaNCC)
        {
            string query = query = @"SELECT V.Nam, V.TenSP, V.TenNCC, V.DonViTinh, V.Gia, SUM(V.SLBanRa) AS 'SLBanRa'
                                        FROM V_ThongKe_NhuCau_CungKy V
                                        WHERE V.MaSP = '" + MaSP + "' AND v.MaNCC = '" + MaNCC + "' " +
                                        "GROUP BY V.Nam, V.TenSP, V.TenNCC, V.DonViTinh, V.Gia";

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
