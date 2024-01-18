using Chess_App.Classes;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.Services.Description;
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
                
            }
        }

        protected void goHomeBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }

        [WebMethod]
        public static List<PlayerAccount> RetrieveLastAccountMessagesWithUserInfo()
        {
            try
            {
                List<PlayerAccount> accountMessages = DatabaseAccess.RetrieveLastAccountMessagesWithUserInfo((HttpContext.Current.Session["AccountInfo"] as PlayerAccount).ID);
                HttpContext.Current.Session["AccountMessages"] = accountMessages;

                Debug.WriteLine("Account Messages Recieved!");
                for (int i = 0; i < accountMessages.Count; i++)
                {
                    Debug.WriteLine("PlayerAccount( ConversationPartnerId: " + accountMessages[i].ID
                                        + ", Username: " + accountMessages[i].Username
                                        + ", OnlineStatus: " + accountMessages[i].OnlineStatus
                                        + ", ProfilePicture: " + accountMessages[i].ProfilePicture
                                        + ", IsNewMessage: " + accountMessages[i].MessageData[0]
                                        + ", MessageType: " + accountMessages[i].MessageData[1]
                                        + ", Content: " + accountMessages[i].MessageData[2]
                                        + ", Timestamp: " + accountMessages[i].MessageData[3]
                                        + " )");
                }
                return accountMessages;
            }
            catch (Exception e)
            {
                Debug.WriteLine("Error in web method RetrieveLastAccountMessagesWithUserInfo:" + e.Message);
                return null;
            }
        }

        [WebMethod]
        public static List<Message> GetMessagesBetweenUsers(int recipientId)
        {
            try
            {
                List<Message> messages = DatabaseAccess.GetMessagesBetweenUsers((HttpContext.Current.Session["AccountInfo"] as PlayerAccount).ID, recipientId);
                return messages;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);   
                return null;
            }
        }

        [WebMethod]
        public static string SendMessage(string message, int recipientId, int messageType, bool? isAccepted)
        {
            try
            {
                DatabaseAccess.SendMessage(message, (HttpContext.Current.Session["AccountInfo"] as PlayerAccount).ID, recipientId, messageType, isAccepted);

                // Return a success message
                return "success";
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);

                // Return an error message
                return "Error sending the message.";
            }
        }

        [WebMethod]
        public static void HandleFriendRequest(int recipientId, int isAccepted, int messageId)
        {
            try
            {
                Debug.WriteLine("Attempting to handle friend request");
                DatabaseAccess.HandleFriendRequest((HttpContext.Current.Session["AccountInfo"] as PlayerAccount).ID,recipientId, isAccepted, messageId);
                Debug.WriteLine("friend request handled!");
            }
            catch (Exception e)
            {
                Debug.WriteLine("C# Error" +e.Message);
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

                // Retrieve the account messages for the current user
                List<PlayerAccount> accountMessages = DatabaseAccess.RetrieveLastAccountMessagesWithUserInfo(currentUserId);
                for (int i = 0; i < accountMessages.Count; i++)
                {
                    //Debug.WriteLine("PlayerAccount( ConversationPartnerId: " + accountMessages[i].ID
                    //                    + ", Username: " + accountMessages[i].Username
                    //                    + ", OnlineStatus: " + accountMessages[i].OnlineStatus
                    //                    + ", ProfilePicture: " + accountMessages[i].ProfilePicture
                    //                    + ", IsNewMessage: " + accountMessages[i].MessageData[0]
                    //                    + ", MessageType: " + accountMessages[i].MessageData[1]
                    //                    + ", Content: " + accountMessages[i].MessageData[2]
                    //                    + ", Timestamp: " + accountMessages[i].MessageData[3]
                    //                    + " )");
                }

                // Check if the account is the current user or if there are messages with the current user
                foreach (PlayerAccount account in results.ToList()) // Using ToList() to create a copy of the list to avoid modification issues
                {
                    if (account.ID == currentUserId || accountMessages.Any(accountMsg => accountMsg.ID == account.ID))
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
    }
}