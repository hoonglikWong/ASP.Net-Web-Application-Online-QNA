using MasterpageTest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MasterpageTest
{
    public partial class ManageAssessment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Person person = (Person)Session["personDetail"];
            HiddenData.Value = person.Email;
        }

        protected void AssessmentRecordQNA_SelectedIndexChanged(object sender, EventArgs e)
        {
            int rowindex = AssessmentRecordQNA.SelectedRow.RowIndex;
            var id = Convert.ToInt32(AssessmentRecordQNA.DataKeys[rowindex].Value);
            Response.Redirect("ManageQuestion.aspx?WrittenID=" + id + "&TypeOfQuestion=" + TypeOfQuestion.Text);
        }

        protected void AssessmentRecord_SelectedIndexChanged(object sender, EventArgs e)
        {
           int rowindex = AssessmentRecord.SelectedRow.RowIndex;
            var id = Convert.ToInt32(AssessmentRecord.DataKeys[rowindex].Value);
            Response.Redirect("ManageQuestion.aspx?MCQAssessmentID=" + id + "&TypeOfQuestion=" + TypeOfQuestion.Text);
        }

        protected void SearchAssessmentQNA_SelectedIndexChanged(object sender, EventArgs e)
        {
            Response.Redirect("ManageQuestion.aspx?WrittenID=" + SearchAssessmentQNA.SelectedValue + "&TypeOfQuestion=" + TypeOfQuestion.Text);
        }

        protected void SearchAssessment_SelectedIndexChanged(object sender, EventArgs e)
        {
            Response.Redirect("ManageQuestion.aspx?MCQAssessmentID=" + SearchAssessment.SelectedValue + "&TypeOfQuestion=" + TypeOfQuestion.Text);
        }

        protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                LabelAssessmentRecordQNA.Text = "Currently no assessment record!";
            }
            else
            {
                LabelAssessmentRecordQNA.Text = "";
            }
        }

        protected void SqlDataSource2_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                LabelAssessmentRecord.Text = "Currently no assessment record!";
            }
            else
            {
                LabelAssessmentRecord.Text = "";
            }
        }
    }
}