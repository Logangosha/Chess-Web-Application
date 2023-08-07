using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Diagnostics;
using Chess_App.Classes;

namespace Chess_App
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AccountInfo"] != null)
            {
                HttpContext.Current.Session["AccountInfo"] = null;
                HttpContext.Current.Session["GameData"] = null;
                HttpContext.Current.Session["primaryColor"] = "#FFFFFF";
                HttpContext.Current.Session["backgroundColor"] = "#000000";
                HttpContext.Current.Session["statusColor"] = "#3B3B3B";
            }
        }


        protected void LoginBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void PlayAsGuestBtn_Click(object sender, EventArgs e)
        {
            Guest guest = new Guest();
            Session["AccountInfo"] = guest;
            Response.Redirect("Home.aspx");
        }

        protected void NeedAnAccountBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }
    }
}