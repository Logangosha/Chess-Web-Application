using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace Chess_App
{
    public partial class Friends : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            //    // Assuming you have a List<User> containing multiple user records retrieved from the database
            //    List<PlayerAccount> friendList = GetUsersFromDatabase(); // Retrieve the list of users

            //    foreach (PlayerAccount friend in friendList)
            //    {
            //        // Create the div element for the friend tile
            //        HtmlGenericControl friendTileDiv = new HtmlGenericControl("div");
            //        friendTileDiv.Attributes["class"] = "Btn friend-tile";

            //        // Create the img element and set its src attribute to the ProfileImageUrl
            //        HtmlGenericControl img = new HtmlGenericControl("img");
            //        img.Attributes["src"] = friend.ProfileImageUrl;

            //        // Create the p element and set its inner text to the Username
            //        HtmlGenericControl username = new HtmlGenericControl("p");
            //        username.InnerText = friend.Username;

            //        // Create the span element for the status indicator
            //        HtmlGenericControl statusIndicator = new HtmlGenericControl("span");
            //        statusIndicator.Attributes["class"] = friend.Status ? "status-indicator online" : "status-indicator offline";

            //        // Add the img, p, and span elements to the friend tile div
            //        friendTileDiv.Controls.Add(img);
            //        friendTileDiv.Controls.Add(username);
            //        friendTileDiv.Controls.Add(statusIndicator);

            //        // Add the friend tile div to the FriendTilesPlaceholder control
            //        FriendTilesPlaceholder.Controls.Add(friendTileDiv);
            //    }
            //}
        }

        protected void BtnAddFriend_Click(object sender, EventArgs e)
        {

        }

        protected void BtnFindFrined_Click(object sender, EventArgs e)
        {

        }

        protected void BtnSelectFriend_Click(object sender, EventArgs e)
        {
            Response.Redirect("FriendAccount.aspx");
        }
    }
}