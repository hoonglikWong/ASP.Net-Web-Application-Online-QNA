using MasterpageTest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MasterpageTest
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Person person = (Person)Session["personDetail"];
            HiddenData.Value = person.Status;
            LoginName.Text = person.Name;
        }
    }
}