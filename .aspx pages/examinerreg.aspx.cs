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
    public partial class examinerreg : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void examiner(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String first = firstname.Text;
            String last = lastname.Text;
            String pass = password.Text;
            String emailaddress = email.Text;
            String field = fieldofwork.Text;
            Boolean isNational = national.Checked;

            SqlCommand examinerreg = new SqlCommand("ExaminerRegister", conn);
            examinerreg.CommandType = CommandType.StoredProcedure;

            examinerreg.Parameters.Add(new SqlParameter("@first_name", first));
            examinerreg.Parameters.Add(new SqlParameter("@last_name", last));
            examinerreg.Parameters.Add(new SqlParameter("@password", pass));
            examinerreg.Parameters.Add(new SqlParameter("@email", emailaddress));
            examinerreg.Parameters.Add(new SqlParameter("@isNational", isNational));
            examinerreg.Parameters.Add(new SqlParameter("@fieldofwork", field));

            SqlParameter success = examinerreg.Parameters.Add("@Success", SqlDbType.Int);
            SqlParameter id = examinerreg.Parameters.Add("@ID", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;
            id.Direction = ParameterDirection.Output;

            conn.Open();
            examinerreg.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                Session["user"] = id.Value;
                Response.Redirect("ExaminerView.aspx");
            }
            else
            {
                Response.Write("Registration Failed");
            }
        }
    }
}