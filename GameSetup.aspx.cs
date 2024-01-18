using Chess_App.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Chess_App
{
    public partial class GameSetup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["Type"] == null)
                {
                    Response.Redirect("Home.aspx");
                }
            }
        }

        protected void GoHomeBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }
        protected void GoBackBtn_Click(object sendar, EventArgs e)
        {
            Response.Redirect("GameSetup.aspx?type=Default");
        }
        protected void PlayChessBtn_Click(object sender, EventArgs e)
        {

            // make id for game data
            int id = 1;

            // get session account and create player
            // Get session account
            dynamic user = Session["AccountInfo"];
            // Create player
            Player currentPlayer = new Player(user, GameData.Color.White);

            // create testing account and player
            PlayerAccount testPlayerAccount = new PlayerAccount("TestAccount", "TestEmail", new byte[1][]);
            Player testPlayer = new Player(testPlayerAccount, GameData.Color.Black);

            // create list of players and add the two plyaers
            List<Player> players = new List<Player>
            {
                currentPlayer,
                testPlayer
            };
            // get type of game
            string type = Request.QueryString["Type"].ToString();
            // make Chessboard type standard
            Chessboard chessboard = new Chessboard(GameData.GameMode.Standard);
            // create history 
            MoveHistory gameHistory = new MoveHistory();
            //gameHistory.AddMove(new Move(0, GameData.Color.White, "placeholder"));
            // create new game data
            GameData gameData = new GameData(id, GameData.GameType.Online, GameData.GameState.Ongoing, players, chessboard, gameHistory);

            // add gameData to session 
            Response.Redirect("GamePage.aspx");
        }
        protected void GameSetup_Command(object sender, CommandEventArgs e)
        {
            switch (e.CommandArgument.ToString())
            {
                case "Online": Response.Redirect("GameSetup.aspx?type=" + e.CommandArgument + ""); break;
                case "Computer": Response.Redirect("GameSetup.aspx?type=" + e.CommandArgument + ""); break;
                case "Local":
                    PlayChessBtn_Click(sender, e); 
                    break;
                case "Default": Response.Redirect("GameSetup.aspx?type=" + e.CommandArgument + ""); break;
            }
        }

        [WebMethod]
        public static List<PlayerAccount> GetFriends() {
            List<PlayerAccount> playerAccounts = DatabaseAccess.GetFriends((HttpContext.Current.Session["AccountInfo"] as PlayerAccount).ID);
            return playerAccounts;
        }

    }
}