<%@ Page Language="C#" Title="Friends" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Friends.aspx.cs" Inherits="Chess_App.Friends" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid h-100">
        <div class="row p-0 justify-content-center h-100 MainCard overflow-scroll hidden-scroll-bar">
            <div class="d-flex flex-column gap-2 col-auto py-4 p-0 text-center justify-content-center my-auto align-items-center">

                <h1 class=" h1-landing">FRIENDS</h1>
                <hr class="w-100 m-0" />
                <button type="button" class="Btn Btn-link" data-bs-toggle="modal" data-bs-target="#ChangeThemeModal">
                    <i class="Btn-link-icon fa-solid fa-users"></i>
                    Find New Friends
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </button>
                <hr class="w-100 m-0" />
                <div class="search-bar">
                    <input class="search-bar-input" autofocus="autofocus" type="text" placeholder="Search Friends" />
                    <button class="Btn Btn-primary search-bar-Btn">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
                 <%--<asp:PlaceHolder runat="server" ID="FriendTilesPlaceholder"></asp:PlaceHolder>--%>
                <div class="Btn user-tile">
                    <img src="Images/whitehandmovingchesspiece.jpg" />
                    <p>Friend 1</p>
                    <span class="status-indicator offline"></span>
                </div>
                <div class="Btn user-tile">
                    <img src="Images/twomenplayingchessdarkroom.jpg" />
                    <p>Friend 2</p>
                    <span class="status-indicator"></span>
                </div>
                <div class="Btn user-tile offline">
                    <img src="Images/unclewiggly.png" />
                    <p>Friend 3</p>
                    <span class="status-indicator"></span>
                </div>
                <div class="Btn user-tile">
                    <img src="Images/untitled.png" />
                    <p>Friend 4</p>
                    <span class="status-indicator"></span>
                </div>
                <div class="Btn user-tile">
                    <img src="Images/whitehandmovingchesspiece.jpg" />
                    <p>Friend 1</p>
                    <span class="status-indicator"></span>
                </div>
                <div class="Btn user-tile">
                    <img src="Images/twomenplayingchessdarkroom.jpg" />
                    <p>Friend 2</p>
                    <span class="status-indicator"></span>
                </div>
                <div class="Btn user-tile">
                    <img src="Images/unclewiggly.png" />
                    <p>Friend 3</p>
                    <span class="status-indicator"></span>
                </div>
                <div class="mt-5"></div>
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
                         <div ID="UserTilesPlaceholder" class="d-flex flex-column gap-2 mt-2">

                         </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
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
                                    class: "Btn user-tile",
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
