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
            Response.Redirect("default.aspx");
        }

        protected void goHomeBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }

        protected void EditAccountInfoSaveBtn_Click(object sender, EventArgs e)
        {
            DatabaseAccess.SaveNewAccountInfo((((PlayerAccount)Session["AccountInfo"]).Username), usernameTbx.Value, emailTbx.Value);
            ((PlayerAccount)Session["AccountInfo"]).Username = usernameTbx.Value;
            ((PlayerAccount)Session["AccountInfo"]).Email = emailTbx.Value;
        }

        protected void changePasswordSaveBtn_Click(object sender, EventArgs e)
        {
            DatabaseAccess.SaveNewPassword((((PlayerAccount)Session["AccountInfo"]).Username), newPasswordTbx.Text);
        }
    }
}