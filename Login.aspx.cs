using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Chess_App
{
    public partial class Sign_In : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            PlayerAccount player = new PlayerAccount("fName", "lName", "uName", "email", "dob", new AccountPassword("password"));
            Session["AccountInfo"] = player;
            Response.Redirect("Home.aspx");
        }

        protected void FrogotPasswordBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Recover.aspx");
        }

        protected void AccountBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }
    }
}