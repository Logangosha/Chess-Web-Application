using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Chess_App
{
    public partial class Account : System.Web.UI.Page
    {
        public string takenUsername = "test";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                primaryColor.Value = Session["primaryColor"].ToString();
                backgroundColor.Value = Session["backgroundColor"].ToString();
                statusColor.Value = Session["statusColor"].ToString();
            }
        }

        protected void ChangeThemeSaveBtn_Click(object sender, EventArgs e)
        {
            Session["primaryColor"] = primaryColor.Value;
            Session["backgroundColor"] = backgroundColor.Value;
            Session["statusColor"] = statusColor.Value;
        }

        protected void DeleteAccountModalBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("default.aspx");
        }

        protected void goHomeBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }
    }
}