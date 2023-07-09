using Chess_App.Classes;
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
            // Check if username and password are correct
            PlayerAccount playerAccount = DatabaseAccess.GetUserAccount(UsernameTbx.Text, PasswordTbx.Text);
            if (playerAccount == null)
            {
                // throw error
                System.Diagnostics.Debug.WriteLine("Username or password was incorrect");
            }
            else {
                // login the user in 
                playerAccount.Login();
                Response.Redirect("Home.aspx");
                return;
            }
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