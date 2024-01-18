using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Chess_App.Classes;

using System.Web.Services;
using System.Diagnostics;

namespace Chess_App
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CreateAccountBtn_Click(object sender, EventArgs e)
        {

            // debug values for testing
            Debug.WriteLine("Username: " + UnameTbx.Text);
            Debug.WriteLine("Email: " + EmailTbx.Text);

            // Check if UsernameTbx.Text or EmailTbx.Text already exists in the database
            if (DatabaseAccess.IsUsernameTaken(UnameTbx.Text) || DatabaseAccess.IsEmailTaken(EmailTbx.Text))
            {
                // they do exist, display an error message
                Debug.WriteLine(DatabaseAccess.IsUsernameTaken(UnameTbx.Text).ToString());
                Debug.WriteLine(DatabaseAccess.IsEmailTaken(EmailTbx.Text).ToString());
                Debug.WriteLine("Username or Email already exists");
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
                PlayerAccount newPlayerAccount = new PlayerAccount(UnameTbx.Text, EmailTbx.Text, passwordData);

                DatabaseAccess.InsertNewUser(newPlayerAccount);
                newPlayerAccount = DatabaseAccess.GetUserAccount(UnameTbx.Text, PasswordTbx.Text);
                newPlayerAccount.Login();
                Response.Redirect("Home.aspx");
                return;
            }
        }

        [WebMethod]
        public static bool CheckUsername(string username)
        {
            Debug.WriteLine($"Username {username}");
            bool result = DatabaseAccess.IsUsernameTaken(username);
            Debug.WriteLine(result.ToString());
            return result;
        }

        [WebMethod]
        public static bool CheckEmail(string email)
        {
            Debug.WriteLine($"Email {email}");
            bool result = DatabaseAccess.IsEmailTaken(email);
            Debug.WriteLine(result.ToString());
            return result;
        }
    }
}