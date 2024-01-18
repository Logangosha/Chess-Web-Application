using Chess_App.Classes;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using static Chess_App.Classes.Chessboard;

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
            GameOver,
        }
        public int GameId { get; set; }
        public List<Player> Players { get; set; }
        public GameType OpponentType { get; set; }
        public GameState CurrentGameState { get; set; }
        public Chessboard Chessboard { get; set; }
        public List<PieceMoves> PossibleMoves { get; set; }
        public MoveHistory MoveHistory { get; set; }
        public TurnHandler TurnHandler { get; set; }
        public GameData(int gameId, GameType opponentType, GameState currentGameState, List<Player> players, Chessboard chessboard, MoveHistory moveHistory)
        {
            GameId = gameId;
            OpponentType = opponentType;
            CurrentGameState = currentGameState;
            Players = players;
            Chessboard = chessboard;
            MoveHistory = moveHistory;
            TurnHandler = new TurnHandler();
            PossibleMoves = GetInitialPossibleWhiteMoves();
            SetSessions(players, chessboard, moveHistory);
        }
        public void SetSessions(List<Player> players, Chessboard chessboard, MoveHistory moveHistory)
        {
            // Set session variables
            HttpContext.Current.Session["Players"] = players;
            HttpContext.Current.Session["Chessboard"] = chessboard;
            HttpContext.Current.Session["MoveHistory"] = moveHistory;
            HttpContext.Current.Session["TurnHandler"] = TurnHandler;
            HttpContext.Current.Session["PossibleMoves"] = PossibleMoves;
            HttpContext.Current.Session["GameData"] = this;
        }

        public static void SetSessions(Chessboard chessboard, MoveHistory moveHistory, TurnHandler turnHandler, List<PieceMoves> possibleMoves, GameData.GameState gameState)
        {
            // Set session variables
            GameData currentGameData = (GameData)HttpContext.Current.Session["GameData"];
            HttpContext.Current.Session["Chessboard"] = chessboard;
            HttpContext.Current.Session["MoveHistory"] = moveHistory;
            HttpContext.Current.Session["TurnHandler"] = turnHandler;
            HttpContext.Current.Session["PossibleMoves"] = possibleMoves;
            currentGameData.Chessboard= chessboard;
            currentGameData.MoveHistory = moveHistory;
            currentGameData.TurnHandler = turnHandler;
            currentGameData.PossibleMoves = possibleMoves;
            currentGameData.CurrentGameState = gameState;
            HttpContext.Current.Session["GameData"] = currentGameData;
        }

        public List<PieceMoves> GetInitialPossibleWhiteMoves()
        {
            if (Chessboard.CurrentGameMode == GameMode.Standard) // Assuming you want to check if the opponent type is standard
            {
                List<PieceMoves> possibleMovesList = new List<PieceMoves>();

                // Pawns
                for (int i = 0; i < 8; i++)
                {
                    possibleMovesList.Add(new PieceMoves()
                    {
                        PieceCoordinates = new Coordinates((Row)1, (Column)i),
                        PossibleMoveCoordinates = new List<Coordinates>()
                        {
                            new Coordinates((Row)2,(Column)i),
                            new Coordinates((Row)3,(Column)i),
                        }
                    });
                }
                // Knights
                for (int i = 0; i < 2; i++)
                {
                    possibleMovesList.Add(new PieceMoves()
                    {
                        PieceCoordinates = new Coordinates((Row)0, (Column)(1 + (i * 5))),
                        PossibleMoveCoordinates = new List<Coordinates>()
                        {
                            new Coordinates((Row)2, (Column)((i * 5))),
                            new Coordinates((Row)2, (Column)(2 + (i * 5))),
                        }
                    });
                }
                return possibleMovesList;
            }
            return null;
        }
        public static GameUpdateResponse PlayerMoveEvent(string coordinatesOfInitialSquare, string pieceAbreviationOnInitialSquare, string coordinatesOfTargetSquare, string markee, string moveNotation)
        {
            // *** make sure move is legal 
            // check if move is valid if not throw exception
            if (!IsMoveValid(coordinatesOfInitialSquare, coordinatesOfTargetSquare))
                throw new Exception("invalid move");

            // *** update chessboard data
            Chessboard chessboard = UpdateChesboard(coordinatesOfInitialSquare, pieceAbreviationOnInitialSquare, coordinatesOfTargetSquare);

            // update move history
            MoveHistory moveHistory = UpdateMoveHistory(moveNotation);

            // *** change turn
            //Update turnHandler data
            TurnHandler turnHandler = UpdateTurnHandler();

            // Update markee
            turnHandler.SetMarkee(markee);

            // *** update possible moves
            List<PieceMoves> possibleMoves = UpdatePossibleMoves(chessboard, turnHandler.CurrentColorTurn);

            

            // *** check if king as captured and set gameState accordingly
            GameState gameState = GameState.Ongoing;
            if (chessboard.IsKingCaptured)
                gameState = GameState.GameOver;

            // update gamedata session variable
            SetSessions(chessboard, moveHistory, turnHandler, possibleMoves, gameState);

            // *** update game history
            GameUpdateResponse response = new GameUpdateResponse
            {
                TurnHandler = turnHandler,
                Chessboard = chessboard,
                PossibleMoves = possibleMoves,
                CurrentGameState = gameState,
                MoveHistory = moveHistory
            };

            // Return the response
            return response;
        }
        public static List<PieceMoves> GetPossibleMoves(Chessboard chessboard, GameData.Color currentColorTurn)
        {
            // get list of squares that have a piece on them the color of current color turn
            List<Square> squareWithPlayerPieces = GetSquaresWithPlayerPieces(chessboard, currentColorTurn);

            List<PieceMoves> possibleMoves = new List<PieceMoves>();
            for (int i = 0; i < squareWithPlayerPieces.Count; i++)
            {
                possibleMoves.Add(GetPieceMoves(squareWithPlayerPieces[i], chessboard));
            }
            return possibleMoves;
        }

        public static bool IsKingCastlingThoughCheck(Chessboard chessboard, GameData.Color nextColorTurn, List<Coordinates> castleCoordinates)
        {
            List<Square> squareWithPlayerPieces = GetSquaresWithPlayerPieces(chessboard, nextColorTurn);
            PieceMoves pieceMoves;

            foreach (Square square in squareWithPlayerPieces)
            {
                pieceMoves = GetPieceMoves(square, chessboard);
                foreach (Coordinates castleCoord in castleCoordinates)
                {
                    foreach (Coordinates PossibleCoordinates in pieceMoves.PossibleMoveCoordinates)
                    { 
                        if (PossibleCoordinates.CoordinateString == castleCoord.CoordinateString)
                        {
                            // A matching move is found, return true
                            return true;
                        }
                    }
                }
            }
            // No matching move found, return false
            return false;
        }

        public static List<Square> GetSquaresWithPlayerPieces(Chessboard chessboard, GameData.Color currentColorTurn)
        {
            // create List<Square> 
            List<Square> squaresWithPlayerPieces = new List<Square>();
            Square square = null;
            // loop though each row in chessboard.board
            for (int row = 0; row < 8; row++)
            {
                for (int col = 0; col < 8; col++)
                {
                    square = chessboard.Board[row, col];
                    if (square.Piece != null && square.Piece.Color == currentColorTurn)
                    {
                        
                        squaresWithPlayerPieces.Add(chessboard.Board[row, col]);
                    }
                }
            }
            return squaresWithPlayerPieces;
        }
        public static PieceMoves GetPieceMoves(Square square, Chessboard chessboard)
        {
            PieceMoves possibleMovesForPiece = new PieceMoves();
            possibleMovesForPiece.PieceCoordinates = square.Coordinates;

            switch (square.Piece.Type)
            {
                case Piece.PieceType.Pawn:
                    possibleMovesForPiece.PossibleMoveCoordinates = Piece.GetPawnMoves(square, chessboard);
                    break;
                case Piece.PieceType.Knight:
                    possibleMovesForPiece.PossibleMoveCoordinates = Piece.GetKnightMoves(square, chessboard);
                    break;
                case Piece.PieceType.Bishop:
                    possibleMovesForPiece.PossibleMoveCoordinates = Piece.GetBishopMoves(square, chessboard);
                    break;
                case Piece.PieceType.Rook:
                    possibleMovesForPiece.PossibleMoveCoordinates = Piece.GetRookMoves(square, chessboard);
                    break;
                case Piece.PieceType.Queen:
                    possibleMovesForPiece.PossibleMoveCoordinates = Piece.GetQueenMoves(square, chessboard);
                    break;
                case Piece.PieceType.King:
                    possibleMovesForPiece.PossibleMoveCoordinates = Piece.GetKingMoves(square, chessboard);
                    break;
                default:
                    break;
            }

            return possibleMovesForPiece;
        }
        public static bool IsMoveValid(string coordinatesOfInitialSquare, string coordinatesOfTargetSquare)
        {
            // get list of possible moves
            List<PieceMoves> PossibleMoves = (List<PieceMoves>)HttpContext.Current.Session["PossibleMoves"];

            // get col and row of inital square 
            Chessboard.Column initalColumn = Square.ConvertCharacterToColumn(coordinatesOfInitialSquare[0]);
            Chessboard.Row initialRow = Square.ConvertCharacterToRow(coordinatesOfInitialSquare[1]);

            // get col and row of target 
            Chessboard.Column targetColumn = Square.ConvertCharacterToColumn(coordinatesOfTargetSquare[0]);
            Chessboard.Row targetRow = Square.ConvertCharacterToRow(coordinatesOfTargetSquare[1]);


            // check if targetSquare coordinates are in Possible moves
            for (int i = 0; i < PossibleMoves.Count; i++)
            {
                for (int j = 0; j < PossibleMoves[i].PossibleMoveCoordinates.Count; j++)
                {
                    // check if they are the same
                    if (targetColumn == PossibleMoves[i].PossibleMoveCoordinates[j].Column && targetRow == PossibleMoves[i].PossibleMoveCoordinates[j].Row && initalColumn == PossibleMoves[i].PieceCoordinates.Column && initialRow == PossibleMoves[i].PieceCoordinates.Row)
                    {
                        return true;
                    }
                }
            }
            return false;
        }
        public static Chessboard UpdateChesboard(string coordinatesOfInitialSquare, string pieceAbreviationOnInitialSquare, string coordinatesOfTargetSquare)
        {
            // Get chessboard data from session
            Chessboard chessboard = (Chessboard)HttpContext.Current.Session["Chessboard"];

            // convert parameters to objects
            Square initialSquare = new Square(coordinatesOfInitialSquare);
            Piece pieceOnInitialSquare = new Piece(pieceAbreviationOnInitialSquare);
            Square targetSquare = new Square(coordinatesOfTargetSquare);
            Piece targetSquarePiece = chessboard.Board[(int)targetSquare.Row, (int)targetSquare.Column].Piece;
            targetSquare.Piece = targetSquarePiece;

            // Update chessboard data
            chessboard.UpdateChessboard(initialSquare, pieceOnInitialSquare, targetSquare, ((TurnHandler)HttpContext.Current.Session["TurnHandler"]).CurrentTurn);

            // Update session chessboard data
            HttpContext.Current.Session["Chessboard"] = chessboard;

            return chessboard;
        }
        public static TurnHandler UpdateTurnHandler()
        {
            try
            {
                // Get turnHandler data from session
                TurnHandler turnHandler = (TurnHandler)HttpContext.Current.Session["TurnHandler"];

                // Update turnHandler data

                // ChangeTurn 
                turnHandler.ChangeTurn();

                // Update session chessboard data
                HttpContext.Current.Session["TurnHandler"] = turnHandler;
                return turnHandler;

            }
            catch (Exception e)
            {
                Debug.WriteLine("C# Error" + e.Message);
                return null;
            }
        }
        public static MoveHistory UpdateMoveHistory(string moveNotation)
        {
            try
            {
                // Get moveHistory data from session
                MoveHistory moveHistory = (MoveHistory)HttpContext.Current.Session["MoveHistory"];
                // get turnHandler data from session
                TurnHandler turnHandler = (TurnHandler)HttpContext.Current.Session["TurnHandler"];
                Move move = new Move(turnHandler.CurrentTurn, turnHandler.CurrentColorTurn, moveNotation);
                moveHistory.AddMove(move);
                // Update session chessboard data
                HttpContext.Current.Session["MoveHistory"] = moveHistory;
                return moveHistory;

            }
            catch (Exception e)
            {
                Debug.WriteLine("C# Error" + e.Message);
                return null;
            }
        }
        public static List<PieceMoves> UpdatePossibleMoves(Chessboard chessboard, GameData.Color currentColorTurn)
        {
            List<PieceMoves> PossibleMoves = GetPossibleMoves(chessboard, currentColorTurn);
            HttpContext.Current.Session["PossibleMoves"] = PossibleMoves;
            return PossibleMoves;
        }
    }
}