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
    public partial class StudentView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }

        protected void ViewProfile(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            int ID = (int)Session["user"];

            SqlCommand ViewProc = new SqlCommand("viewMyProfile", conn);
            ViewProc.CommandType = CommandType.StoredProcedure;


            ViewProc.Parameters.Add(new SqlParameter("@studentId", SqlDbType.Int)).Value = ID;



            conn.Open();
            ViewProc.ExecuteNonQuery();
            GridView1.DataSource = ViewProc.ExecuteReader();
            GridView1.DataBind();
            conn.Close();
        }

        protected void courselist(object sender, EventArgs e)
        {
            Response.Redirect("ListCourses.aspx");
        }

        protected void pubadd(object sender, EventArgs e)
        {
            Response.Redirect("AddandLinkPublication.aspx");
        }

        protected void progadd(object sender, EventArgs e)
        {
            Response.Redirect("AddProgressReport.aspx");
        }

        protected void progfill(object sender, EventArgs e)
        {
            Response.Redirect("FillProgressReport.aspx");
        }

        protected void viewth(object sender, EventArgs e)
        {
            Response.Redirect("ViewThesis.aspx");
        }
        protected void phoneno(object sender, EventArgs e)
        {
            Response.Redirect("Phone.aspx");
        }

        protected void backlog(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}
