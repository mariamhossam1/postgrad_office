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
    public partial class DefAttend : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            int id = (int)Session["user"];

            SqlCommand viewdef = new SqlCommand("ViewAll", conn);
            viewdef.CommandType = CommandType.StoredProcedure;
            viewdef.Parameters.Add(new SqlParameter("@examinerID", id));

            conn.Open();
            GridView1.DataSource = viewdef.ExecuteReader();
            GridView1.DataBind();
            conn.Close();
        }

        protected void backhome(object sender, EventArgs e)
        {
            Response.Redirect("ExaminerView.aspx");
        }
    }
}