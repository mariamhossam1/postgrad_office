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
    public partial class supervisorreg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void supervisor(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String first = firstname.Text;
            String last = lastname.Text;
            String pass = password.Text;
            String emailaddress = email.Text;
            String fac = faculty.Text;

            SqlCommand supervisorreg = new SqlCommand("SupervisorsRegister", conn);
            supervisorreg.CommandType = CommandType.StoredProcedure;

            supervisorreg.Parameters.Add(new SqlParameter("@first_name", first));
            supervisorreg.Parameters.Add(new SqlParameter("@last_name", last));
            supervisorreg.Parameters.Add(new SqlParameter("@password", pass));
            supervisorreg.Parameters.Add(new SqlParameter("@email", emailaddress));
            supervisorreg.Parameters.Add(new SqlParameter("@faculty", fac));

            SqlParameter success = supervisorreg.Parameters.Add("@Success", SqlDbType.Int);
            SqlParameter id = supervisorreg.Parameters.Add("@ID", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;
            id.Direction = ParameterDirection.Output;

            conn.Open();
            supervisorreg.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                Session["user"] = id.Value;
                Response.Redirect("Supervisor.aspx");
            }
            else
            {
                Response.Write("Registration Failed");
            }
        }
    }
}