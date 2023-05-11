using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Chess_App.Classes
{
    public class ChessPiece
    {
        /*Color property*/
        public bool Color { get; set; } //true = white, false = black
        /*If the peice has moved property*/
        public bool HasMoved { get; set; }
        /*If the peice has been captured property*/
        public bool Captured { get; set; }
        /*Position property*/
        public char[,] Position { get; set; }
        /*Possible Moves property*/
        public int[] PossibleMoves { get; set; }
        /*Piece type property*/
        public object PieceType { get; set; }
        /*Constructor*/
        public ChessPiece(bool color, char[,] position, object pieceType)
        {
            Color = color;
            Position = position;
            PieceType = pieceType;
            HasMoved = false;
            Captured = false;
        }
    }
}