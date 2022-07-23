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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String email = emailadd.Text;
            String pass = password.Text;

            SqlCommand loginProc = new SqlCommand("usersLogin", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@email", email));
            loginProc.Parameters.Add(new SqlParameter("@password", pass));

            SqlParameter success = loginProc.Parameters.Add("@Success", SqlDbType.Int);
            SqlParameter type = loginProc.Parameters.Add("@type", SqlDbType.Int);
            SqlParameter id = loginProc.Parameters.Add("@ID", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;
            type.Direction = ParameterDirection.Output;
            id.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                Session["user"] = id.Value;
                if (type.Value.ToString() == "1")
                {
                    Response.Redirect("admin.aspx");
                }
                else if(type.Value.ToString()== "2")
                {
                    Response.Redirect("Supervisor.aspx");
                }
                else if(type.Value.ToString() == "0")
                {
                    Response.Redirect("StudentView.aspx");
                }
                else
                {
                    Response.Redirect("ExaminerView.aspx");
                }
            }
            else
            {
                Response.Write("Email or password may be incorrect!");
            }
        }

        protected void register(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);
            Response.Redirect("register.aspx");
        }
    }
}