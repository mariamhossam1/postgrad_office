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
    public partial class EditExaminer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void upprof(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String name = adoom.Text;
            String foe = adam.Text;
            String email = mail.Text;
            String password = pass.Text;
            int id = (int)Session["user"];

            SqlCommand editexam = new SqlCommand("EditExaminer", conn);
            editexam.CommandType = CommandType.StoredProcedure;
            editexam.Parameters.Add(new SqlParameter("@examinerID", id));
            editexam.Parameters.Add(new SqlParameter("@examinerName", name));
            editexam.Parameters.Add(new SqlParameter("@examinerfoe", foe));
            editexam.Parameters.Add(new SqlParameter("@examineremail", email));
            editexam.Parameters.Add(new SqlParameter("@examinerpassword", password));

            conn.Open();
            editexam.ExecuteNonQuery();
            conn.Close();

            Response.Write("Profile Updated Successfully!");
        }

        protected void backhome(object sender, EventArgs e)
        {
            Response.Redirect("ExaminerView.aspx");
        }
    }
}