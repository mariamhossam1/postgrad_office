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
    public partial class Supervisor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ViewStudents(object sender, EventArgs e)
        {

            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);


            int supervisorID = (int)Session["user"];

            SqlCommand existsSupervisorProc = new SqlCommand("existsSupervisor", conn);
            existsSupervisorProc.CommandType = CommandType.StoredProcedure;
            existsSupervisorProc.Parameters.Add(new SqlParameter("@supervisorID", supervisorID));
            SqlParameter exists = existsSupervisorProc.Parameters.Add("@exist", SqlDbType.Bit); //for output
            exists.Direction = ParameterDirection.Output;

            conn.Open();
            existsSupervisorProc.ExecuteNonQuery();
            conn.Close();
            if (exists.Value.ToString() == "True")
            {
                SqlCommand viewStudentProc = new SqlCommand("ViewSupStudentsYears", conn);
                viewStudentProc.CommandType = CommandType.StoredProcedure;
                viewStudentProc.Parameters.Add(new SqlParameter("@supervisorID", supervisorID));

                conn.Open();
                GridView2.DataSource = viewStudentProc.ExecuteReader();
                GridView2.DataBind();
                conn.Close();
            }
            else
                Response.Write("This supervisor ID doesnt exists!");

        }

        protected void ViewStudentsPub(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            int studentID = Int16.Parse(studID.Text);

            SqlCommand existsStudentProc = new SqlCommand("existsStudent", conn);
            existsStudentProc.CommandType = CommandType.StoredProcedure;
            existsStudentProc.Parameters.Add(new SqlParameter("@studentID", studentID));
            SqlParameter exists = existsStudentProc.Parameters.Add("@exist", SqlDbType.Bit); //for output
            exists.Direction = ParameterDirection.Output;

            conn.Open();
            existsStudentProc.ExecuteNonQuery();
            conn.Close();

            if (exists.Value.ToString() == "True")
            {
                SqlCommand viewStudentPubProc = new SqlCommand("ViewAStudentPublications", conn);
                viewStudentPubProc.CommandType = CommandType.StoredProcedure;
                viewStudentPubProc.Parameters.Add(new SqlParameter("@StudentID", studentID));

                conn.Open();
                GridView1.DataSource = viewStudentPubProc.ExecuteReader();
                GridView1.DataBind();
                conn.Close();
            }
            else
                Response.Write("This student ID doesnt exists!");
        }

        protected void CancelThesis(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            int thesisIDNo = Int16.Parse(ThesisID.Text);

            SqlCommand existsThesisProc = new SqlCommand("existsThesis", conn);
            existsThesisProc.CommandType = CommandType.StoredProcedure;
            existsThesisProc.Parameters.Add(new SqlParameter("@thesisSerialNo", thesisIDNo));
            SqlParameter exists = existsThesisProc.Parameters.Add("@exist", SqlDbType.Bit); //for output
            exists.Direction = ParameterDirection.Output;

            conn.Open();
            existsThesisProc.ExecuteNonQuery();
            conn.Close();

            if (exists.Value.ToString() == "True")
            {

                SqlCommand CancelThesisProc = new SqlCommand("CancelThesis", conn);
                CancelThesisProc.CommandType = CommandType.StoredProcedure;
                CancelThesisProc.Parameters.Add(new SqlParameter("@ThesisSerialNo", thesisIDNo));

                conn.Open();
                CancelThesisProc.ExecuteNonQuery();
                conn.Close();
            }
            else
                Response.Write("This Thesis doesnt exists!");
        }



        protected void Evaluate(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            int thesisIDNo = Int16.Parse(ThesisID.Text);
            int progressReportNo = Int16.Parse(progressReport.Text);
            int supervisorID = (int)Session["user"];

            SqlCommand existsSupervisorProc = new SqlCommand("existsSupervisor", conn);
            existsSupervisorProc.CommandType = CommandType.StoredProcedure;
            existsSupervisorProc.Parameters.Add(new SqlParameter("@supervisorID", supervisorID));
            SqlParameter exists = existsSupervisorProc.Parameters.Add("@exist", SqlDbType.Bit); //for output
            exists.Direction = ParameterDirection.Output;

            conn.Open();
            existsSupervisorProc.ExecuteNonQuery();
            conn.Close();

            if (exists.Value.ToString() == "True")
            {
                SqlCommand existsprogressreportProc = new SqlCommand("existsprogressreport", conn);
                existsprogressreportProc.CommandType = CommandType.StoredProcedure;
                existsprogressreportProc.Parameters.Add(new SqlParameter("@thesisSerialNo", thesisIDNo));
                existsprogressreportProc.Parameters.Add(new SqlParameter("@number", progressReportNo));
                SqlParameter exists2 = existsprogressreportProc.Parameters.Add("@exist", SqlDbType.Bit); //for output
                exists2.Direction = ParameterDirection.Output;

                conn.Open();
                existsprogressreportProc.ExecuteNonQuery();
                conn.Close();

                if (exists2.Value.ToString() == "True")
                {
                    int evaluateV = Int16.Parse(evaluateValue.Text);
                    if (evaluateV < 4)
                    {
                        SqlCommand EvaluateProgressReportProc = new SqlCommand("EvaluateProgressReport", conn);
                        EvaluateProgressReportProc.CommandType = CommandType.StoredProcedure;
                        EvaluateProgressReportProc.Parameters.Add(new SqlParameter("@supervisorID", supervisorID));
                        EvaluateProgressReportProc.Parameters.Add(new SqlParameter("@ThesisSerialNo", thesisIDNo));
                        EvaluateProgressReportProc.Parameters.Add(new SqlParameter("@progressReportNo", progressReportNo));
                        EvaluateProgressReportProc.Parameters.Add(new SqlParameter("@evaluation", evaluateV));

                        conn.Open();
                        EvaluateProgressReportProc.ExecuteNonQuery();
                        conn.Close();
                    }
                    else

                        Response.Write("Evaluation grade should be from 0 to 3!");



                }
                else
                    Response.Write("This Progress Report doesnt exists!");
            }
            else
                Response.Write("This Supervisor ID doesnt exists!");
        }

        protected void AddDefense(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            int studentID = Int16.Parse(studID.Text);
            SqlCommand GucianProc = new SqlCommand("whichStudent", conn);
            GucianProc.CommandType = CommandType.StoredProcedure;
            GucianProc.Parameters.Add(new SqlParameter("@studentID", studentID));
            SqlParameter gucian = GucianProc.Parameters.Add("@guc", SqlDbType.Bit); //for output
            gucian.Direction = ParameterDirection.Output;

            conn.Open();
            GucianProc.ExecuteNonQuery();
            conn.Close();

            int thesisIDNo = Int16.Parse(ThesisID.Text);

            SqlCommand existsThesisProc = new SqlCommand("existsThesis", conn);
            existsThesisProc.CommandType = CommandType.StoredProcedure;
            existsThesisProc.Parameters.Add(new SqlParameter("@thesisSerialNo", thesisIDNo));
            SqlParameter exists = existsThesisProc.Parameters.Add("@exist", SqlDbType.Bit); //for output
            exists.Direction = ParameterDirection.Output;

            conn.Open();
            existsThesisProc.ExecuteNonQuery();
            conn.Close();

            if (exists.Value.ToString() == "True")
            {
                if (gucian.Value.ToString() == "True")
                {

                    DateTime Date = DateTime.Parse(DefenseDate.Text);
                    String location = DefenseLocation.Text;

                    SqlCommand AddGDefenseProc = new SqlCommand("AddDefenseGucian", conn);
                    AddGDefenseProc.CommandType = CommandType.StoredProcedure;
                    AddGDefenseProc.Parameters.Add(new SqlParameter("@ThesisSerialNo", thesisIDNo));
                    AddGDefenseProc.Parameters.Add(new SqlParameter("@DefenseDate", Date));
                    AddGDefenseProc.Parameters.Add(new SqlParameter("@DefenseLocation", location));

                    conn.Open();
                    AddGDefenseProc.ExecuteNonQuery();
                    conn.Close();
                }
                else
                {
                    DateTime Date = DateTime.Parse(DefenseDate.Text);
                    String location = DefenseLocation.Text;

                    SqlCommand AddNGDefenseProc = new SqlCommand("AddDefenseNonGucian", conn);
                    AddNGDefenseProc.CommandType = CommandType.StoredProcedure;
                    AddNGDefenseProc.Parameters.Add(new SqlParameter("@ThesisSerialNo", thesisIDNo));
                    AddNGDefenseProc.Parameters.Add(new SqlParameter("@DefenseDate", Date));
                    AddNGDefenseProc.Parameters.Add(new SqlParameter("@DefenseLocation", location));

                    conn.Open();
                    AddNGDefenseProc.ExecuteNonQuery();
                    conn.Close();
                }
            }
            else
                Response.Write("This Thesis doesnt exists!");

        }

        protected void AddExaminer(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Sara"].ToString();
            //create new connection
            SqlConnection conn = new SqlConnection(connStr);

            int thesisIDNo = Int16.Parse(ThesisID.Text);

            SqlCommand existsDefenseProc = new SqlCommand("existsdefense", conn);
            existsDefenseProc.CommandType = CommandType.StoredProcedure;
            existsDefenseProc.Parameters.Add(new SqlParameter("@thesisSerialNo", thesisIDNo));
            SqlParameter exists = existsDefenseProc.Parameters.Add("@exist", SqlDbType.Bit); //for output
            exists.Direction = ParameterDirection.Output;

            conn.Open();
            existsDefenseProc.ExecuteNonQuery();
            conn.Close();

            if (exists.Value.ToString() == "True")
            {

                DateTime Date = DateTime.Parse(DefenseDate.Text);
                String ExaminerN = ExaminerName.Text;
                Boolean NationalP = isNational.Checked;
                String WorkField = FieldOfWork.Text;


                SqlCommand AddExaminerProc = new SqlCommand("AddExaminer", conn);
                AddExaminerProc.CommandType = CommandType.StoredProcedure;
                AddExaminerProc.Parameters.Add(new SqlParameter("@ThesisSerialNo", thesisIDNo)); //1
                AddExaminerProc.Parameters.Add(new SqlParameter("@DefenseDate", Date)); //03/15/2021
                AddExaminerProc.Parameters.Add(new SqlParameter("@ExaminerName", ExaminerN)); //rami malek
                AddExaminerProc.Parameters.Add(new SqlParameter("@National", NationalP)); //0
                AddExaminerProc.Parameters.Add(new SqlParameter("@fieldOfWork", WorkField));  //engineering

                conn.Open();
                AddExaminerProc.ExecuteNonQuery();
                conn.Close();
            }
            else
                Response.Write("This defense doesnt exists!");
        }

        protected void backlog(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}