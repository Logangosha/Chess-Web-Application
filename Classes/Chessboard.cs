using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Chess_App.Classes;

namespace Chess_App.Classes
{
    public class Chessboard
    {
        public string GameType { get; set; }
        public string TimeSettings { get; set; }
        public Player[] Players { get; set; }
        public List<ChessPiece> Pieces { get; set; }
        public ChessboardTiles[,] Tiles { get; set; }

        public Chessboard(string gameType, string timeSettings, Player[] players)
        {
            if (gameType == "Standard")
            {
                GameType = gameType;
                TimeSettings = timeSettings;
                Players = players;
                Pieces = CreatePieces(gameType);
                Tiles = new ChessboardTiles[8, 8];
            }
        }
        public List<ChessPiece> CreatePieces(string gameType) {
            List<ChessPiece> pieces = new List<ChessPiece>();
            if (gameType=="Standard")
            {
                // Create the pieces for the game
                // Create White Pieces
                for (char i = 'a'; i < 'h'; i++)
                {
                    pieces.Add(new ChessPiece(true, new char[i, 2], new Pawn()));
                    switch (i)
                    {
                        case 'a':
                            pieces.Add(new ChessPiece(true, new char[i, 1], new Rook()));
                            break;
                        case 'b':
                            pieces.Add(new ChessPiece(true, new char[i, 1], new Knight()));
                            break;
                        case 'c':
                            pieces.Add(new ChessPiece(true, new char[i, 1], new Bishop()));
                            break;
                        case 'd':
                            pieces.Add(new ChessPiece(true, new char[i, 1], new Queen()));
                            break;
                        case 'e':
                            pieces.Add(new ChessPiece(true, new char[i, 1], new King()));
                            break;
                        case 'f':
                            pieces.Add(new ChessPiece(true, new char[i, 1], new Bishop()));
                            break;
                        case 'g':
                            pieces.Add(new ChessPiece(true, new char[i, 1], new Knight()));
                            break;
                        case 'h':
                            pieces.Add(new ChessPiece(true, new char[i, 1], new Rook()));
                            break;
                    }
                }
                // Create Black Pieces
                for (char i = 'a'; i < 'h'; i++)
                {
                    pieces.Add(new ChessPiece(false, new char[i, 7], new Pawn()));
                    switch (i)
                    {
                        case 'a':
                            pieces.Add(new ChessPiece(false, new char[i, 8], new Rook()));
                            break;
                        case 'b':
                            pieces.Add(new ChessPiece(false, new char[i, 8], new Knight()));
                            break;
                        case 'c':
                            pieces.Add(new ChessPiece(false, new char[i, 8], new Bishop()));
                            break;
                        case 'd':
                            pieces.Add(new ChessPiece(false, new char[i, 8], new Queen()));
                            break;
                        case 'e':
                            pieces.Add(new ChessPiece(false, new char[i, 8], new King()));
                            break;
                        case 'f':
                            pieces.Add(new ChessPiece(false, new char[i, 8], new Bishop()));
                            break;
                        case 'g':
                            pieces.Add(new ChessPiece(false, new char[i, 8], new Knight()));
                            break;
                        case 'h':
                            pieces.Add(new ChessPiece(false, new char[i, 8], new Rook()));
                            break;
                    }
                }
            }
            return pieces;
        }
    }
}