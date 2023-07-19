<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Messages.aspx.cs" Inherits="Chess_App.Messages" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid h-100">
        <div class="row p-0 justify-content-center h-100 MainCard overflow-scroll hidden-scroll-bar">
            <div class="d-flex flex-column gap-2 col-auto py-4 p-0 text-center justify-content-center my-auto align-items-center">
                <h1 class=" h1-landing">MESSAGES</h1>
                <hr class="w-100 m-0" />
                <button type="button" class="Btn Btn-link" data-bs-toggle="modal" data-bs-target="#NewMessageModal">
                    <i class="Btn-link-icon fa-solid fa-envelope"></i>
                    New Message
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </button>
                <%-- button to open message dialoge modal --%>
                <button type="button" class="Btn Btn-link" data-bs-toggle="modal" data-bs-target="#MessageDialogeModal">
                    <i class="Btn-link-icon fa-solid fa-envelope"></i>
                    Open Message
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                    </button>
                <hr class="w-100 m-0" />
                <div class="search-bar">
                    <input class="search-bar-input" autofocus="autofocus" type="text" placeholder="Search Messages" />
                    <button class="Btn Btn-primary search-bar-Btn">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
                <button class="message-profile">
                    <div class="message-profile-body">
                        <div class="message-profile-heading">
                            <div class="status-indicator online">
                            </div>
                            <div class="username">
                                <h4>CoolGuy3</h4>
                            </div>
                            <div class="timestamp">
                                <p>12:34 AM</p>
                            </div>
                        </div>
                        <div class="message-profile-message">
                            <p class="message-text">Text me back!</p>
                        </div>
                    </div>
                    <img src="Images/whitehandmovingchesspiece.jpg" />
                </button>
                <button class="message-profile">
                    <div class="message-profile-body">
                        <div class="message-profile-heading">
                            <div class="status-indicator online">
                            </div>
                            <div class="username">
                                <h4>CoolGuy3</h4>
                            </div>
                            <div class="timestamp">
                                <p>12:34 AM</p>
                            </div>
                        </div>
                        <div class="message-profile-message">
                            <p class="message-text new-message">Text me back!</p>
                        </div>
                    </div>
                    <img src="Images/whitehandmovingchesspiece.jpg" />
                </button>
            </div>
        </div>
    </div>
    <%-- New Message Modal --%>
    <div class="modal fade" id="NewMessageModal" tabindex="-1" aria-labelledby="NewMessageModal" aria-hidden="true">
        <div class="modal-dialog modal-fullscreen">
            <div class="modal-content">
                <div class="modal-head">
                    <i class="fa-solid fa-envelope modal-icon my-auto"></i>
                    <h1 class="modal-title">New Message
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
                                <input class="search-bar-input" id="SearchUsers" autofocus="autofocus" type="text" placeholder="Search User" />
                                <button type="button" class="Btn Btn-primary search-bar-Btn">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                            <div id="UserTilesPlaceholder" class="d-flex flex-column gap-2 mt-2">
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
                    url: "Messages.aspx/SearchUsers",
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

                                // Attach event handler to tile click event
                                tile.on("click", function (event) {
                                    handleTileClick(event);
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

            function handleTileClick(event) {
                event.preventDefault(); // Prevent the default button behavior
                $("#NewMessageModal").modal("hide");
                $("#MessageDialogeModal").modal("show");
                // set the modal heading to the username of the clicked tile
                $("#MessageDialogeModalHeading").text(event.currentTarget.value);
                // TODO: Add code to load the messages between the current user and the clicked user and display them in the modal
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
    <%-- Message Dialoge Modal --%>
   <div class="modal fade" id="MessageDialogeModal" tabindex="-1" aria-labelledby="MessageDialogeModal" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen">
        <div class="modal-content">
            <div class="modal-head">
                <i class="fa-solid fa-user modal-icon my-auto"></i>
                <h1 id="MessageDialogeModalHeading" class="modal-title"></h1>
                <button type="button" onclick="CancleChangeTheme()" class="Btn Btn-secondary modal-close pe-0" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
            </div>
             <hr class="w-100 m-0" />
            <div class="modal-body mh-100 p-0">
                <div class="row p-0 justify-content-center h-100 MainCard overflow-scroll hidden-scroll-bar">
                    <div class="d-flex flex-column py-0 p-0 justify-content-center align-items-center">
                        <div class="message-dialoge">
                               
                             <div class="message user2">
                                <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>
                                    <p class="message-text">Do you want to play chess?</p>
                                    <p class="message-time"><b>Choblo</b> 12:34 AM</p>
                                </div>
                                <div class="message user1">
                                                                    <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>

                                    <p class="message-text">Hi Pumpkin</p>
                                    <p class="message-time"><b>Possum</b> 12:34 AM</p>
                               </div>
                            <div class="message user2">
                                <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>
                                    <p class="message-text">Do you want to play chess?</p>
                                    <p class="message-time"><b>Choblo</b> 12:34 AM</p>
                                </div>
                                <div class="message user1">
                                                                    <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>

                                    <p class="message-text">Hi Pumpkin</p>
                                    <p class="message-time"><b>Possum</b> 12:34 AM</p>
                               </div>
                            <div class="message user2">
                                <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>
                                    <p class="message-text">Do you want to play chess?</p>
                                    <p class="message-time"><b>Choblo</b> 12:34 AM</p>
                                </div>
                                <div class="message user1">
                                                                    <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>

                                    <p class="message-text">Hi Pumpkin</p>
                                    <p class="message-time"><b>Possum</b> 12:34 AM</p>
                               </div><div class="message user2">
                                <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>
                                    <p class="message-text">Do you want to play chess?</p>
                                    <p class="message-time"><b>Choblo</b> 12:34 AM</p>
                                </div>
                                <div class="message user1">
                                                                    <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>

                                    <p class="message-text">Hi Pumpkin</p>
                                    <p class="message-time"><b>Possum</b> 12:34 AM</p>
                               </div><div class="message user2">
                                <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>
                                    <p class="message-text">Do you want to play chess?</p>
                                    <p class="message-time"><b>Choblo</b> 12:34 AM</p>
                                </div>
                                <div class="message user1">
                                                                    <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>

                                    <p class="message-text">Hi Pumpkin</p>
                                    <p class="message-time"><b>Possum</b> 12:34 AM</p>
                               </div><div class="message user2">
                                <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>
                                    <p class="message-text">Do you want to play chess?</p>
                                    <p class="message-time"><b>Choblo</b> 12:34 AM</p>
                                </div>
                                <div class="message user1">
                                                                    <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>

                                    <p class="message-text">Hi Pumpkin</p>
                                    <p class="message-time"><b>Possum</b> 12:34 AM</p>
                               </div><div class="message user2">
                                <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>
                                    <p class="message-text">Do you want to play chess?</p>
                                    <p class="message-time"><b>Choblo</b> 12:34 AM</p>
                                </div>
                                <div class="message user1">
                                                                    <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>

                                    <p class="message-text">Hi Pumpkin</p>
                                    <p class="message-time"><b>Possum</b> 12:34 AM</p>
                               </div><div class="message user2">
                                <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>
                                    <p class="message-text">Do you want to play chess?</p>
                                    <p class="message-time"><b>Choblo</b> 12:34 AM</p>
                                </div>
                                <div class="message user1">
                                                                    <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>

                                    <p class="message-text">Hi Pumpkin</p>
                                    <p class="message-time"><b>Possum</b> 12:34 AM</p>
                               </div><div class="message user2">
                                <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>
                                    <p class="message-text">Do you want to play chess?</p>
                                    <p class="message-time"><b>Choblo</b> 12:34 AM</p>
                                </div>
                                <div class="message user1">
                                                                    <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>

                                    <p class="message-text">Hi Pumpkin</p>
                                    <p class="message-time"><b>Possum</b> 12:34 AM</p>
                               </div><div class="message user2">
                                <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>
                                    <p class="message-text">Do you want to play chess?</p>
                                    <p class="message-time"><b>Choblo</b> 12:34 AM</p>
                                </div>
                                <div class="message user1">
                                                                    <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>

                                    <p class="message-text">Hi Pumpkin</p>
                                    <p class="message-time"><b>Possum</b> 12:34 AM</p>
                               </div><div class="message user2">
                                <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>
                                    <p class="message-text">Do you want to play chess?</p>
                                    <p class="message-time"><b>Choblo</b> 12:34 AM</p>
                                </div>
                                <div class="message user1">
                                                                    <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>

                                    <p class="message-text">Hi Pumpkin</p>
                                    <p class="message-time"><b>Possum</b> 12:34 AM</p>
                               </div><div class="message user2">
                                <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>
                                    <p class="message-text">Do you want to play chess?</p>
                                    <p class="message-time"><b>Choblo</b> 12:34 AM</p>
                                </div>
                                <div class="message user1">
                                                                    <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>

                                    <p class="message-text">Hi Pumpkin</p>
                                    <p class="message-time"><b>Possum</b> 12:34 AM</p>
                               </div><div class="message user2">
                                <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>
                                    <p class="message-text">Do you want to play chess?</p>
                                    <p class="message-time"><b>Choblo</b> 12:34 AM</p>
                                </div>
                                <div class="message user1">
                                                                    <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>

                                    <p class="message-text">Hi Pumpkin</p>
                                    <p class="message-time"><b>Possum</b> 12:34 AM</p>
                               </div><div class="message user2">
                                <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>
                                    <p class="message-text">Do you want to play chess?</p>
                                    <p class="message-time"><b>Choblo</b> 12:34 AM</p>
                                </div>
                                <div class="message user1">
                                                                    <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>

                                    <p class="message-text">Hi Pumpkin</p>
                                    <p class="message-time"><b>Possum</b> 12:34 AM</p>
                               </div><div class="message user2">
                                <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>
                                    <p class="message-text">Do you want to play chess?</p>
                                    <p class="message-time"><b>Choblo</b> 12:34 AM</p>
                                </div>
                                <div class="message user1">
                                                                    <img src="Images/twomenplayingchessdarkroom.jpg" style="width:4rem;height:4rem;object-fit: cover; border-radius:4px;"/>

                                    <p class="message-text">Hi Pumpkin</p>
                                    <p class="message-time"><b>Possum</b> 12:34 AM</p>
                               </div>

                        </div>
                    </div>
                </div>
            </div>
            <hr />
            <div class="modal-footer">
                <div class="message-prompt">
                    <input placeholder="Enter Message . . ." />
                    <button type="button" class="Btn Btn-primary">
                        <i class="fas fa-message"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
</asp:Content>
