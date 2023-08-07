using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;

namespace Chess_App.Classes
{
    public class Game
    {
        public Player[] Players { get; set; }
        public string GameMode { get; set; }
        public string TimeSettings{ get; set; }
        public testboard Chessboard { get; set; }

        public Game(Player[] players, string gameMode, string timeSettings)
        {
            /*ALL OF THE INFORMATION IN THE GAME
            If the game is vs computer player or self
            what is the timer for the game
            who is black and white
            what type of game mode is it
            what are the names of the players
            what is the difficulty of the computer
            what is the name of the friend
            Chessboard
            */
            Players = players;
            GameMode = gameMode;
            TimeSettings = timeSettings;
            Chessboard = new testboard(gameMode, timeSettings, players);
        }
    }
}