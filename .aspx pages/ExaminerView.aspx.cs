using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ByteMe
{
    public partial class ExaminerView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void editprof(object sender, EventArgs e)
        {
            Response.Redirect("EditExaminer.aspx");
        }

        protected void defview(object sender, EventArgs e)
        {
            Response.Redirect("DefAttend.aspx");
        }

        protected void addgrade(object sender, EventArgs e)
        {
            Response.Redirect("DefGrade.aspx");
        }

        protected void srchth(object sender, EventArgs e)
        {
            Response.Redirect("SearchThesis.aspx");
        }

        protected void backlog(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}