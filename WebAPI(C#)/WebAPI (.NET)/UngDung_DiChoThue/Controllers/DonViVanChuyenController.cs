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
    public class DonViVanChuyenController : ApiController
    {
        private DonViVanChuyenDBContext db = new DonViVanChuyenDBContext();

        // GET: api/DonViVanChuyen
        public IQueryable<DonViVanChuyen> GetDonViVanChuyens()
        {
            return db.DonViVanChuyens;
        }

        // GET: api/DonViVanChuyen/5
        [ResponseType(typeof(DonViVanChuyen))]
        public IHttpActionResult GetDonViVanChuyen(int id)
        {
            DonViVanChuyen donViVanChuyen = db.DonViVanChuyens.Find(id);
            if (donViVanChuyen == null)
            {
                return NotFound();
            }

            return Ok(donViVanChuyen);
        }

        // PUT: api/DonViVanChuyen/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutDonViVanChuyen(int id, DonViVanChuyen donViVanChuyen)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != donViVanChuyen.MaDVVC)
            {
                return BadRequest();
            }

            db.Entry(donViVanChuyen).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!DonViVanChuyenExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/DonViVanChuyen
        [Route("api/DonViVanChuyen")]
        [HttpPost]
        public IHttpActionResult PostDVVC([FromBody] DonViVanChuyen donvivanchuyen)
        {
            DonViVanChuyen dvvc = new DonViVanChuyen();
            dvvc.TenDVVC = donvivanchuyen.TenDVVC;
            dvvc.GiayPhepKinhDoanh = donvivanchuyen.GiayPhepKinhDoanh;
            dvvc.SoTaiKhoanNganHang = donvivanchuyen.SoTaiKhoanNganHang;
            dvvc.SDT = donvivanchuyen.SDT;
            dvvc.DiaChi = donvivanchuyen.DiaChi;
            dvvc.Email = donvivanchuyen.Email;
            dvvc.PhiVanChuyen_KM = donvivanchuyen.PhiVanChuyen_KM;
            dvvc.TaiKhoan = donvivanchuyen.TaiKhoan;
            try
            {
                db.DonViVanChuyens.Add(dvvc);
                db.SaveChanges();
            }
            catch (Exception ex)
            {
                return BadRequest();
                throw;
            }
            return Ok();
        }

        // DELETE: api/DonViVanChuyen/5
        [ResponseType(typeof(DonViVanChuyen))]
        public IHttpActionResult DeleteDonViVanChuyen(int id)
        {
            DonViVanChuyen donViVanChuyen = db.DonViVanChuyens.Find(id);
            if (donViVanChuyen == null)
            {
                return NotFound();
            }

            db.DonViVanChuyens.Remove(donViVanChuyen);
            db.SaveChanges();

            return Ok(donViVanChuyen);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool DonViVanChuyenExists(int id)
        {
            return db.DonViVanChuyens.Count(e => e.MaDVVC == id) > 0;
        }
    }
}