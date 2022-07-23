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
    public partial class AddProgressReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddPR(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["sara"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            int SN = Int16.Parse(sn.Text);
            DateTime PR = DateTime.Parse(pr.Text);

            SqlCommand ADDPRProc = new SqlCommand("AddProgressReport", conn);
            ADDPRProc.CommandType = CommandType.StoredProcedure;

            ADDPRProc.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = SN;
            ADDPRProc.Parameters.Add(new SqlParameter("@progressReportDate ", SqlDbType.DateTime)).Value = PR;

            conn.Open();
            ADDPRProc.ExecuteNonQuery();
            conn.Close();
        }

        protected void backstud(object sender, EventArgs e)
        {
            Response.Redirect("StudentView.aspx");
        }
    }
}