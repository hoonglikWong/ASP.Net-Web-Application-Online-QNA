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
    public partial class StudentAssessmentQuestion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HiddenTypeOfQuestion.Value = Request.QueryString["TypeOfQuestion"].ToString();
            if (HiddenTypeOfQuestion.Value == "QNA")
            {
                HiddenData.Value = Request.QueryString["WrittenID"].ToString();
                string typeofQuestion = HiddenTypeOfQuestion.Value;
                string parameterID = HiddenData.Value;
                if (!this.IsPostBack)
                {
                    this.Populate(parameterID, typeofQuestion);
                }

            }
            else if (HiddenTypeOfQuestion.Value == "MCQ")
            {
                HiddenData.Value = Request.QueryString["MCQAssessmentID"].ToString();
                string typeofQuestion = HiddenTypeOfQuestion.Value;
                string parameterID = HiddenData.Value;
                if (!this.IsPostBack)
                {
                    this.Populate(parameterID, typeofQuestion);
                }
            }
            else
            {
            }


        }
        private void Populate(string parameterID, string typeofQuestion)
        {
            string constr = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString;
            using (SqlConnection _cn = new SqlConnection(constr))
            {
                if (typeofQuestion == "MCQ")
                {
                    using (SqlCommand _cmd = new SqlCommand("SELECT * FROM MCQQuestion WHERE MCQAssessmentID=" + parameterID, _cn))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(_cmd))
                        {
                            _cn.Open();
                            DataSet ds = new DataSet();
                            da.Fill(ds);
                            DataListQuestion.DataSource = ds;
                            DataListQuestion.DataBind();
                            _cn.Close();
                        }
                    }
                }
                else if (typeofQuestion == "QNA")
                {
                    using (SqlCommand _cmd = new SqlCommand("SELECT * FROM WrittenQuestion WHERE WrittenID=" + parameterID, _cn))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(_cmd))
                        {
                            _cn.Open();
                            DataSet ds = new DataSet();
                            da.Fill(ds);
                            QNADataList.DataSource = ds;
                            QNADataList.DataBind();
                            _cn.Close();
                        }
                    }
                }
                else
                {

                }

            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlDataReader reader;
            string TOQ = HiddenTypeOfQuestion.Value;
            Person person = (Person)Session["personDetail"];

            if (TOQ == "MCQ")
            {
                int countCorrect = 0;
                for (int i = 0; i < this.DataListQuestion.Items.Count; i++)
                {
                    string userAnswer = "";
                    HiddenField questionField = (HiddenField)this.DataListQuestion.Items[i].FindControl("QuestionID");
                    RadioButton rb1 = (RadioButton)this.DataListQuestion.Items[i].FindControl("rblOptionOne");
                    RadioButton rb2 = (RadioButton)this.DataListQuestion.Items[i].FindControl("rblOptionTwo");
                    RadioButton rb3 = (RadioButton)this.DataListQuestion.Items[i].FindControl("rblOptionThree");
                    RadioButton rb4 = (RadioButton)this.DataListQuestion.Items[i].FindControl("rblOptionFour");
                    string questionID = questionField.Value;


                    string databaseAnswerConnect = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
                    SqlConnection conAnswer = new SqlConnection(databaseAnswerConnect);
                    conAnswer.Open();
                    string answerQuery = "select Answer from MCQQuestion where MCQQuestionID='" + questionID + "'";
                    SqlCommand answerCommand = new SqlCommand(answerQuery, conAnswer);
                    reader = answerCommand.ExecuteReader();
                    string answerOfquestion = "";

                    while (reader.Read())
                    {
                        int ordinal = reader.GetOrdinal("Answer");
                        if (!reader.IsDBNull(ordinal))
                        {
                            answerOfquestion = reader.GetString(ordinal);
                        }
                    }
                    conAnswer.Close();
                    if (rb1.Checked == true)
                    {
                        userAnswer = "A";
                    }
                    if (rb2.Checked == true)
                    {
                        userAnswer = "B";
                    }
                    if (rb3.Checked == true)
                    {
                        userAnswer = "C";
                    }
                    if (rb4.Checked == true)
                    {
                        userAnswer = "D";
                    }
                    if (userAnswer == answerOfquestion)
                    {
                        countCorrect++;
                    }
                    string databaseConnect = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
                    SqlConnection con = new SqlConnection(databaseConnect);
                    con.Open();
                    string insertMCQ = "insert into MCQResponse" + "(MCQQuestionID,Email,AnswerResponse) values (@MCQQuestionID,@Email,@AnswerResponse);";
                    SqlCommand insertComm = new SqlCommand(insertMCQ, con);
                    insertComm.Parameters.AddWithValue("@MCQQuestionID", questionID);
                    insertComm.Parameters.AddWithValue("@Email", person.Email);
                    insertComm.Parameters.AddWithValue("@AnswerResponse", userAnswer);
                    try
                    {
                        insertComm.ExecuteNonQuery();
                        con.Close();
                    }
                    catch (System.Data.SqlClient.SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Enter a correct Value!');window.location ='StudentAssessment.aspx';", true);
                    }         
                }

                double result = (((double)countCorrect / (double)DataListQuestion.Items.Count) * (double)100);

                string databaseConnectResult = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
                SqlConnection conResult = new SqlConnection(databaseConnectResult);
                conResult.Open();
                string insertMCQResult = "insert into MCQResult" + "(MCQAssessmentID,Email,Result) values (@MCQAssessmentID,@Email,@Result);";
                SqlCommand insertCommResult = new SqlCommand(insertMCQResult, conResult);
                insertCommResult.Parameters.AddWithValue("@MCQAssessmentID", HiddenData.Value);
                insertCommResult.Parameters.AddWithValue("@Email", person.Email);
                insertCommResult.Parameters.AddWithValue("@Result", ""+result);
                try
                {
                    insertCommResult.ExecuteNonQuery();
                    conResult.Close();
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Enter a correct Value!');window.location ='Home.aspx';", true);
                }

                string databaseConnectUpdate = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
                SqlConnection conUpdate = new SqlConnection(databaseConnectUpdate);
                conUpdate.Open();
                string MarkedValue = "MARKED";
                string updateQuery = "UPDATE [MCQAssessmentList] SET [Completion] = @Completion WHERE [MCQAssessmentID] = @MCQAssessmentID AND [Email] = @Email";
                SqlCommand UpdateCommResult = new SqlCommand(updateQuery, conUpdate);
                UpdateCommResult.Parameters.AddWithValue("@Completion", MarkedValue);
                UpdateCommResult.Parameters.AddWithValue("@MCQAssessmentID", HiddenData.Value);
                UpdateCommResult.Parameters.AddWithValue("@Email", person.Email);
                try
                {
                    UpdateCommResult.ExecuteNonQuery();
                    conUpdate.Close();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Congratulation you has been completed this Assessment');window.location ='Home.aspx';", true);
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Enter a correct Value!');window.location ='Home.aspx';", true);
                }

            }
            else if(TOQ == "QNA")
            {
                for (int i = 0; i < this.QNADataList.Items.Count; i++)
                {
                    string userAnswer = "";
                    HiddenField questionField = (HiddenField)this.QNADataList.Items[i].FindControl("QuestionID");
                    TextBox textValue = (TextBox)this.QNADataList.Items[i].FindControl("UserAnswer");
                    string questionID = questionField.Value;
                    userAnswer = textValue.Text;

                    string databaseConnect = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
                    SqlConnection con = new SqlConnection(databaseConnect);
                    con.Open();
                    string insertQNA = "insert into WrittenResponse" + "(WrittenQuestionID,Email,AnswerResponse,Mark) values (@WrittenQuestionID,@Email,@AnswerResponse,@Mark);";
                    SqlCommand insertQNAquery = new SqlCommand(insertQNA, con);
                    insertQNAquery.Parameters.AddWithValue("@WrittenQuestionID", questionID);
                    insertQNAquery.Parameters.AddWithValue("@Email", person.Email);
                    insertQNAquery.Parameters.AddWithValue("@AnswerResponse", userAnswer);
                    insertQNAquery.Parameters.AddWithValue("@Mark", "");
                    try
                    {
                        insertQNAquery.ExecuteNonQuery();
                        con.Close();
                    }
                    catch (System.Data.SqlClient.SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Enter a correct Value!');window.location ='Home.aspx';", true);
                    }
                }

                string databaseConnectUpdate = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
                SqlConnection conUpdate = new SqlConnection(databaseConnectUpdate);
                conUpdate.Open();
                string CompletedValue = "COMPLETED";
                string updateQuery = "UPDATE [WrittenAssessmentList] SET [Completion] = @Completion WHERE [WrittenID] = @WrittenID AND [Email] = @Email";
                SqlCommand UpdateCommResult = new SqlCommand(updateQuery, conUpdate);
                UpdateCommResult.Parameters.AddWithValue("@Completion", CompletedValue);
                UpdateCommResult.Parameters.AddWithValue("@WrittenID", HiddenData.Value);
                UpdateCommResult.Parameters.AddWithValue("@Email", person.Email);
                try
                {
                    UpdateCommResult.ExecuteNonQuery();
                    conUpdate.Close();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Congratulation you has been completed this Assessment');window.location ='Home.aspx';", true);
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Enter a correct Value!');window.location ='Home.aspx';", true);
                }
            }    
        }

    }
}