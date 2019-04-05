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
    public partial class Assessment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataReader reader;
            Person person = (Person)Session["personDetail"];
            hiddenData.Value = person.Email;
            if(TypeOfQuestion.SelectedValue == "MCQ")
            {
                if (Selection.SelectedValue == "ExistingAssessment")
                {
                    string databaseConnect = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
                    SqlConnection con = new SqlConnection(databaseConnect);
                    con.Open();
                    string TypeOAQ = "select MCQAssessmentType from MCQAssessment where MCQAssessmentID='" + ChooseAssessment.SelectedValue + "'";
                    SqlCommand allComm = new SqlCommand(TypeOAQ, con);  
                    reader = allComm.ExecuteReader();
                    while (reader.Read())
                    {
                        int ordinal = reader.GetOrdinal("MCQAssessmentType");
                        if (!reader.IsDBNull(ordinal))
                        {
                            TypeOfAssessmentQuestion.Text = reader.GetString(ordinal);
                            TypeOfAssessmentQuestion.Enabled = false;
                        }
                    }
                    con.Close();
                }
                else
                {
                    TypeOfAssessmentQuestion.Enabled = true;
                }
            }else if(TypeOfQuestion.SelectedValue == "QNA")
            {
                if (Selection.SelectedValue == "ExistingAssessment")
                {
                    string databaseConnect = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
                    SqlConnection con = new SqlConnection(databaseConnect);
                    con.Open();
                    string TypeOAQ = "select WrittenAssessmentType from WrittenAssessment where WrittenID='" + ChooseAssessment2.SelectedValue + "'";
                    SqlCommand allComm = new SqlCommand(TypeOAQ, con);
                    reader = allComm.ExecuteReader();
                    while (reader.Read())
                    {
                        int ordinal = reader.GetOrdinal("WrittenAssessmentType");
                        if (!reader.IsDBNull(ordinal))
                        {
                            TypeOfAssessmentQuestion.Text = reader.GetString(ordinal);
                            TypeOfAssessmentQuestion.Enabled = false;
                        }
                    }
                    con.Close();
                }
                else
                {
                    TypeOfAssessmentQuestion.Enabled = true;
                }

            }
            
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            string databaseConnect = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
            SqlConnection con = new SqlConnection(databaseConnect);
            con.Open();
            string ATitle = assessmentTitle.Text;
            string TAQ = TypeOfAssessmentQuestion.SelectedValue;
            string TOQ = TypeOfQuestion.SelectedValue;
            Person person = (Person)Session["personDetail"];

            if (TOQ == "MCQ")
            {
                string QuestionTitle = MCQTitle.Text;
                string A = OptionA.Text;
                string B = OptionB.Text;
                string C = OptionC.Text;
                string D = OptionD.Text;
                string Answer = OptionValue.Value;

                string insertMCQ = "insert into MCQAssessment" + "(MCQTitle,MCQLecturerEmail,MCQAssessmentType) values (@MCQTitle,@MCQLecturerEmail,@MCQAssessmentType);"+ "Select Scope_Identity();";
                SqlCommand insertComm = new SqlCommand(insertMCQ, con);
                insertComm.Parameters.AddWithValue("@MCQTitle", ATitle);
                insertComm.Parameters.AddWithValue("@MCQLecturerEmail",person.Email);
                insertComm.Parameters.AddWithValue("@MCQAssessmentType", TAQ);
                int addedAssessmentID= 0;
                try
                {
                    addedAssessmentID = Convert.ToInt32(insertComm.ExecuteScalar());
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Enter a correct Value!');window.location ='Assessment.aspx';", true);
                }

                string insertMCQQuestion = "insert into MCQQuestion" + "(QuestionTitle,ChoiceA,ChoiceB,ChoiceC,ChoiceD,Answer,MCQAssessmentID) values (@QuestionTitle,@ChoiceA,@ChoiceB,@ChoiceC,@ChoiceD,@Answer,@MCQAssessmentID)";
                SqlCommand insertIntoMCQ = new SqlCommand(insertMCQQuestion, con);
                insertIntoMCQ.Parameters.AddWithValue("@QuestionTitle", QuestionTitle);
                insertIntoMCQ.Parameters.AddWithValue("@ChoiceA", A);
                insertIntoMCQ.Parameters.AddWithValue("@ChoiceB", B);
                insertIntoMCQ.Parameters.AddWithValue("@ChoiceC", C);
                insertIntoMCQ.Parameters.AddWithValue("@ChoiceD", D);
                insertIntoMCQ.Parameters.AddWithValue("@Answer", Answer);
                insertIntoMCQ.Parameters.AddWithValue("@MCQAssessmentID", addedAssessmentID);
                try
                {
                    insertIntoMCQ.ExecuteNonQuery();
                    MCQTitle.Text = "";
                    OptionA.Text = "";
                    OptionB.Text = "";
                    OptionC.Text = "";
                    OptionD.Text = "";
                    OptionAnswer1.Checked = false;
                    OptionAnswer2.Checked = false;
                    OptionAnswer3.Checked = false;
                    OptionAnswer4.Checked = false;
                    Selection.SelectedValue = "ExistingAssessment";
                    TypeOfQuestion.SelectedValue = "MCQ";
                    
                    con.Close();
                    ChooseAssessment.DataBind();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Successfull Added a New Question');", true);
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Problem Occur!');window.location ='Assessment.aspx';", true);
                }
            }
            else if(TOQ == "QNA")
            {
                string QNAQuestionTitle = QNATitle.Text;
                int Score = int.Parse(Mark.Text);

                string insertQNA = "insert into WrittenAssessment" + "(WrittenTitle,WrittenLectureEmail,WrittenAssessmentType) values (@WrittenTitle,@WrittenLectureEmail,@WrittenAssessmentType);SELECT SCOPE_IDENTITY();";
                SqlCommand writtenValue = new SqlCommand(insertQNA, con);
                writtenValue.Parameters.AddWithValue("@WrittenTitle", ATitle);
                writtenValue.Parameters.AddWithValue("@WrittenLectureEmail", person.Email);
                writtenValue.Parameters.AddWithValue("@WrittenAssessmentType", TAQ);
                int addedQNAAssessmentID = 0;
                try
                {
                    addedQNAAssessmentID = Convert.ToInt32(writtenValue.ExecuteScalar());
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please Enter a correct Value!');window.location ='Assessment.aspx';", true);
                }
                string insertQNAQuestion = "insert into WrittenQuestion" + "(QuestionTitle,WrittenID,MaximumScore) values (@QuestionTitle,@WrittenID,@MaximumScore)";
                SqlCommand insertIntoQNA = new SqlCommand(insertQNAQuestion, con);
                insertIntoQNA.Parameters.AddWithValue("@QuestionTitle", QNAQuestionTitle);
                insertIntoQNA.Parameters.AddWithValue("@WrittenID", addedQNAAssessmentID);
                insertIntoQNA.Parameters.AddWithValue("@MaximumScore", Score);
                try
                {
                    insertIntoQNA.ExecuteNonQuery();
                    QNATitle.Text = "";
                    Mark.Text = "";
                    Selection.SelectedValue = "ExistingAssessment";
                    TypeOfQuestion.SelectedValue = "QNA";                
                    con.Close();
                    ChooseAssessment2.DataBind();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Successfull Added a New Question');", true);
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Problem Occur!');window.location ='Assessment.aspx';", true);
                }

            }
            else
            {
                con.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please Fill in All the Content');", true);
            }
           
        }

        protected void SubmitButtonExisting_Click(object sender, EventArgs e)
        {
            string databaseConnect = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
            SqlConnection con = new SqlConnection(databaseConnect);
            con.Open();
            string TOQ = TypeOfQuestion.SelectedValue;

            if (TOQ == "MCQ")
            {
                string QuestionTitle = MCQTitle.Text;
                string A = OptionA.Text;
                string B = OptionB.Text;
                string C = OptionC.Text;
                string D = OptionD.Text;
                string Answer = OptionValue.Value;

                string insertMCQQuestion = "insert into MCQQuestion" + "(QuestionTitle,ChoiceA,ChoiceB,ChoiceC,ChoiceD,Answer,MCQAssessmentID) values (@QuestionTitle,@ChoiceA,@ChoiceB,@ChoiceC,@ChoiceD,@Answer,@MCQAssessmentID)";
                SqlCommand insertIntoMCQ = new SqlCommand(insertMCQQuestion, con);
                insertIntoMCQ.Parameters.AddWithValue("@QuestionTitle", QuestionTitle);
                insertIntoMCQ.Parameters.AddWithValue("@ChoiceA", A);
                insertIntoMCQ.Parameters.AddWithValue("@ChoiceB", B);
                insertIntoMCQ.Parameters.AddWithValue("@ChoiceC", C);
                insertIntoMCQ.Parameters.AddWithValue("@ChoiceD", D);
                insertIntoMCQ.Parameters.AddWithValue("@Answer", Answer);
                insertIntoMCQ.Parameters.AddWithValue("@MCQAssessmentID", ChooseAssessment.SelectedValue);
                try
                {
                    insertIntoMCQ.ExecuteNonQuery();
                    MCQTitle.Text = "";
                    OptionA.Text = "";
                    OptionB.Text = "";
                    OptionC.Text = "";
                    OptionD.Text = "";
                    OptionAnswer1.Checked = false;
                    OptionAnswer2.Checked = false;
                    OptionAnswer3.Checked = false;
                    OptionAnswer4.Checked = false;
                    con.Close();
                    //ChooseAssessment.DataBind();   
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Successfull Added a New Question');", true);
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Problem Occur!');window.location ='Assessment.aspx';", true);
                }
            }
            else if(TOQ == "QNA")
            {
                string QNAQuestionTitle = QNATitle.Text;
                int Score = int.Parse(Mark.Text);

                string insertMCQQuestion = "insert into WrittenQuestion" + "(QuestionTitle,WrittenID,MaximumScore) values (@QuestionTitle,@WrittenID,@MaximumScore)";
                SqlCommand writtenValue = new SqlCommand(insertMCQQuestion, con);
                writtenValue.Parameters.AddWithValue("@QuestionTitle", QNAQuestionTitle);
                writtenValue.Parameters.AddWithValue("@WrittenID", ChooseAssessment2.SelectedValue);
                writtenValue.Parameters.AddWithValue("@MaximumScore", Score);
                try
                {
                    writtenValue.ExecuteNonQuery();
                    QNATitle.Text = "";
                    Mark.Text = "";
                    con.Close();
                    //ChooseAssessment2.DataBind();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Successfull Added a New Question');", true);
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Problem Occur!');window.location ='Assessment.aspx';", true);
                }

            }
            else
            {
                con.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please Fill in All the Content');", true);
            }
        }

    }
}