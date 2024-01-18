using Chess_App.Classes;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Services;
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
            }

            UsingAccount = IsUsingAccount();
            if (UsingAccount)
            {
                
            }
        }

        public bool IsUsingAccount()
        {
            if (Session["AccountInfo"] != null)
            {
                if (Session["AccountInfo"] is Guest)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            else
            {
                Response.Redirect("Default.aspx");
                return false;
            }
        }

        //protected void SaveBtn_Click(object sender, EventArgs e)
        //{
        //    Session["primaryColor"] = primaryColor.Value;
        //    Session["backgroundColor"] = backgroundColor.Value;
        //}
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
                case "Online": Response.Redirect("GameSetup.aspx?type=" + e.CommandArgument + ""); break;
                case "Computer": Response.Redirect("GameSetup.aspx?type=" + e.CommandArgument + ""); break;
                case "Local": Response.Redirect("GameSetup.aspx?type=" + e.CommandArgument + ""); break;
                case "Default": Response.Redirect("GameSetup.aspx?type=" + e.CommandArgument + ""); break;
            }
        }

        protected void SignInBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void CreateAccountBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }

        protected void GoToGamePageBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("GamePage.aspx");
        }

        [WebMethod]
        public static List<PlayerAccount> GetFriends()
        {
            try
            {
                if (HttpContext.Current.Session["AccountInfo"] == null)
                {
                    return null;
                }
                else if (HttpContext.Current.Session["AccountInfo"] is Guest)
                {
                    return null;
                }
                else
                {
                    return DatabaseAccess.GetFriends((HttpContext.Current.Session["AccountInfo"] as PlayerAccount).ID);
                }
            }
            catch (NullReferenceException nullEx)
            {
                Debug.WriteLine("NullReferenceException: " + nullEx.Message);
                return null;
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return null;
            }
        }

        [WebMethod]
        public static List<PlayerAccount> RetrieveLastAccountMessagesWithUserInfo()
        {
            try
            {
                // check if player is a guest of using an account
                if (HttpContext.Current.Session["AccountInfo"] == null)
                {
                    return null;
                }
                else if (HttpContext.Current.Session["AccountInfo"] is Guest)
                {
                    return null;
                }
                else { 
                List<PlayerAccount> accountMessages = DatabaseAccess.RetrieveLastAccountMessagesWithUserInfo((HttpContext.Current.Session["AccountInfo"] as PlayerAccount).ID);
                HttpContext.Current.Session["AccountMessages"] = accountMessages;
                return accountMessages;
                }

                //Debug.WriteLine("Account Messages Recieved!");
            }
            catch (NullReferenceException nullEx)
            {
                // Handle the NullReferenceException here
                // You might want to log or throw a specific exception
                // based on your error handling strategy.
                Debug.WriteLine("NullReferenceException: " + nullEx.Message);
                return null;
            }
            catch (Exception e)
            {
                Debug.WriteLine("Error in web method RetrieveLastAccountMessagesWithUserInfo:" + e.Message);
                return null;
            }
        }
    }
}