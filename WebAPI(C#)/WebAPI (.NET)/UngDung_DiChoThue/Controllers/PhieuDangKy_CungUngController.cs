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
    public class PhieuDangKy_CungUngController : ApiController
    {
        private PhieuDangKy_CungUngDBContext db = new PhieuDangKy_CungUngDBContext();

        // GET: api/PhieuDangKy_CungUng
        public IQueryable<PhieuDangKy_CungUng> GetPhieuDangKy_CungUng()
        {
            return db.PhieuDangKy_CungUng;
        }

        // GET: api/PhieuDangKy_CungUng/5
        [ResponseType(typeof(PhieuDangKy_CungUng))]
        public IHttpActionResult GetPhieuDangKy_CungUng(int id)
        {
            PhieuDangKy_CungUng phieuDangKy_CungUng = db.PhieuDangKy_CungUng.Find(id);
            if (phieuDangKy_CungUng == null)
            {
                return NotFound();
            }

            return Ok(phieuDangKy_CungUng);
        }

        // PUT: api/PhieuDangKy_CungUng/5
        [Route("api/CapNhatTTPDKCU")]
        [HttpPut]
        public IHttpActionResult UpdateTTPDKCU([FromBody] PhieuDangKy_CungUng phieudk)
        {
            try
            {
                var pdk = db.PhieuDangKy_CungUng.FirstOrDefault(x => x.MaPhieuDKCU == phieudk.MaPhieuDKCU);
                if (pdk == null)
                {
                    return BadRequest();
                }
                pdk.MaNCC = phieudk.MaNCC;
                pdk.NgayDK = phieudk.NgayDK;
                pdk.TrangThai = phieudk.TrangThai;
                db.Entry(pdk).State = EntityState.Modified;
                db.SaveChanges();
            }
            catch (Exception ex)
            {
                return BadRequest();
                throw;
            }
            return Ok();
        }

        // POST: api/PhieuDangKy_CungUng
        [ResponseType(typeof(PhieuDangKy_CungUng))]
        public IHttpActionResult PostPhieuDangKy_CungUng(PhieuDangKy_CungUng phieuDangKy_CungUng)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.PhieuDangKy_CungUng.Add(phieuDangKy_CungUng);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = phieuDangKy_CungUng.MaPhieuDKCU }, phieuDangKy_CungUng);
        }

        // DELETE: api/PhieuDangKy_CungUng/5
        [ResponseType(typeof(PhieuDangKy_CungUng))]
        public IHttpActionResult DeletePhieuDangKy_CungUng(int id)
        {
            PhieuDangKy_CungUng phieuDangKy_CungUng = db.PhieuDangKy_CungUng.Find(id);
            if (phieuDangKy_CungUng == null)
            {
                return NotFound();
            }

            db.PhieuDangKy_CungUng.Remove(phieuDangKy_CungUng);
            db.SaveChanges();

            return Ok(phieuDangKy_CungUng);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool PhieuDangKy_CungUngExists(int id)
        {
            return db.PhieuDangKy_CungUng.Count(e => e.MaPhieuDKCU == id) > 0;
        }
    }
}