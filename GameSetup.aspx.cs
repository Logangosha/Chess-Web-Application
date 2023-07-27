using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Chess_App
{
    public partial class GamePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["Type"] == null)
                {
                    Response.Redirect("Home.aspx");
                }
            }
        }

        protected void goHomeBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }
        protected void GameSetup_Command(object sender, CommandEventArgs e)
        {
            switch (e.CommandArgument.ToString())
            {
                case "Online": Response.Redirect("GameSetup.aspx?type=" + e.CommandArgument + ""); break;
                case "Computer": Response.Redirect("GameSetup.aspx?type=" + e.CommandArgument + ""); break;
                case "Friends": Response.Redirect("GameSetup.aspx?type=" + e.CommandArgument + ""); break;
                case "Default": Response.Redirect("GameSetup.aspx?type=" + e.CommandArgument + ""); break;
            }
        }
    }
}