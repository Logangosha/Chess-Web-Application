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
                Chessboard chessboardData = (Chessboard)Session["Chessboard"];
                string serializedChessboardData = JsonConvert.SerializeObject(chessboardData);

                // Use RegisterClientScriptBlock to add the script block at the top of the page
                ClientScript.RegisterClientScriptBlock(this.GetType(), "ChessboardDataJson", $"var chessboardDataJson = {serializedChessboardData};", true);

                List<Player> playerData = (List<Player>)Session["Players"];
                PlayerOneImg.Src = PlayerAccount.GetImgSrc(playerData[0].ProfilePicture);
                PlayerTwoImg.Src = PlayerAccount.GetImgSrc(playerData[1].ProfilePicture);
            }
        }

        [WebMethod]
        public static void UpdateChessboardData(string coordinatesOfInitialSquare, string pieceAbreviationOnInitialSquare, string coordinatesOfTargetSquare)
        {
            try
            { 
            // Debuging code
            Debug.WriteLine("coordinatesOfInitialSquare: " + coordinatesOfInitialSquare);
            Debug.WriteLine("pieceAbreviationOnInitialSquare: " + pieceAbreviationOnInitialSquare);
            Debug.WriteLine("coordinatesOfTargetSquare: " + coordinatesOfTargetSquare);

            // Get chessboard data from session
            Chessboard chessboard = (Chessboard)HttpContext.Current.Session["Chessboard"];

            // convert parameters to objects
            Square initialSquare = new Square(coordinatesOfInitialSquare);
            Piece pieceOnInitialSquare = new Piece(pieceAbreviationOnInitialSquare);
            Square targetSquare = new Square(coordinatesOfTargetSquare);

            // Update chessboard data
            chessboard.UpdateChessboard(initialSquare, pieceOnInitialSquare, targetSquare);

            // Update session chessboard data
            HttpContext.Current.Session["Chessboard"] = chessboard;

            }
            catch (Exception e)
            {
                Debug.WriteLine("C# Error" +e.Message);
            }
        }
    }
}