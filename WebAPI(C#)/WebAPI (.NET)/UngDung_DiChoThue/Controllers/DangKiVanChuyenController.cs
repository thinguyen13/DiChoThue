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
    public class DangKiVanChuyenController : ApiController
    {
        // GET: DangKiVanChuyen
        SqlConnection con = new SqlConnection(@"Data Source=.;Initial Catalog=QL_DiChoThue;Integrated Security=True");

        //GET api/SanPham/0
        [Route("api/DonViVanChuyen/0")]
        public HttpResponseMessage Get()
        {
            string query = @"SELECT * FROM DonViVanChuyen";

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