using MasterpageTest.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MasterpageTest
{
    public partial class AssessmentAssignation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void StudentList_SelectedIndexChanged(object sender, EventArgs e)
        {
            Person person = (Person)Session["personDetail"];
            int rowindex = StudentList.SelectedRow.RowIndex;
            string id = AssessmentQuestion.SelectedValue;
            string email = (String)StudentList.DataKeys[rowindex].Value;
            string databaseConnectUpdate = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
            SqlConnection conUpdate = new SqlConnection(databaseConnectUpdate);
            conUpdate.Open();
            string CompletionValue = "INCOMPLETE";
            string AssignmentValue = "ASSIGNED";
            string insertQuery = "insert into MCQAssessmentList" + "(Email,MCQAssessmentID,Completion,Assignment) values (@Email,@MCQAssessmentID,@Completion,@Assignment);";
            SqlCommand InsertComm = new SqlCommand(insertQuery, conUpdate);
            InsertComm.Parameters.AddWithValue("@Email", email);
            InsertComm.Parameters.AddWithValue("@MCQAssessmentID", "" + id);
            InsertComm.Parameters.AddWithValue("@Completion", CompletionValue);
            InsertComm.Parameters.AddWithValue("@Assignment", AssignmentValue);
            try
            {
                InsertComm.ExecuteNonQuery();
                conUpdate.Close();
                TypeOfQuestion.SelectedValue = "MCQ";
                AssessmentQuestion.SelectedValue = id;
                StudentList.DataBind();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('You Had Assigned The Assessment To The Student!');", true);
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('The student has been assigned!');", true);
            }
        }

        protected void StudentListQNA_SelectedIndexChanged(object sender, EventArgs e)
        {
            Person person = (Person)Session["personDetail"];
            int rowindex = StudentListQNA.SelectedRow.RowIndex;
            string id = AssessmentQuestionQNA.SelectedValue;
            string email = (String)StudentListQNA.DataKeys[rowindex].Value;
            string databaseConnectUpdate = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
            SqlConnection conUpdate = new SqlConnection(databaseConnectUpdate);
            conUpdate.Open();
            string CompletionValue = "INCOMPLETE";
            string AssignmentValue = "ASSIGNED";
            string insertQuery = "insert into WrittenAssessmentList" + "(Email,WrittenID,Completion,Assignment) values (@Email,@WrittenID,@Completion,@Assignment);";
            SqlCommand InsertComm = new SqlCommand(insertQuery, conUpdate);
            InsertComm.Parameters.AddWithValue("@Email", email);
            InsertComm.Parameters.AddWithValue("@WrittenID", "" + id);
            InsertComm.Parameters.AddWithValue("@Completion", CompletionValue);
            InsertComm.Parameters.AddWithValue("@Assignment", AssignmentValue);
            try
            {
                InsertComm.ExecuteNonQuery();
                conUpdate.Close();
                TypeOfQuestion.SelectedValue = "QNA";
                AssessmentQuestionQNA.SelectedValue = id;
                StudentListQNA.DataBind();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('You Had Assigned The Assessment To The Student!');", true);
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('The student has been assigned!');", true);
            }
        }

        protected void StudentListQuery_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                LabelStudentList.Text = "No student is registered!";
            }
            else
            {
                LabelStudentList.Text = "";
            }
        }

        protected void StudentListQueryQNA_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                LabelStudentListQNA.Text = "No student is registered!";
            }
            else
            {
                LabelStudentListQNA.Text = "";
            }
        }
    }
}