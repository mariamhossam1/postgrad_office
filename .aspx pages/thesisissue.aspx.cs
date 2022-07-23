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
    public partial class thesisissue : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void issue(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            int thsn = Int16.Parse(thesisno.Text);

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

                int thesis = Int16.Parse(thesisno.Text);
                decimal am = decimal.Parse(amount.Text);
                int noinstall = Int16.Parse(noinst.Text);
                decimal fundp = decimal.Parse(fundperc.Text);

                SqlCommand issuethesis = new SqlCommand("AdminIssueThesisPayment", conn1);
                issuethesis.CommandType = CommandType.StoredProcedure;
                issuethesis.Parameters.Add(new SqlParameter("@ThesisSerialNo", thesis));
                issuethesis.Parameters.Add(new SqlParameter("@amount", am));
                issuethesis.Parameters.Add(new SqlParameter("@noOfInstallments", noinstall));
                issuethesis.Parameters.Add(new SqlParameter("@fundPercentage", fundp));

                SqlParameter success1 = issuethesis.Parameters.Add("@Success", SqlDbType.Int);

                success1.Direction = ParameterDirection.Output;

                conn1.Open();
                issuethesis.ExecuteNonQuery();
                conn1.Close();

                if (success1.Value.ToString() == "1")
                {
                    Response.Write("Thesis Issued Successfully!");
                }
                else
                {
                    Response.Write("Process Failed!");
                }
            }
            else
            {
                Response.Write("Thesis Serial Number entered doesn't exist!");
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