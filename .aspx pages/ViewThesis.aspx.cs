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
    public partial class ViewThesis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }



        protected void ViewT(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            int ID = (int)Session["user"];


            SqlCommand ViewThesisProc = new SqlCommand("ViewThesis", conn);
            ViewThesisProc.CommandType = CommandType.StoredProcedure;
            ViewThesisProc.Parameters.Add(new SqlParameter("@studentID", ID));

            conn.Open();
            ViewThesisProc.ExecuteNonQuery();
            GridView1.DataSource = ViewThesisProc.ExecuteReader();
            GridView1.DataBind();
            conn.Close();

        }

        protected void backstud(object sender, EventArgs e)
        {
            Response.Redirect("StudentView.aspx");
        }
    }
}