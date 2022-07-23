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
    public partial class ListCourses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ViewCourses(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            int ID = (int)Session["user"];

            SqlCommand CoursesProc = new SqlCommand("ViewCoursesGrades", conn);
            CoursesProc.CommandType = CommandType.StoredProcedure;

            CoursesProc.Parameters.Add(new SqlParameter("@studentID", SqlDbType.Int)).Value = ID;

            conn.Open();
            CoursesProc.ExecuteNonQuery();
            GridView1.DataSource = CoursesProc.ExecuteReader();
            GridView1.DataBind();
            conn.Close();

        }

        protected void backstud(object sender, EventArgs e)
        {
            Response.Redirect("StudentView.aspx");
        }
    }
}