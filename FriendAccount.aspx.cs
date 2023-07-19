using Chess_App.Classes;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Chess_App
{
    public partial class FriendAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["SelectedUserAccount"] != null)
                {
                    
                    PlayerAccount CurrentPlayerAccount = (PlayerAccount)Session["AccountInfo"];
                    PlayerAccount SelectedUserAccount = (PlayerAccount)Session["SelectedUserAccount"];
                    profileImg.Src = SelectedUserAccount.ProfilePictureString;
                    usernameLbl.InnerHtml = SelectedUserAccount.Username;
                    switch (IsFriend(CurrentPlayerAccount.ID, SelectedUserAccount.ID))
                    {
                        case 0: // not friends
                            Debug.WriteLine("Not friends");
                            ViewState["friendStatus"] = 0;
                            break;
                        case 1: // friends
                            Debug.WriteLine("Friends");
                            ViewState["friendStatus"] = 1;
                            break;
                        case 2: // pending
                            Debug.WriteLine("Pending");
                            ViewState["friendStatus"] = 2;
                            break;
                        default: // error
                            Debug.WriteLine("Error");
                            ViewState["friendStatus"] = -1;
                            break;
                    }
                }
            }
        }

        public int IsFriend(int currentUserId, int potientialFriendId)
        {
            return DatabaseAccess.IsFriend(currentUserId, potientialFriendId);
        }

        protected void FriendStatusBtn_Click(object sender, EventArgs e)
        {
            PlayerAccount CurrentPlayerAccount = (PlayerAccount)Session["AccountInfo"];
            PlayerAccount SelectedUserAccount = (PlayerAccount)Session["SelectedUserAccount"];
            switch (ViewState["friendStatus"])
            {
                case 0: // not friends
                    Debug.WriteLine("Not friends");
                    DatabaseAccess.SendFriendRequest(CurrentPlayerAccount.ID, SelectedUserAccount.ID);
                    ViewState["friendStatus"] = 2;
                    break;
                case 1: // friends
                    Debug.WriteLine("Friends");
                    DatabaseAccess.RemoveFriend(CurrentPlayerAccount.ID, SelectedUserAccount.ID);
                    ViewState["friendStatus"] = 0;
                    break;
                case 2: // pending
                    Debug.WriteLine("Pending");
                    DatabaseAccess.RemoveFriend(CurrentPlayerAccount.ID, SelectedUserAccount.ID);
                    ViewState["friendStatus"] = 0;
                    break;
                default: // error
                    Debug.WriteLine("Error");
                    ViewState["friendStatus"] = -1;
                    break;
            }
        }

        protected void goHomeBtn_Click(object sender, EventArgs e)
        {
            ViewState["friendStatus"] = null;
            Session["SelectedUserAccount"] = null;
            Response.Redirect("Home.aspx");
        }
    }
}