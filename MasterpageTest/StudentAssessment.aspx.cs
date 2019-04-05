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
    public partial class StudentAssessment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Person person = (Person)Session["personDetail"];
            HiddenData.Value = person.Email;
        }

        protected void publicAssessment_SelectedIndexChanged(object sender, EventArgs e)
        {
            Person person = (Person)Session["personDetail"];
            int rowindex = publicAssessment.SelectedRow.RowIndex;
            int id = Convert.ToInt32(publicAssessment.DataKeys[rowindex].Value);

            string databaseConnectUpdate = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
            SqlConnection conUpdate = new SqlConnection(databaseConnectUpdate);
            conUpdate.Open();
            string CompletionValue = "INCOMPLETE";
            string AssignmentValue = "ASSIGNED";
            string insertQuery = "insert into MCQAssessmentList" + "(Email,MCQAssessmentID,Completion,Assignment) values (@Email,@MCQAssessmentID,@Completion,@Assignment);";
            SqlCommand InsertComm = new SqlCommand(insertQuery, conUpdate);       
            InsertComm.Parameters.AddWithValue("@Email", person.Email);
            InsertComm.Parameters.AddWithValue("@MCQAssessmentID", ""+id);
            InsertComm.Parameters.AddWithValue("@Completion", CompletionValue);
            InsertComm.Parameters.AddWithValue("@Assignment", AssignmentValue);
            try
            {
                InsertComm.ExecuteNonQuery();
                conUpdate.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Thank for Registered this Assessment!');window.location ='StudentAssessment.aspx';", true);
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Enter a correct Value!');window.location ='StudentAssessment.aspx';", true);
            }
        }

        protected void publicQNAAssessment_SelectedIndexChanged(object sender, EventArgs e)
        {
            Person person = (Person)Session["personDetail"];
            int rowindex = publicQNAAssessment.SelectedRow.RowIndex;
            int id = Convert.ToInt32(publicQNAAssessment.DataKeys[rowindex].Value);

            string databaseConnectUpdate = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
            SqlConnection conUpdate = new SqlConnection(databaseConnectUpdate);
            conUpdate.Open();
            string CompletionValue = "INCOMPLETE";
            string AssignmentValue = "ASSIGNED";
            string insertQuery = "insert into WrittenAssessmentList" + "(Email,WrittenID,Completion,Assignment) values (@Email,@WrittenID,@Completion,@Assignment);";
            SqlCommand InsertComm = new SqlCommand(insertQuery, conUpdate);
            InsertComm.Parameters.AddWithValue("@Email", person.Email);
            InsertComm.Parameters.AddWithValue("@WrittenID", "" + id);
            InsertComm.Parameters.AddWithValue("@Completion", CompletionValue);
            InsertComm.Parameters.AddWithValue("@Assignment", AssignmentValue);
            try
            {
                InsertComm.ExecuteNonQuery();
                conUpdate.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Thank for Registered this Assessment!');window.location ='StudentAssessment.aspx';", true);
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Enter a correct Value!');window.location ='StudentAssessment.aspx';", true);
            }
        }

        protected void publicAssessmentQuery_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                LabelpublicAssessment.Text = "No Latest Assessment Record Found!";
            }
            else
            {
                LabelpublicAssessment.Text = "";
            }
        }

        protected void publicQNAQuery_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                LabelpublicQNAAssessment.Text = "No Latest Assessment Record Found!";
            }
            else
            {
                LabelpublicQNAAssessment.Text = "";
            }
        }
    }
}