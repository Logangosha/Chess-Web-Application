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
                Session["AccountInfo"] = null;
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