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
    public partial class installissue : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void issinst(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            int pay = Int16.Parse(payment.Text);

            SqlCommand paymentexists = new SqlCommand("PaymentIdExists", conn);
            paymentexists.CommandType = CommandType.StoredProcedure;
            paymentexists.Parameters.Add(new SqlParameter("@paymentID", pay));

            SqlParameter success = paymentexists.Parameters.Add("@Success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;

            conn.Open();
            paymentexists.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                String connStr1 = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
                //create new connection
                SqlConnection conn1 = new SqlConnection(connStr1);

                int payid = Int16.Parse(payment.Text);
                DateTime inst = DateTime.Parse(inststartdate.Text);

                SqlCommand issueinstall = new SqlCommand("AdminsIssueInstallPayment", conn1);
                issueinstall.CommandType = CommandType.StoredProcedure;
                issueinstall.Parameters.Add(new SqlParameter("@paymentID", payid));
                issueinstall.Parameters.Add(new SqlParameter("@InstallStartDate", inst));

                SqlParameter success1 = issueinstall.Parameters.Add("@Success", SqlDbType.Int);

                success1.Direction = ParameterDirection.Output;

                conn1.Open();
                issueinstall.ExecuteNonQuery();
                conn1.Close();

                if (success1.Value.ToString() == "1")
                {
                    Response.Write("Installments Issued Successfully!");
                }
                else
                {
                    Response.Write("Process Failed, please enter a date that has not passed!");
                }
            }
            else
            {
                Response.Write("Payment ID entered doesn't exist!");
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