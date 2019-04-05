using MasterpageTest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MasterpageTest
{
    public partial class GradingWrittenTest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Person person = (Person)Session["personDetail"];
            PersonDetail.Value = person.Email;
        }

        protected void StudentCompleted_SelectedIndexChanged(object sender, EventArgs e)
        {
            int rowindex = StudentCompleted.SelectedRow.RowIndex;
            var id = Convert.ToInt32(StudentCompleted.DataKeys[rowindex].Value);
            Response.Redirect("Grading.aspx?WrittenID=" + id);
        }

        protected void StudentMarkedQuery_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
          
            if (e.AffectedRows == 0)
            {
                MarkedResult.Text = "No student is marked!";
            }
            else
            {
                MarkedResult.Text = "";
            }
        }

        protected void StudentCompletedQuery_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                CompletedAssessmentLabel.Text = "No student is completed the assessment!";
            }
            else
            {
                CompletedAssessmentLabel.Text = "";
            }
        }
    }
}