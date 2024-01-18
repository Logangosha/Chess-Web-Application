using Chess_App.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Web.Services;
using System.Diagnostics;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.Script.Serialization;
using System.Web.Services.Description;
using static Chess_App.GameData;

namespace Chess_App
{
    public partial class GamePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["GameData"] == null)
            {
                Response.Redirect("GameSetup.aspx");
            }
            if (!Page.IsPostBack)
            {
                GameData gameData = (GameData)Session["GameData"];
                Chessboard chessboardData = gameData.Chessboard;
                List<Player> playerData = gameData.Players;
                TurnHandler turnHandler = gameData.TurnHandler;
                List<PieceMoves> currentValidMoves = gameData.PossibleMoves;
                MoveHistory moveHistory = gameData.MoveHistory;
                GameData.GameState gameState = gameData.CurrentGameState;

                //PlayerOneImg.Src = PlayerAccount.GetImgSrc(playerData[0].ProfilePicture);
                //PlayerTwoImg.Src = PlayerAccount.GetImgSrc(playerData[1].ProfilePicture);

                string serializedPlayerData = JsonConvert.SerializeObject(playerData);
                string serializedChessboardData = JsonConvert.SerializeObject(chessboardData);
                string serializedTurnHandler = JsonConvert.SerializeObject(turnHandler);
                string serializedCurrentValidMoves = JsonConvert.SerializeObject(currentValidMoves);
                string serializedMoveHistory = JsonConvert.SerializeObject(moveHistory);
                string serializedCurrentGameState = JsonConvert.SerializeObject(gameState);

                // Use RegisterClientScriptBlock to add the script block at the top of the page
                ClientScript.RegisterClientScriptBlock(this.GetType(), "ChessboardDataJson", $"var chessboardDataJson = {serializedChessboardData};", true);
                ClientScript.RegisterClientScriptBlock(this.GetType(), "PlayerDataJson", $"var playerDataJson = {serializedPlayerData};", true);
                ClientScript.RegisterClientScriptBlock(this.GetType(), "TurnHandlerJson", $"var turnHandlerJson = {serializedTurnHandler};", true);
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CurrentValidMovesJson", $"var currentValidMovesJson = {serializedCurrentValidMoves};", true);
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CurrentGameStateJson", $"var currentGameStateJson = {serializedCurrentGameState};", true);
                ClientScript.RegisterClientScriptBlock(this.GetType(), "MoveHistoryJson", $"var moveHistoryJson = {serializedMoveHistory};", true);
            }
        }

        [WebMethod]
        public static GameUpdateResponse PlayerMoveEvent(string coordinatesOfInitialSquare, string pieceAbreviationOnInitialSquare, string coordinatesOfTargetSquare, string markee, string moveNotation)
        {
            try
            {
               return GameData.PlayerMoveEvent(coordinatesOfInitialSquare, pieceAbreviationOnInitialSquare, coordinatesOfTargetSquare, markee, moveNotation);
            }
            catch (Exception e)
            {
                Debug.WriteLine("C# Error " +e.Message);
                return null;
            }
        }

        [WebMethod]
        public static void KingCaptured()
        {
            try
            {
            }
            catch (Exception e)
            {
                Debug.WriteLine("C# Error " + e.Message);
            }
        }

        // make into web method
        [WebMethod]
        public static void Resign(string markee)
        {
            try
            {
                GameData gameData = (GameData)HttpContext.Current.Session["GameData"];
                gameData.CurrentGameState = GameState.GameOver;
                gameData.TurnHandler.Markee = markee;
                HttpContext.Current.Session["GameData"] = gameData;
            }
            catch (Exception e)
            {
                Debug.WriteLine("C# Error " + e.Message);
            }
        }

        protected void GoHomeBtn_Click(object sender, EventArgs e)
        {
            clearSession();
            Response.Redirect("Home.aspx");
        }

        protected void PlayAgainBtn_Click(object sender, EventArgs e)
        {
            clearSession();
            Response.Redirect("GameSetup.aspx?type=Default");
        }

        public void clearSession()
        {
            Session["GameData"] = null;
        }
    }
}