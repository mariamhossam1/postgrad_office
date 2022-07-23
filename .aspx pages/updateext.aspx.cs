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
    public partial class updateext : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void extup(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            int thsn = Int16.Parse(thesis.Text);

            SqlCommand thexists = new SqlCommand("ThesisExists", conn);
            thexists.CommandType = CommandType.StoredProcedure;
            thexists.Parameters.Add(new SqlParameter("@ThesisSerialNo", thsn));

            SqlParameter success = thexists.Parameters.Add("@Success", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;

            conn.Open();
            thexists.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                String connStr1 = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
                //create new connection
                SqlConnection conn1 = new SqlConnection(connStr1);

                int thesisno = Int16.Parse(thesis.Text);

                SqlCommand updateext = new SqlCommand("AdminsUpdateExtension", conn);
                updateext.CommandType = CommandType.StoredProcedure;
                updateext.Parameters.Add(new SqlParameter("@ThesisSerialNo", thesisno));

                SqlParameter success1 = updateext.Parameters.Add("@Success", SqlDbType.Int);

                success1.Direction = ParameterDirection.Output;

                conn.Open();
                updateext.ExecuteNonQuery();
                conn.Close();

                if (success.Value.ToString() == "1")
                {
                    Response.Write("Extension Updated Successfully");
                }
                else
                {
                    Response.Write("Process Failed");
                }
            }
            else
            {
                Response.Write("Thesis Serial Number entered does not exist!");
            }
        }

        protected void adback(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            Response.Redirect("admin.aspx");
        }
    }
}