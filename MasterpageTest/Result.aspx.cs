using MasterpageTest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MasterpageTest
{
    public partial class View : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Person person = (Person)Session["personDetail"];
            hiddenResult.Value = person.Email;
            hiddenStatus.Value = person.Status;
        }

        protected void MCQAssessmentResult_SelectedIndexChanged(object sender, EventArgs e)
        {
            int rowindex = MCQAssessmentResult.SelectedRow.RowIndex;
            var id = Convert.ToInt32(MCQAssessmentResult.DataKeys[rowindex].Value);
            string type = "MCQ";
            Response.Redirect("StudentResult.aspx?MCQAssessmentID=" + id + "&Type="+type);
        }

        protected void QNAAssessmentResult_SelectedIndexChanged(object sender, EventArgs e)
        {
            int rowindex = QNAAssessmentResult.SelectedRow.RowIndex;
            var id = Convert.ToInt32(QNAAssessmentResult.DataKeys[rowindex].Value);
            string type = "QNA";
            Response.Redirect("StudentResult.aspx?WrittenID=" + id + "&Type=" + type);
        }

        protected void StudentResultQuery_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                LabelStudentResult.Text = "You has not completed any assessment!";
            }
            else
            {
                LabelStudentResult.Text = "";
            }
        }

        protected void StudentResultQNAQuery_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                LabelStudentResultQNA.Text = "You has not completed any assessment!";
            }
            else
            {
                LabelStudentResultQNA.Text = "";
            }
        }
    }
}