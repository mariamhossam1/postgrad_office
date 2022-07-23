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
    public partial class studentreg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void student(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String first = firstname.Text;
            String last = lastname.Text;
            String pass = password.Text;
            String emailaddress = email.Text;
            String add = address.Text;
            String fac = faculty.Text;
            Boolean guc = Gucian.Checked;

            SqlCommand studentreg = new SqlCommand("StudentsRegister", conn);
            studentreg.CommandType = CommandType.StoredProcedure;

            studentreg.Parameters.Add(new SqlParameter("@first_name", first));
            studentreg.Parameters.Add(new SqlParameter("@last_name", last));
            studentreg.Parameters.Add(new SqlParameter("@password", pass));
            studentreg.Parameters.Add(new SqlParameter("@email", emailaddress));
            studentreg.Parameters.Add(new SqlParameter("@Gucian", guc));
            studentreg.Parameters.Add(new SqlParameter("@faculty", fac));
            studentreg.Parameters.Add(new SqlParameter("@address", add));

            SqlParameter success = studentreg.Parameters.Add("@Success", SqlDbType.Int);
            SqlParameter id = studentreg.Parameters.Add("@ID", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;
            id.Direction = ParameterDirection.Output;

            conn.Open();
            studentreg.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                Session["user"] = id.Value;
                Response.Redirect("StudentView.aspx");
            }
            else
            {
                Response.Write("Registration Failed");
            }
        }
    }
}