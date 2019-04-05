using MasterpageTest.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MasterpageTest
{
    public partial class Grading : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HiddenData.Value = Request.QueryString["WrittenID"].ToString();
            string parameterID = HiddenData.Value;
            if (!this.IsPostBack)
            {
                this.Populate(parameterID);
            }
        }
        private void Populate(string parameterID)
        {
            string constr = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString;
            using (SqlConnection _cn = new SqlConnection(constr))
            {

                using (SqlCommand _cmd = new SqlCommand("SELECT * FROM WrittenQuestion WQ, WrittenResponse WR WHERE WQ.WrittenQuestionID =  WR.WrittenQuestionID AND WrittenID=" + parameterID, _cn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(_cmd))
                    {
                        _cn.Open();
                        DataSet ds = new DataSet();
                        da.Fill(ds);
                        DataListWritten.DataSource = ds;
                        DataListWritten.DataBind();
                        _cn.Close();
                    }
                }

            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Person person = (Person)Session["personDetail"];
            int countTotal = 0;
            int countCorrect = 0;
            string responseEmailString="";

            for (int i = 0; i < this.DataListWritten.Items.Count; i++)
            {
                HiddenField questionField = (HiddenField)this.DataListWritten.Items[i].FindControl("QuestionID");
                HiddenField responseEmail = (HiddenField)this.DataListWritten.Items[i].FindControl("ResponseEmail");
                TextBox textValue = (TextBox)this.DataListWritten.Items[i].FindControl("UserAnswer");
                HiddenField labelValue = (HiddenField)this.DataListWritten.Items[i].FindControl("MarkHidden");
                TextBox markValue = (TextBox)this.DataListWritten.Items[i].FindControl("WrittenMark");
                string questionID = questionField.Value;
                string userAnswer = textValue.Text;
                responseEmailString = responseEmail.Value;
                int questionMaxMark = int.Parse(labelValue.Value);
                int questionRealMark = int.Parse(markValue.Text);

                countTotal = countTotal + questionMaxMark;
                countCorrect = countCorrect + questionRealMark;

                string databaseConnect = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
                SqlConnection con = new SqlConnection(databaseConnect);
                con.Open();
                string updateQNA = "UPDATE WrittenResponse SET Mark = @Mark WHERE WrittenQuestionID = @WrittenQuestionID AND Email = @Email";
                SqlCommand updateQNAquery = new SqlCommand(updateQNA, con);
                updateQNAquery.Parameters.AddWithValue("@Mark", questionRealMark);
                updateQNAquery.Parameters.AddWithValue("@WrittenQuestionID", questionID);
                updateQNAquery.Parameters.AddWithValue("@Email", responseEmailString);
                
                try
                {
                    updateQNAquery.ExecuteNonQuery();
                    con.Close();
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Enter a correct Value!');window.location ='GradingWrittenTest.aspx';", true);
                }
            }

            double TotalResult = (((double)countCorrect / (double)countTotal) * (double)100);


            string databaseConnectResult = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
            SqlConnection conResult = new SqlConnection(databaseConnectResult);
            conResult.Open();
            string insertMCQResult = "insert into WrittenResult" + "(WrittenID,Email,Result) values (@WrittenID,@Email,@Result);";
            SqlCommand insertCommResult = new SqlCommand(insertMCQResult, conResult);
            insertCommResult.Parameters.AddWithValue("@WrittenID", HiddenData.Value);
            insertCommResult.Parameters.AddWithValue("@Email", responseEmailString);
            insertCommResult.Parameters.AddWithValue("@Result", "" + TotalResult);
            try
            {
                insertCommResult.ExecuteNonQuery();
                conResult.Close();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Enter a correct Value!');window.location ='GradingWrittenTest.aspx';", true);
            }

            string databaseConnectUpdate = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
            SqlConnection conUpdate = new SqlConnection(databaseConnectUpdate);
            conUpdate.Open();
            string CompletedValue = "MARKED";
            string updateQuery = "UPDATE [WrittenAssessmentList] SET [Completion] = @Completion WHERE [WrittenID] = @WrittenID AND [Email] = @Email";
            SqlCommand UpdateCommResult = new SqlCommand(updateQuery, conUpdate);
            UpdateCommResult.Parameters.AddWithValue("@Completion", CompletedValue);
            UpdateCommResult.Parameters.AddWithValue("@WrittenID", HiddenData.Value);
            UpdateCommResult.Parameters.AddWithValue("@Email", responseEmailString);
            try
            {
                UpdateCommResult.ExecuteNonQuery();
                conUpdate.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Completed Marked!');window.location ='GradingWrittenTest.aspx';", true);
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Enter a correct Value!');window.location ='GradingWrittenTest.aspx';", true);
            }
        }
    }
}