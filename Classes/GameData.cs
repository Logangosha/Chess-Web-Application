using Chess_App.Classes;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Chess_App
{
    public class GameData
    {
        public enum Color
        {
            White = 0, 
            Black = 1,
        }
        public enum GameMode
        {
            Standard = 0,
        }

        public enum GameType
        {
            Online = 0,
            Computer,
            Friend,
        }

        public enum GameState
        {
            // List of possible game states (e.g., Ongoing, Checkmate, Stalemate, Draw, etc.)
            Ongoing,
            Checkmate,
            Stalemate,
            Draw,
        }

        public int GameId { get; set; }
        public List<Player> Players { get; set; }
        public GameType OpponentType { get; set; }
        public GameState CurrentGameState { get; set; }
        public Chessboard Chessboard { get; set; }
        public MoveHistory MoveHistory { get; set; }

        public GameData(int gameId, GameType opponentType, GameState currentGameState, List<Player> players, Chessboard chessboard, MoveHistory moveHistory)
        {
            GameId = gameId;
            OpponentType = opponentType;
            CurrentGameState = currentGameState;
            Players = players;
            Chessboard = chessboard;
            MoveHistory = moveHistory;
            SetSessions(players, chessboard, moveHistory);
        }

        public void SetSessions(List<Player> players, Chessboard chessboard, MoveHistory moveHistory)
        {
            // Set session variables
            HttpContext.Current.Session["Players"] = players;
            HttpContext.Current.Session["Chessboard"] = chessboard;
            HttpContext.Current.Session["MoveHistory"] = moveHistory;
            HttpContext.Current.Session["GameData"] = this;
        }
    }
}