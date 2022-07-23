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
    public partial class FillProgressReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void FillPR(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["sara"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            int SN = Int16.Parse(sn.Text);
            int PR = Int16.Parse(pr.Text);
            int S = Int16.Parse(s.Text);

            String D = d.Text;

            SqlCommand FillPRProc = new SqlCommand("FillProgressReport", conn);
            FillPRProc.CommandType = CommandType.StoredProcedure;

            FillPRProc.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = SN;
            FillPRProc.Parameters.Add(new SqlParameter("@progressReportNo ", SqlDbType.Int)).Value = PR;
            FillPRProc.Parameters.Add(new SqlParameter("@state  ", SqlDbType.Int)).Value = S;
            FillPRProc.Parameters.Add(new SqlParameter("@description ", SqlDbType.VarChar)).Value = D;

            conn.Open();
            FillPRProc.ExecuteNonQuery();
            conn.Close();
        }

        protected void backstud(object sender, EventArgs e)
        {
            Response.Redirect("StudentView.aspx");
        }
    }
}