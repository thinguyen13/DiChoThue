using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using UngDung_DiChoThue.Model;

namespace UngDung_DiChoThue.Controllers
{
    public class DonHangController : ApiController
    {
        private DonHangDBContext db = new DonHangDBContext();

        // GET: api/DonHang
        public IQueryable<DonHang> GetDonHangs()
        {
            return db.DonHangs;
        }

        // GET: api/DonHang/5
        [ResponseType(typeof(DonHang))]
        public IHttpActionResult GetDonHang(int id)
        {
            DonHang donHang = db.DonHangs.Find(id);
            if (donHang == null)
            {
                return NotFound();
            }

            return Ok(donHang);
        }

        [Route("api/ThemDH")]
        [HttpPost]
        public IHttpActionResult PostDH([FromBody]DonHang donhang)
        {
            DonHang dh = new DonHang();
            dh.NgayLap = donhang.NgayLap;
            dh.TongTien = donhang.TongTien;
            dh.TrangThai = donhang.TrangThai;
            dh.MaKH = donhang.MaKH;
            dh.HinhThucThanhToan = donhang.HinhThucThanhToan;
            dh.YeuCauVanChuyen = donhang.YeuCauVanChuyen;
            dh.MaDVVC = donhang.MaDVVC;
            dh.PhiVanChuyen = donhang.PhiVanChuyen;
            try 
            {
                db.DonHangs.Add(dh);
                db.SaveChanges();
            }
            catch(Exception ex)
            {
                return BadRequest();
                throw;
            }
            return Ok();
        }

        [Route("api/CapNhatTTDH")]
        [HttpPut]
        public IHttpActionResult UpdateTTDH([FromBody] DonHang donhang)
        {
            try
            {
                var dh = db.DonHangs.FirstOrDefault(x => x.MaDH == donhang.MaDH);
                if (dh == null)
                {
                    return BadRequest();
                }
                dh.NgayLap = donhang.NgayLap;
                dh.TongTien = donhang.TongTien;
                dh.TrangThai = donhang.TrangThai;
                dh.MaKH = donhang.MaKH;
                dh.HinhThucThanhToan = donhang.HinhThucThanhToan;
                dh.MaDVVC = donhang.MaDVVC;
                dh.YeuCauVanChuyen = donhang.YeuCauVanChuyen;
                dh.PhiVanChuyen = donhang.PhiVanChuyen;
                db.Entry(dh).State = EntityState.Modified;
                db.SaveChanges();
            }
            catch(Exception ex)
            {
                return BadRequest();
                throw;
            }
            return Ok();
        }

        // POST: api/DonHang
        //[ResponseType(typeof(DonHang))]
        //public IHttpActionResult PostDonHang(DonHang donHang)
        //{
        //    if (!ModelState.IsValid)
        //    {
        //        return BadRequest(ModelState);
        //    }

        //    db.DonHangs.Add(donHang);
        //    db.SaveChanges();

        //    return CreatedAtRoute("DefaultApi", new { id = donHang.MaDH }, donHang);
        //}

        //// DELETE: api/DonHang/5
        //[ResponseType(typeof(DonHang))]
        //public IHttpActionResult DeleteDonHang(int id)
        //{
        //    DonHang donHang = db.DonHangs.Find(id);
        //    if (donHang == null)
        //    {
        //        return NotFound();
        //    }

        //    db.DonHangs.Remove(donHang);
        //    db.SaveChanges();

        //    return Ok(donHang);
        //}

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool DonHangExists(int id)
        {
            return db.DonHangs.Count(e => e.MaDH == id) > 0;
        }


        
    }
}