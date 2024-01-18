using Chess_App.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Chess_App
{
    public class GameUpdateResponse
    {
        public TurnHandler TurnHandler { get; set; }
        public Chessboard Chessboard { get; set; }
        public List<PieceMoves> PossibleMoves { get; set; }
        public GameData.GameState CurrentGameState { get; set; }
        // Add more properties as needed
        public MoveHistory MoveHistory { get; set; }
    }
}