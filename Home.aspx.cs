using Chess_App.Classes;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace Chess_App
{
    public partial class Home : System.Web.UI.Page
    {
        public bool UsingAccount { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                primaryColor.Value = Session["mainColor"].ToString();
                backgroundColor.Value = Session["backgroundColor"].ToString();
            }

            if (Session["AccountInfo"] != null)
            {
                if (Session["AccountInfo"] is Guest)
                {
                    UsingAccount = false;
                }
                else
                {
                    UsingAccount = true;
                }
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void SaveBtn_Click(object sender, EventArgs e)
        {
            Session["mainColor"] = primaryColor.Value;
            Session["backgroundColor"] = backgroundColor.Value;
        }
        protected void AccountBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Account.aspx");
        }

        protected void MessageBtn_Click(object sender, EventArgs e)
        {
            if (AccountValidation.UsingAccount())
                Response.Redirect("Messages.aspx");
        }

        protected void FriendsBtn_Click(object sender, EventArgs e)
        {
            if (AccountValidation.UsingAccount())
                Response.Redirect("Friends.aspx");
        }

        protected void GameSetupBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("GameSetup.aspx");
        }

        protected void ModalLoginBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void GameSetup_Command(object sender, CommandEventArgs e)
        {
            switch (e.CommandArgument.ToString())
            {
                case "Online":   Response.Redirect("GameSetup.aspx?type="+e.CommandArgument+""); break;
                case "Computer": Response.Redirect("GameSetup.aspx?type=" + e.CommandArgument + ""); break;
                case "Friends":  Response.Redirect("GameSetup.aspx?type=" + e.CommandArgument + ""); break;
                case "Default":  Response.Redirect("GameSetup.aspx?type=" + e.CommandArgument + ""); break;
            } 
        }
    }
}