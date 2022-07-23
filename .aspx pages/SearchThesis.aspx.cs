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
    public partial class SearchThesis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void disp(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            String key = keyword.Text;

            SqlCommand search = new SqlCommand("ThesisTitle", conn);
            search.CommandType = CommandType.StoredProcedure;
            search.Parameters.Add(new SqlParameter("@keyword", key));

            SqlParameter success = search.Parameters.Add("@Success", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;

            conn.Open();
            search.ExecuteNonQuery();

            if(success.Value.ToString() == "1")
            {
                GridView1.DataSource = search.ExecuteReader();
                GridView1.DataBind();
            }
            else
            {
                Response.Write("No Thesis Titles Contain This Keyword!");
            }

            conn.Close();
        }

        protected void backhome(object sender, EventArgs e)
        {
            Response.Redirect("ExaminerView.aspx");
        }
    }
}