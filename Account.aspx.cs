using Chess_App.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Chess_App
{
    public partial class Account : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!Page.IsPostBack)
            {
                primaryColor.Value = Session["primaryColor"].ToString();
                backgroundColor.Value = Session["backgroundColor"].ToString();
                statusColor.Value = Session["statusColor"].ToString();
                if (Session["AccountInfo"] != null)
                {
                    PlayerAccount account = (PlayerAccount)Session["AccountInfo"];
                    usernameTbx.Value = account.Username;
                    emailTbx.Value = account.Email;
                    profileImg.Src = account.ProfilePictureString;
                }
            }
        }

        protected void ChangeThemeSaveBtn_Click(object sender, EventArgs e)
        {
            Session["primaryColor"] = primaryColor.Value;
            Session["backgroundColor"] = backgroundColor.Value;
            Session["statusColor"] = statusColor.Value;
            PlayerAccount playerAccount = ((Chess_App.PlayerAccount)Session["AccountInfo"]);
            Theme newTheme = new Theme(primaryColor.Value, backgroundColor.Value, statusColor.Value);
            DatabaseAccess.SaveThemeSettings(playerAccount.Username, newTheme);
        }

        [WebMethod]
        public static bool IsUsernameTaken(string username)
        {
            return DatabaseAccess.IsUsernameTaken(username);
        }

        [WebMethod]
        public static bool IsEmailTaken(string email)
        {
            return DatabaseAccess.IsEmailTaken(email);
        }

        [WebMethod]
        public static bool IsOldPasswordCorrect(string username, string password)
        {
            return DatabaseAccess.CheckCurrentPassword(username, password);
        }





        protected void DeleteAccountModalBtn_Click(object sender, EventArgs e)
        {
            // get current user account
            PlayerAccount playerAccount = (PlayerAccount)Session["AccountInfo"];
            DatabaseAccess.DeleteUser(playerAccount.Username);
            playerAccount.Logout();
            Response.Redirect("default.aspx");
        }

        protected void goHomeBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }

        protected void EditAccountInfoSaveBtn_Click(object sender, EventArgs e)
        {
            // Check if a file was uploaded
            if (fileInput.PostedFile != null && fileInput.PostedFile.ContentLength > 0)
            {
                // Get the uploaded file
                HttpPostedFile uploadedFile = fileInput.PostedFile;

                // Get the file bytes using the GetImageBytes method
                byte[] imageBytes = DatabaseAccess.GetImageBytes(uploadedFile);

                // Call the SaveNewAccountInfo method with the imageBytes
                DatabaseAccess.SaveNewAccountInfo(
                    ((PlayerAccount)Session["AccountInfo"]).Username,
                    usernameTbx.Value,
                    emailTbx.Value,
                    imageBytes
                );

                // Update the PlayerAccount object with the new profile picture
                ((PlayerAccount)Session["AccountInfo"]).ProfilePicture = imageBytes;

                // Convert the byte array to a Base64-encoded string
                string base64String = Convert.ToBase64String(imageBytes);

                // Construct the image source with the Base64-encoded string
                string imageSource = "data:image/jpeg;base64," + base64String;

                // Set the src attribute of the <img> tag
                profileImg.Src = imageSource;
            }
            else
            {
                // No file uploaded, perform other necessary updates without changing the profile picture
                DatabaseAccess.SaveNewAccountInfo(
                    ((PlayerAccount)Session["AccountInfo"]).Username,
                    usernameTbx.Value,
                    emailTbx.Value,
                    null // Pass null or handle the case appropriately in your SaveNewAccountInfo method
                );
                ((PlayerAccount)Session["AccountInfo"]).Username = usernameTbx.Value;
                ((PlayerAccount)Session["AccountInfo"]).Email = emailTbx.Value;
            }
        }

        protected void changePasswordSaveBtn_Click(object sender, EventArgs e)
        {
            DatabaseAccess.SaveNewPassword((((PlayerAccount)Session["AccountInfo"]).Username), newPasswordTbx.Text);
        }
    }
}