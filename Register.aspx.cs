using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Chess_App.Classes;

namespace Chess_App
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CreateAccountBtn_Click(object sender, EventArgs e)
        {

            // Check if UsernameTbx.Text or EmailTbx.Text already exists in the database
            if (DatabaseAccess.IsUsernameTaken(UnameTbx.Text) || DatabaseAccess.IsEmailTaken(EmailTbx.Text))
            {
                // they do exist, display an error message
                System.Diagnostics.Debug.WriteLine("Username or Email already taken");
            }
            else
            {
                // they do not exist, create new PlayerAccount

                // generate salt and hash password
                byte[] salt = PasswordHashHelper.GenerateSalt();
                byte[][] passwordData =
                {
                    PasswordHashHelper.CreatePasswordHash(PasswordTbx.Text, salt),
                    salt
                };
                System.Diagnostics.Debug.WriteLine("creating account");
                PlayerAccount newPlayerAccount = new PlayerAccount(UnameTbx.Text, EmailTbx.Text, passwordData);
                System.Diagnostics.Debug.WriteLine("inserting account");

                DatabaseAccess.InsertNewUser(newPlayerAccount);
                newPlayerAccount.Login();
                Response.Redirect("Home.aspx");
                return;
            }
        }
    }
}