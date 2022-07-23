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
    public partial class SupervisorsList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand suplist = new SqlCommand("AdminListSup", conn);
            suplist.CommandType = CommandType.StoredProcedure;

            conn.Open();
            GridView1.DataSource = suplist.ExecuteReader();
            GridView1.DataBind();
            conn.Close();
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