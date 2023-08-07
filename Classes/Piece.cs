using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Chess_App.Classes
{
    public class Piece
    {
        public enum PieceType
        {
            Pawn = 0,
            Rook,
            Knight,
            Bishop,
            Queen,
            King
        }
        public PieceType Type { get; set; }
        public GameData.Color Color { get; set; }


        public Piece(PieceType type, GameData.Color color)
        {
            Type = type;
            Color = color;
        }

        // constructor overload for pawn from css class
        public Piece(string cssClass)
        {
            Color = ConvertCharacterToColor(cssClass[0]);
            Type = ConvertCharacterToPiece(cssClass[1]);
        }

        public PieceType ConvertCharacterToPiece(char character)
        {
            switch (character)
            {
                case 'p': return PieceType.Pawn; 
                case 'r': return PieceType.Rook;
                case 'n': return PieceType.Knight;
                case 'b': return PieceType.Bishop;
                case 'q': return PieceType.Queen;
                case 'k': return PieceType.King;
                default: return PieceType.Pawn;
            }
        }
        public GameData.Color ConvertCharacterToColor(char character)
        {
            switch (character)
            {
                case 'w': return GameData.Color.White;
                case 'b': return GameData.Color.Black;
                default: return GameData.Color.White;
            }
        }
    }
}