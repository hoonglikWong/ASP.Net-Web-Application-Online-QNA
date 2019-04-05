using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MasterpageTest
{
    public partial class ManageQuestion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HiddenTypeOfQuestion.Value = Request.QueryString["TypeOfQuestion"].ToString();
            if(HiddenTypeOfQuestion.Value == "QNA")
            {
                HiddenData.Value = Request.QueryString["WrittenID"].ToString();
            }
            else if(HiddenTypeOfQuestion.Value == "MCQ")
            {
                HiddenData.Value = Request.QueryString["MCQAssessmentID"].ToString();
            }
            else
            {

            }
        }
    }
}