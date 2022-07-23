using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ByteMe
{
    public partial class AddandLinkPublication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void title_TextChanged(object sender, EventArgs e)
        {

        }

        protected void AddPub(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["sara"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            String Title = title.Text;
            DateTime Date = DateTime.Parse(date.Text);
            String Host = host.Text;
            bool Accepted = bool.Parse(accepted.Text);
            String Place = place.Text;

            SqlCommand AddProc = new SqlCommand("addPublication", conn);
            AddProc.CommandType = CommandType.StoredProcedure;

            AddProc.Parameters.Add(new SqlParameter("@title", SqlDbType.VarChar)).Value = Title;
            AddProc.Parameters.Add(new SqlParameter("@pubDate", SqlDbType.DateTime)).Value = Date;
            AddProc.Parameters.Add(new SqlParameter("@host", SqlDbType.VarChar)).Value = Host;
            AddProc.Parameters.Add(new SqlParameter("@accepted", SqlDbType.Bit)).Value = Accepted;
            AddProc.Parameters.Add(new SqlParameter("@place", SqlDbType.VarChar)).Value = Place;

            conn.Open();
            AddProc.ExecuteNonQuery();
            conn.Close();




        }

        protected void LinkPub(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["sara"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            int ID = int.Parse(id.Text);
            int SN = int.Parse(sn.Text);

            SqlCommand LinkProc = new SqlCommand("linkPubThesis", conn);
            LinkProc.CommandType = CommandType.StoredProcedure;

            LinkProc.Parameters.Add(new SqlParameter("@PubID", SqlDbType.Int)).Value = ID;
            LinkProc.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = SN;

            conn.Open();
            LinkProc.ExecuteNonQuery();
            conn.Close();





        }

        protected void backstud(object sender, EventArgs e)
        {
            Response.Redirect("StudentView.aspx");
        }
    }
}