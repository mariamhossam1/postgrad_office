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
    public partial class DefGrade : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void gradeup(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            int thesisno = Int16.Parse(thsn.Text);

            SqlCommand thexists = new SqlCommand("ThesisExists", conn);
            thexists.CommandType = CommandType.StoredProcedure;
            thexists.Parameters.Add(new SqlParameter("@ThesisSerialNo", thesisno));

            SqlParameter success = thexists.Parameters.Add("@Success", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;

            conn.Open();
            thexists.ExecuteNonQuery();

            if (success.Value.ToString() == "1")
            {
                DateTime defense = DateTime.Parse(dfd.Text);
                int grd = Int16.Parse(grade.Text);
                String comm = cm.Text;

                SqlCommand defcomm = new SqlCommand("AddCommentsGrade", conn);
                SqlCommand defgrd = new SqlCommand("AddDefenseGrade", conn);
                defgrd.CommandType = CommandType.StoredProcedure;
                defcomm.CommandType = CommandType.StoredProcedure;

                defgrd.Parameters.Add(new SqlParameter("@ThesisSerialNo", thesisno));
                defgrd.Parameters.Add(new SqlParameter("@DefenseDate", defense));
                defgrd.Parameters.Add(new SqlParameter("@grade", grd));
                defcomm.Parameters.Add(new SqlParameter("@ThesisSerialNo", thesisno));
                defcomm.Parameters.Add(new SqlParameter("@DefenseDate", defense));
                defcomm.Parameters.Add(new SqlParameter("@comments", comm));

                if(grd != -1 && comm.Length!=0)
                {
                    defgrd.ExecuteNonQuery();
                    defcomm.ExecuteNonQuery();
                    Response.Write("Updated Successfully!");
                }
                else if(grd == -1 && comm.Length!=0)
                {
                    defcomm.ExecuteNonQuery();
                    Response.Write("Updated Successfully!");
                }
                else
                {
                    defgrd.ExecuteNonQuery();
                    Response.Write("Updated Successfully!");
                }
            }
            else
            {
                Response.Write("Thesis Serial Number entered does not exist!");
            }
            conn.Close();
        }

        protected void backhome(object sender, EventArgs e)
        {
            Response.Redirect("ExaminerView.aspx");
        }
    }
}