using Chess_App.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Data;

namespace Chess_App
{
    public partial class Account : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!Page.IsPostBack)
            {
                if (Session["AccountInfo"] != null)
                {
                    PlayerAccount account = (PlayerAccount)Session["AccountInfo"];
                    usernameTbx.Value = account.Username;
                    emailTbx.Value = account.Email;
                    profileImg.Src = account.ProfilePictureString;
                    primaryColor.Value = account.Theme.PrimaryColor.ToString();
                    backgroundColor.Value = account.Theme.BackgroundColor.ToString();
                    statusColor.Value = account.Theme.StatusColor.ToString();
                }
            }
        }

        protected void ChangeThemeSaveBtn_Click(object sender, EventArgs e)
        {
            PlayerAccount playerAccount = ((PlayerAccount)Session["AccountInfo"]);
            Theme newTheme = new Theme(primaryColor.Value, backgroundColor.Value, statusColor.Value);
            DatabaseAccess.SaveThemeSettings(playerAccount.Username, newTheme);
            playerAccount.Theme = newTheme;
            Session["AccountInfo"] = playerAccount;
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


        protected void SignOutBtn_Click(object sender, EventArgs e)
        {
            PlayerAccount playerAccount = (PlayerAccount)Session["AccountInfo"];
            playerAccount.Logout();
            Response.Redirect("Default.aspx");
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
                string imgSrcStr = PlayerAccount.GetImgSrc(imageBytes);
                PlayerAccount playerAccount = (PlayerAccount)Session["AccountInfo"];

                playerAccount.ProfilePicture = imageBytes;
                playerAccount.ProfilePictureString = imgSrcStr;

                HttpContext.Current.Session["AccountInfo"] = null;
                HttpContext.Current.Session["AccountInfo"] = playerAccount;

                // Set the src attribute of the <img> tag
                profileImg.Src = imgSrcStr;
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