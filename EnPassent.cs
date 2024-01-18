using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Chess_App
{
    public class EnPassent
    {
        public Coordinates EnPassentCoordinates { get; set; }
        public int TurnNumber { get; set; }
        public GameData.Color PieceColor { get; set; }
        public EnPassent(Coordinates enPassentCoordinates, int turnNumber, GameData.Color pieceColor)
        {
            EnPassentCoordinates = enPassentCoordinates;
            TurnNumber = turnNumber;
            PieceColor = pieceColor;
        }
    }
}