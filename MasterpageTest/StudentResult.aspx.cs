using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MasterpageTest
{
    public partial class StudentResult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TypeRequest.Value = Request.QueryString["Type"].ToString();
        }

        protected void StudentResultQuery_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                LabelStudentResultList.Text = "None student is marked!";
            }
            else
            {
                LabelStudentResultList.Text = "";
            }
        }

        protected void WrittenResultQuery_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                LabelStudentResultQNA.Text = "None student is marked!";
            }
            else
            {
                LabelStudentResultQNA.Text = "";
            }
        }
    }
}