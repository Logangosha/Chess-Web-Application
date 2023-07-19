using Chess_App.Classes;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Chess_App
{
    public partial class Messages : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                //string eventTarget = Request["__EVENTTARGET"];
                //string eventArgument = Request["__EVENTARGUMENT"];

                //if (eventTarget == "SearchedUser")
                //{
                //    // Handle the postback from the button with the button value
                //    string buttonValue = eventArgument;
                //    Debug.WriteLine(buttonValue);
                //    List<PlayerAccount> SearchResults = Session["SearchUserResults"] as List<PlayerAccount>;
                //    if (SearchResults != null)
                //    {
                //        PlayerAccount selectedAccount = SearchResults.FirstOrDefault(a => a.Username == buttonValue);
                //        if (selectedAccount != null)
                //        {
                //            // Perform necessary server-side logic with the selected account
                //            Session["SearchUserResults"] = null;
                //            Session["SelectedUserAccount"] = selectedAccount;
                //            Response.Redirect("FriendAccount.aspx");
                //        }
                //        else
                //        {
                //            Debug.WriteLine("Selected Account not found.");
                //        }
                //    }
                //    else
                //    {
                //        Debug.WriteLine("Session data not found or invalid.");
                //    }
                //}
            }
        }

        [WebMethod]
        public static List<PlayerAccount> SearchUsers(string searchText)
        {
            try
            {
                Debug.WriteLine("SearchText is " + searchText);
                List<PlayerAccount> results = DatabaseAccess.SearchUsers(searchText);
                //here
                foreach (PlayerAccount account in results)
                {
                    if (account.ID == (HttpContext.Current.Session["AccountInfo"] as PlayerAccount).ID)
                    {
                        results.Remove(account);
                        break;
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
    }
}