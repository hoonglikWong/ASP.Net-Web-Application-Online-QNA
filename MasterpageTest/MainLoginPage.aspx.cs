using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
using MasterpageTest.Models;

namespace MasterpageTest
{
    public partial class MainLoginPage : System.Web.UI.Page
    {
        Person person = new Person();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if(Request.Cookies["loginEmailCookies"] !=null && Request.Cookies["loginPasswordCookies"] != null)
                {
                    ChkMe.Checked = true;
                    loginEmail.Text = Request.Cookies["loginEmailCookies"].Value;
                    loginPassword.Attributes["value"]= Request.Cookies["loginPasswordCookies"].Value;
                }
            }
        }

        protected void loginButton_Click(object sender, EventArgs e)
        {
            string databaseConnect = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
            SqlConnection con = new SqlConnection(databaseConnect);
            con.Open();
            string allValue = "select * from Person where Email='" + loginEmail.Text + "'";
            SqlCommand allComm = new SqlCommand(allValue, con);
            initPersonDetail(allComm);
            con.Close();
            if (person.Email != null)
            {
                if(person.Password == loginPassword.Text)
                {
                    if (ChkMe.Checked)
                    {
                        Response.Cookies["loginEmailCookies"].Value = loginEmail.Text;
                        Response.Cookies["loginPasswordCookies"].Value = loginPassword.Text;
                        Response.Cookies["loginEmailCookies"].Expires = DateTime.Now.AddDays(1);
                        Response.Cookies["loginPasswordCookies"].Expires = DateTime.Now.AddDays(1);
                    }
                    else
                    {
                        Response.Cookies["loginEmailCookies"].Expires = DateTime.Now.AddDays(-1);
                        Response.Cookies["loginPasswordCookies"].Expires = DateTime.Now.AddDays(-1);
                    }


                    Session["PersonDetail"] = person;
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(),"alert", "alert('Please enter a correct Email and Password!');window.location ='MainLoginPage.aspx';", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please enter a correct Email and Password!');window.location ='MainLoginPage.aspx';", true);
            }
        }

        protected void signupButton_Click(object sender, EventArgs e)
        {
            string databaseConnect = ConfigurationManager.ConnectionStrings["AssignmentEntities"].ConnectionString.ToString();
            SqlConnection con = new SqlConnection(databaseConnect);
            con.Open();
            string insertRecord = "insert into Person" + "(Email, Name, ContactNumber, Password, ProfileImage, Status, Gender) values (@Email,@Name,@ContactNumber,@Password,@ProfileImage,@Status,@Gender)";
            SqlCommand insertComm = new SqlCommand(insertRecord, con);
            insertComm.Parameters.AddWithValue("@Email", SignUpEmail.Text);
            insertComm.Parameters.AddWithValue("@Name", Name.Text);
            insertComm.Parameters.AddWithValue("@ContactNumber", SignUpContact.Text);
            insertComm.Parameters.AddWithValue("@Password", SignUpPassword.Text);
            insertComm.Parameters.AddWithValue("@ProfileImage", "");
            insertComm.Parameters.AddWithValue("@Status", SignUpStatus.Text);
            insertComm.Parameters.AddWithValue("@Gender", SignUpGender.SelectedValue);
            try
            {
                insertComm.ExecuteNonQuery();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Successfull Registration, Please try to login!');window.location ='MainLoginPage.aspx';", true);
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('The email address are exist in our database, Please try another email address!');window.location ='MainLoginPage.aspx';", true);
            }


        }

        public void initPersonDetail(SqlCommand allComm)
        {
            using (var reader = allComm.ExecuteReader())
            {
                while (reader.Read())
                {
                    int ordinal = reader.GetOrdinal("Email");
                    if (!reader.IsDBNull(ordinal))
                    {
                        person.Email = reader.GetString(ordinal);
                    }
                    ordinal = reader.GetOrdinal("Name");
                    if (!reader.IsDBNull(ordinal))
                    {
                        person.Name = reader.GetString(ordinal);
                    }

                    ordinal = reader.GetOrdinal("ContactNumber");
                    if (!reader.IsDBNull(ordinal))
                    {
                        person.ContactNumber = reader.GetString(ordinal);
                    }
                    ordinal = reader.GetOrdinal("Password");
                    if (!reader.IsDBNull(ordinal))
                    {
                        person.Password = reader.GetString(ordinal);
                    }
                    ordinal = reader.GetOrdinal("ProfileImage");
                    if (!reader.IsDBNull(ordinal))
                    {
                        person.ProfileImage = reader.GetString(ordinal);
                    }
                    ordinal = reader.GetOrdinal("Status");
                    if (!reader.IsDBNull(ordinal))
                    {
                        person.Status = reader.GetString(ordinal);
                    }
                    ordinal = reader.GetOrdinal("Gender");
                    if (!reader.IsDBNull(ordinal))
                    {
                        person.Gender = reader.GetString(ordinal);
                    }
                }
            }
        }
        
    }
}