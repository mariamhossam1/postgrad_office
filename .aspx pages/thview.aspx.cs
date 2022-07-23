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
    public partial class thview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand thlist = new SqlCommand("AdminViewAllTheses", conn);
            thlist.CommandType = CommandType.StoredProcedure;

            conn.Open();
            GridView1.DataSource = thlist.ExecuteReader();
            GridView1.DataBind();
            conn.Close();
        }

        protected void ongoing(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand thcount = new SqlCommand("AdminsViewOnGoingTheses", conn);
            thcount.CommandType = CommandType.StoredProcedure;

            SqlParameter count = thcount.Parameters.Add("@ThesisCount", SqlDbType.Int);

            count.Direction = ParameterDirection.Output;

            conn.Open();
            thcount.ExecuteNonQuery();
            conn.Close();

            Label1.Text = count.Value.ToString();
        }

        protected void adback(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            Response.Redirect("admin.aspx");
        }
    }
}