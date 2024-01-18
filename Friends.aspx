<%@ Page Language="C#" Title="Friends" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Friends.aspx.cs" Inherits="Chess_App.Friends" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid h-100">
        <div class="row p-0 justify-content-center h-100 MainCard overflow-scroll hidden-scroll-bar">
            <div class="d-flex flex-column gap-2 col-auto py-4 p-0 text-center justify-content-center my-auto align-items-center">
                <asp:LinkButton runat="server" ID="goHomeBtn" OnClick="goHomeBtn_Click" class="Btn Btn-link">
                    <i class="Btn-link-icon fa-solid fa-arrow-left"></i>
                    Go Home
                </asp:LinkButton>
                <h1 class=" h1-landing">FRIENDS</h1>
                <hr class="w-100 m-0" />
                <button type="button" class="Btn Btn-link" data-bs-toggle="modal" data-bs-target="#ChangeThemeModal">
                    <i class="Btn-link-icon fa-solid fa-users"></i>
                    Find New Friends
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </button>
                <hr class="w-100 m-0" />
                <div class="search-bar">
                    <input class="search-bar-input" id="SearchFriendsInp" autofocus="autofocus" type="text" placeholder="Search Friends" />
                    <button id="SearchFriendsBtn" class="Btn Btn-primary search-bar-Btn">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
                <div id="friendBoardDiv" class="friend-board">
                </div>
            </div>
        </div>
    </div>
    <!-- FindFriends -->
    <div class="modal fade" id="ChangeThemeModal" tabindex="-1" aria-labelledby="ChangeThemeModal" aria-hidden="true">
        <div class="modal-dialog modal-fullscreen">
            <div class="modal-content">
                <div class="modal-head">
                    <i class="fa-solid fa-users modal-icon my-auto"></i>
                    <h1 class="modal-title">Find New Friends
                    </h1>
                    <button type="button" onclick="CancleChangeTheme()" class="Btn Btn-secondary modal-close pe-0" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
                </div>
                <hr />
                <div class="modal-body gap-2">
                    <div class="row p-0 justify-content-center h-100 MainCard overflow-scroll hidden-scroll-bar">
                        <div class="col-auto py-4 p-0 justify-content-center align-items-center">
                            <h1 class=" h1-landing mb-2">SEARCH</h1>
                            <hr />
                            <div class="search-bar">
                                <input class="search-bar-input" id="SearchUsers" autofocus="autofocus" type="text" placeholder="Find Friends" />
                                <button type="button" class="Btn Btn-primary search-bar-Btn">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                            <div id="UserTilesPlaceholder" class="d-flex flex-column mt-2">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            $(document).ready(function () {
                getFriendsFromServer();
            });

            // SearchFriendsInp and SearchFriendsBtn event handler on keyup and click respectively
            $("#SearchFriendsInp").on("keyup", searchFriends);
            $("#SearchFriendsBtn").on("click", searchFriends);

            // SearchFriends function
            function searchFriends() {
                var friendBoardDiv = $("#friendBoardDiv"); 
                var searchText = $("#SearchFriendsInp").val(); // Get the current text from the search input
                // check to see if the friendBoardDiv children username contains the searchText
                friendBoardDiv.children().each(function () {
                    var friendName = $(this).children("p").text();
                    if (friendName.toLowerCase().includes(searchText.toLowerCase())) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                });
            }


            function getFriendsFromServer() {
                $.ajax({
                    type: "POST",
                    url: "Friends.aspx/GetFriends", // The name of the web method in the page
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response && response.d && Array.isArray(response.d)) {
                            console.log("Friends data received:", response.d);

                            // Clear the friendBoardDiv before updating with new data
                            $("#friendBoardDiv").empty();

                            // Loop through each friend in the response
                            response.d.forEach(function (friend) {
                                // Create a friend tile div element
                                var friendTile = $("<button>", {
                                    type:"button",
                                    class: "Btn friend",
                                    value: friend.Username,
                                });

                                // Create the image element
                                var image = $("<img>", {
                                    src: friend.ProfilePictureString,
                                });

                                // Create the paragraph element for the friend's name
                                var friendName = $("<p>").text(friend.Username);

                                // Create the status indicator element based on OnlineStatus
                                var statusIndicator = $("<span>", {
                                    class: "status-indicator " + (friend.OnlineStatus ? "online" : "offline"),
                                });

                                // Append the elements to the friendTile div
                                friendTile.append(image, friendName, statusIndicator);

                                //add button event 
                                friendTile.on("click", function () {
                                    var buttonValue = $(this).val();
                                    console.log("Button value:", buttonValue);
                                    // Initiate postback with the button value
                                    __doPostBack("FriendSelected", buttonValue);
                                });

                                // Append the friendTile to the friendBoardDiv
                                $("#friendBoardDiv").append(friendTile);
                            });
                            
                                // Create the div element with class "mt-5"
                                var mtDiv = $("<div>", {
                                    class: "mt-5",
                                });
                            $("#friendBoardDiv").append(mtDiv);

                        } else {
                            console.log("No friends data received.");
                        }
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.log("AJAX error. Status:", textStatus);
                        console.log("Error: " + errorThrown);
                    }
                });
            }


            var searchTimeout;

            function searchUsers() {
                clearTimeout(searchTimeout); // Clear the previous timeout

                var searchText = $("#SearchUsers").val(); // Get the current text from the search input

                // Set a new timeout to delay the AJAX request after a short interval (e.g., 500ms)
                searchTimeout = setTimeout(function () {
                    performSearch(searchText);
                }, 500); // Adjust the delay interval as needed
            }

            function performSearch(searchText) {
                console.log("Searching for: " + searchText);
                $.ajax({
                    type: "POST",
                    url: "Friends.aspx/SearchUsers",
                    data: JSON.stringify({ searchText: searchText }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        console.log("AJAX success. Response:", response);

                        if (response && response.d && Array.isArray(response.d) && response.d.length > 0) {
                            console.log("response.length = " + response.d.length);
                            var userTilesContainer = $("#UserTilesPlaceholder");
                            userTilesContainer.empty(); // Clear the container

                            for (var i = 0; i < response.d.length; i++) {
                                console.table(response.d[i]);
                                var account = response.d[i];
                                var tileStatusClass = account.OnlineStatus ? "online" : "offline";

                                var tile = $("<button>", {
                                    runat: "server",
                                    class: "Btn friend",
                                    value: account.Username,
                                });
                                var image = $("<img>", { src: account.ProfilePictureString });
                                var username = $("<p>").text(account.Username);
                                var statusIndicator = $("<span>", { class: "status-indicator " + tileStatusClass });

                                tile.append(image, username, statusIndicator);
                                userTilesContainer.append(tile);

                                tile.on("click", function () {
                                    var buttonValue = $(this).val();
                                    console.log("Button value:", buttonValue);
                                    // Initiate postback with the button value
                                    __doPostBack("SearchedUser", buttonValue);
                                });
                            }
                        } else {
                            console.log("No search results found.");
                        }
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.log("AJAX error. Status:", textStatus);
                        console.log("Error: " + errorThrown);
                    }
                });
            }

            // Attach event handler to search button click
            $(".search-bar-Btn").on("click", function () {
                var searchText = $("#SearchUsers").val(); // Get the current text from the search input
                performSearch(searchText);
            });

            // Attach event handler to input field keyup event
            $("#SearchUsers").on("keyup", function () {
                searchUsers();
            });
        </script>
    </div>
</asp:Content>
