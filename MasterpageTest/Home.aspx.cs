using MasterpageTest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MasterpageTest
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Person person = (Person)Session["personDetail"];
            personName.Text = person.Name;
            HiddenData.Value = person.Email;
            HiddenStatus.Value = person.Status;
        }
        protected void AssignedMCQ_SelectedIndexChanged(object sender, EventArgs e)
        {
            string MCQString = "MCQ";
            int rowindex = AssignedMCQ.SelectedRow.RowIndex;
            var id = Convert.ToInt32(AssignedMCQ.DataKeys[rowindex].Value);
            Response.Redirect("StudentAssessmentQuestion.aspx?MCQAssessmentID=" + id + "&TypeOfQuestion=" + MCQString);
        }

        protected void AssignedMCQQNA_SelectedIndexChanged(object sender, EventArgs e)
        {
            string QNAString = "QNA";
            int rowindex = AssignedMCQQNA.SelectedRow.RowIndex;
            var id = Convert.ToInt32(AssignedMCQQNA.DataKeys[rowindex].Value);
            Response.Redirect("StudentAssessmentQuestion.aspx?WrittenID=" + id + "&TypeOfQuestion=" + QNAString);
        }

        protected void AssignedMCQQuery_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                LabelAssignedMCQ.Text = "Currently not assigned by any assessment!";
            }
            else
            {
                LabelAssignedMCQ.Text = "";
            }
        }

        protected void AssignedQNAQuery_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                LabelAssignedQNA.Text = "Currently not assigned by any assessment!";
            }
            else
            {
                LabelAssignedQNA.Text = "";
            }
        }

        protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                CompletedMCQLabel.Text = "Currently not completed any assessment!";
            }
            else
            {
                CompletedMCQLabel.Text = "";
            }
        }

        protected void SqlDataSource2_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                CompletedQNALabel.Text = "Currently not completed any assessment!";
            }
            else
            {
                CompletedQNALabel.Text = "";
            }
        }
    }
}