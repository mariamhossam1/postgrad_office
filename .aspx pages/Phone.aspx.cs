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
    public partial class Phone : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void phoneno(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            int ID = (int)Session["user"];
            string phoneno = phones.Text;

            SqlCommand addnoproc = new SqlCommand("addMobileNo", conn);
            addnoproc.CommandType = CommandType.StoredProcedure;
            addnoproc.Parameters.Add(new SqlParameter("@ID", ID));
            addnoproc.Parameters.Add(new SqlParameter("@mobile_number", phoneno));

            SqlParameter success = addnoproc.Parameters.Add("@Success", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;

            conn.Open();
            addnoproc.ExecuteNonQuery();
            conn.Close();

            if(success.Value.ToString() == "1")
            {
                Response.Write("Phone number added successfully!");
            }
            else
            {
                Response.Write("Process failed, please try again!");
            }
        }

        protected void backstud(object sender, EventArgs e)
        {
            Response.Redirect("StudentView.aspx");
        }
    }
}