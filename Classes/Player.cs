using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Chess_App.Classes
{
    public class Player
    {
        public string Username { get; set; }
        public byte[] ProfilePicture { get; set; }
        public GameData.Color Color { get; set; }
        public Player(PlayerAccount accountPlayer, GameData.Color color )
        {
            Username = accountPlayer.Username;
            ProfilePicture = accountPlayer.ProfilePicture;
            Color = color;
        }
        public Player(Guest guestPlayer, GameData.Color color)
        {
            Username= guestPlayer.Username;
            ProfilePicture = guestPlayer.ProfilePicture;
            Color = color;
        }
        public Player(Computer computerPlayer, GameData.Color color)
        {
            
            Color = color;
        }
    }
}