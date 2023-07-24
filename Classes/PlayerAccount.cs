using Chess_App;
using Microsoft.AspNet.FriendlyUrls.ModelBinding;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Chess_App.Classes;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Security.Principal;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;

namespace Chess_App
{
    public class PlayerAccount
    {
        public int ID { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
        public byte[][] PasswordData { get; set; }
        public Theme Theme { get; set; }
        public byte[] ProfilePicture { get; set; } 
        public string ProfilePictureString { get; set; }
        public bool OnlineStatus { get; set; } 
        public List<Friend> Friends { get; set; }

        public string[] MessageData { get; set; }

        //when account is logged into
        public PlayerAccount(int ID, string _uName, string _email, Theme theme, byte[] profilePicture, bool onlineStatus)
        {
            this.ID = ID;
            Username = _uName;
            Email = _email;
            Theme = theme;
            ProfilePicture = profilePicture;
            ProfilePictureString = GetImgSrc(profilePicture);
            OnlineStatus = onlineStatus;
        }
        // when account is created 
        public PlayerAccount(string _uName, string _email, byte[][] _password)
        {
            Username = _uName;
            Email = _email;
            PasswordData = _password;
            Theme = new Theme("#FF0000", "#000000", "#660000");
            string hexString = "524946466A020000574542505650384C5D0200002FFFC03F0027A0A86D23863FC98E7B6D0287444DDB480C7F92577EEA047E52D33612C39FE4959F3A819FE63FFEFFDD012022642640AC6D356E04520A20B60B501215904505C492FAAF2AC958F039B3CF44F47F02E8DFFF7F3A96C3B5F55E4E13FB2487D69F96891D92DA5FCEEC8EB4FEC6C2CE48EB6F2EEC8AB4BE61614F6ADF343B72E91BCF6E48DF9CBDA8DB6527521F187CA823B20BA90F0D1ED431D901E98319DF7DD48CAF8D2AF0521F1ED0ADE376E8DAB8024EBA42C676D610B1AD1A166C4D43C1D65532B2A423203BEB88C8561D0BB2AA23236B3A0A30E94A819116C625EE252DE1FD72D612DF2F772DBBF7CB594BC475D7B2C375D612DF2F494B78BF8816C6455A0878D351DE3355474676D7B14376D61191251D0119E920E85543C6B66A58B0250D119B6820F0755C46771E17D1C9384647755426F8E751111F8D6207D6310B392863D8035A472CE4A28C601FE8B2DD4C4E4ADBAAB01794B60AE4E7659B993CAD5B647255EADB32392BF52D99BD213ABC3693C7727D7662725A0ED7DBED3431FD847D685DF96D02B376830B944B37390349DD68C051AD6418A99B0D28563B198474BB853124433D62582D2D18AAA58CA19B8620B61841B2157E82115BFC1E205B04B1592A18AAA58C61B5B4BC0FCE962206B1C4EF03AA7632815CED2C28929D8042EC300AAA5632C13C5B8938C40AE3A06A2313D0642320A166A110D48B85190B357D85C09EF54534D4B415829BB4053C74D1351360A99A0A2322D1C48439E9990875D23211EEA46322E4A2A04C845DEAA8CC04FFD04694893C94EB76272627E5B2CDC4E4E9FED85E2BC73D93BBB23F3E9E26A67FFFFFE51E00";
            byte[] ImageBytes = new byte[hexString.Length / 2];
            for (int i = 0; i < hexString.Length; i += 2)
            {
                ImageBytes[i / 2] = Convert.ToByte(hexString.Substring(i, 2), 16);
            }
            ProfilePicture = ImageBytes;
            ProfilePictureString = GetImgSrc(ImageBytes);
            OnlineStatus = true;

        }

        // when account is searched and loaded from database
        public PlayerAccount(int ID, string _uName, Theme theme, byte[] profilePicture, bool onlineStatus)
        {
            this.ID = ID;
            Username = _uName;
            Theme = theme;
            ProfilePicture = profilePicture;
            ProfilePictureString = GetImgSrc(profilePicture);
            OnlineStatus = onlineStatus;
        }

        // when account is loaded from database for message list 
        public PlayerAccount(int ID, string _uName,bool onlineStatus, byte[] profilePicture, bool isNewMessage, int messageType, string message, DateTime timestamp)
        {
            this.ID = ID;
            Username = _uName;
            ProfilePicture = profilePicture;
            ProfilePictureString = GetImgSrc(profilePicture);
            OnlineStatus = onlineStatus;
            MessageData = new string[4];
            MessageData[0] = isNewMessage.ToString();
            MessageData[1] = messageType.ToString();
            MessageData[2] = message;
            MessageData[3] = timestamp.ToString();
        }

        public void Login()
        {
            DatabaseAccess.SetOnlineStatus(this.Username,"1");
            HttpContext.Current.Session["AccountInfo"] = this;
            if (this.Theme != null) {
            HttpContext.Current.Session["PrimaryColor"] = this.Theme.PrimaryColor;
            HttpContext.Current.Session["BackgroundColor"] = this.Theme.BackgroundColor;
            HttpContext.Current.Session["StatusColor"] = this.Theme.StatusColor;
            }
        }

        public void Logout()
        {
            DatabaseAccess.SetOnlineStatus(this.Username,"0");
            Global.ClearSessionData();
        }

        public static string GetImgSrc(byte[] imageData)
        {
            // Retrieve the profile picture byte array
            byte[] profilePictureBytes = imageData;

            // Convert the byte array to a Base64-encoded string
            string base64String = Convert.ToBase64String(profilePictureBytes);

            // Construct the image source with the Base64-encoded string
            string imageSource = "data:image/jpeg;base64," + base64String;



            return imageSource;
        }

    }
}