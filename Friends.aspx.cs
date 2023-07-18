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
            }
        }

        [WebMethod]
        public static List<PlayerAccount> SearchUsers(string searchText)
        {
            try
            {
                Debug.WriteLine("SearchText is " + searchText);
                List<PlayerAccount> results = DatabaseAccess.SearchUsers(searchText);
                HttpContext.Current.Session["SearchUserResults"] = results;
                Debug.WriteLine("Results count: " + results.Count);
                // Access the UserTilesPlaceholder control through the class-level variable
                Friends page = HttpContext.Current.Handler as Friends;
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