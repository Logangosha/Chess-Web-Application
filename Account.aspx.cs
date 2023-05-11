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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                primaryColor.Value = Session["mainColor"].ToString();
                backgroundColor.Value = Session["backgroundColor"].ToString();
            }
        }

        protected void ChangeThemeSaveBtn_Click(object sender, EventArgs e)
        {
            Session["mainColor"] = primaryColor.Value;
            Session["backgroundColor"] = backgroundColor.Value;
        }

        protected void DeleteAccountModalBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("default.aspx");
        }
    }
}