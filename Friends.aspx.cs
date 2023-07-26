using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Chess_App.Classes;
using System.Web.Services;
using System.Diagnostics;
using Newtonsoft.Json;
using System.Security.Principal;

namespace Chess_App
{
    public partial class Friends : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string eventTarget = Request["__EVENTTARGET"];
                string eventArgument = Request["__EVENTARGUMENT"];

                if (eventTarget == "SearchedUser")
                {
                    // Handle the postback from the button with the button value
                    string buttonValue = eventArgument;
                    Debug.WriteLine(buttonValue);
                    List<PlayerAccount> SearchResults = Session["SearchUserResults"] as List<PlayerAccount>;
                    if (SearchResults != null)
                    {
                        PlayerAccount selectedAccount = SearchResults.FirstOrDefault(a => a.Username == buttonValue);
                        if (selectedAccount != null)
                        {
                            // Perform necessary server-side logic with the selected account
                            Session["SearchUserResults"] = null;
                            Session["SelectedUserAccount"] = selectedAccount;
                            Response.Redirect("FriendAccount.aspx");
                        }
                        else
                        {
                            Debug.WriteLine("Selected Account not found.");
                        }
                    }
                    else
                    {
                        Debug.WriteLine("Session data not found or invalid.");
                    }
                }
                if (eventTarget == "FriendSelected")
                {
                    // Handle the postback from the button with the button value
                    string buttonValue = eventArgument;
                    Debug.WriteLine(buttonValue);
                    List<PlayerAccount> FriendResults = Session["FriendResults"] as List<PlayerAccount>;
                    if (FriendResults != null)
                    {
                        PlayerAccount selectedAccount = FriendResults.FirstOrDefault(a => a.Username == buttonValue);
                        if (selectedAccount != null)
                        {
                            // Perform necessary server-side logic with the selected account
                            Session["FriendResults"] = null;
                            Session["SelectedUserAccount"] = selectedAccount;
                            Response.Redirect("FriendAccount.aspx");
                        }
                        else
                        {
                            Debug.WriteLine("Selected Account not found.");
                        }
                    }
                    else
                    {
                        Debug.WriteLine("Session data not found or invalid.");
                    }
                }
            }
        }

        [WebMethod]
        public static List<PlayerAccount> SearchUsers(string searchText)
        {
            try
            {
                Debug.WriteLine("SearchText is " + searchText);
                List<PlayerAccount> results = DatabaseAccess.SearchUsers(searchText);
                int currentUserId = (HttpContext.Current.Session["AccountInfo"] as PlayerAccount).ID;

                // Retrieve the friend list for the current user
                List<PlayerAccount> friendResults = HttpContext.Current.Session["FriendResults"] as List<PlayerAccount>;

                // Check if the account is a friend or the current user
                foreach (PlayerAccount account in results.ToList()) // Using ToList() to create a copy of the list to avoid modification issues
                {
                    if (account.ID == currentUserId || (friendResults != null && friendResults.Any(friend => friend.ID == account.ID)))
                    {
                        results.Remove(account);
                    }
                }

                HttpContext.Current.Session["SearchUserResults"] = results;
                Debug.WriteLine("Results count: " + results.Count);
                return results;
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return null;
            }
        }
        [WebMethod]
        public static List<PlayerAccount> GetFriends()
        {
            try
            {
                List<PlayerAccount> results = DatabaseAccess.GetFriends((HttpContext.Current.Session["AccountInfo"] as PlayerAccount).ID);
                HttpContext.Current.Session["FriendResults"] = results;
                return results;
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return null;
            }
        }
    }
}