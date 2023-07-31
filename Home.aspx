<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Chess_App.Home" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="user-content overflow-scroll ">
        <div class="user-control-pannel">
            <%
                if (UsingAccount)
                {%>
            <asp:LinkButton runat="server" ID="AccountBtn" OnClick="AccountBtn_Click" type="button" class="Btn Btn-icon Btn-primary">
                <img src="<%=(HttpContext.Current.Session["AccountInfo"] as Chess_App.PlayerAccount).ProfilePictureString %>" class="profile-img" /></asp:LinkButton>
            <%}
                else
                {%>
            <button text="Modal" type="button" class="Btn Btn-icon Btn-primary d-lg-inline-block" data-bs-toggle="modal" data-bs-target="#AccountsOnlyModal">
                <img src="<%=(HttpContext.Current.Session["AccountInfo"] as Chess_App.Guest).ProfilePictureString %>" class="profile-img" /></button>

            <%}%>
            <%
                if (UsingAccount)
                {%><asp:LinkButton runat="server" ID="FriendsBtn" OnClick="FriendsBtn_Click" type="button" class="Btn Btn-icon Btn-primary"><i class="fa fa-users"></i></asp:LinkButton><% }
                                                                                                                                                                                            else
                                                                                                                                                                                            {%>
            <button text="Modal" type="button" class="Btn Btn-icon Btn-primary d-lg-inline-block" data-bs-toggle="modal" data-bs-target="#AccountsOnlyModal"><i class="fa fa-users"></i></button>
            <% }
            %>

            <%
                if (UsingAccount)
                {%><asp:LinkButton runat="server" ID="MessageBtn" OnClick="MessageBtn_Click" type="button" class="Btn Btn-icon Btn-primary"><i class="fa fa-message"></i></asp:LinkButton><% }
                                                                                                                                                                                              else
                                                                                                                                                                                              {%>
            <button text="Modal" type="button" class="Btn Btn-icon Btn-primary" data-bs-toggle="modal" data-bs-target="#AccountsOnlyModal"><i class="fa fa-message"></i></button>
            <% }
            %>
            <asp:LinkButton runat="server" ID="GameSetupBtn" CommandArgument="Default" OnCommand="GameSetup_Command" type="button" class="Btn Btn-icon Btn-primary d-inline-block"><i class="fa-solid fa-chess-board"></i></asp:LinkButton>

        </div>

        <div class="user-content-pannel">
            <div id="WelcomeSection" class="section">
                <div id="WelcomeSectionBackground" class="section-background"></div>
                <div class="section-content">
                    <button type="button" class="Btn Btn-notification">
                        <i class="Btn-notification-icon fa-regular fa-face-smile-beam"></i>
                        <%if (UsingAccount)
                            {%>
                        <p class="Btn-notification-text">Welcome <%= (HttpContext.Current.Session["AccountInfo"] as Chess_App.PlayerAccount).Username %>!</p>
                        <%}
                            else
                            {%>
                        <p class="Btn-notification-text">Welcome Guest!</p>
                        <%} %>
                        <i class="fa-solid fa-xmark Btn-notification-close"></i>
                    </button>
                </div>
            </div>
            <div id="PlayChessSection" class="section">
                <div id="PlayChessSectionBackground" class="section-background"></div>
                <div class="section-content button-content">
                    <asp:LinkButton runat="server" CssClass="Btn Btn-square-icon">
                        <i class="fa-solid fa-globe"></i>                        
                        <p>Play Online</p>
                    </asp:LinkButton>
                    <asp:LinkButton runat="server" CssClass="Btn Btn-square-icon">
                        <i class="fa-solid fa-desktop"></i>                        
                        <p>Play Computer</p>
                    </asp:LinkButton>
                    <asp:LinkButton runat="server" CssClass="Btn Btn-square-icon">
                        <i class="fa-solid fa-user-group"></i>                        
                        <p>Play Friend</p>
                    </asp:LinkButton>
                </div>
            </div>
            <%if (UsingAccount)
                {%>
            <div id="AccountButtonsSections" class="section">
                <div class="section-background"></div>
                <div class="section-content button-content">
                    <asp:LinkButton runat="server" CssClass="Btn Btn-square-icon">
                        <i class="fa-regular fa-id-card"></i>                        
                        <p>Edit Account</p>
                    </asp:LinkButton>
                    <asp:LinkButton runat="server" CssClass="Btn Btn-square-icon">
                        <i class="fa-solid fa-envelope"></i>                        
                        <p>Send Message</p>
                    </asp:LinkButton>
                    <asp:LinkButton runat="server" CssClass="Btn Btn-square-icon">
                        <i class="fa-solid fa-users"></i>                        
                        <p>View Friends</p>
                    </asp:LinkButton>
                </div>
            </div>
            <!-- Inside the "FriendsSection" -->
            <div id="FriendsSection" class="section">
                <!-- ... Your existing code ... -->
                <div class="section-content">
                    <div class="friends-table">
                        <div class="table-row header-row">
                            <div class="table-cell">Friend Name</div>
                            <div class="table-cell">Status</div>
                            <!-- Add more headers as needed -->
                        </div>
                        <!-- Add initial table rows and data as needed -->
                        <div class="table-row">
                            <div class="table-cell">John Doe</div>
                            <div class="table-cell">Online</div>
                        </div>
                        <div class="table-row">
                            <div class="table-cell">Jane Smith</div>
                            <div class="table-cell">Offline</div>
                        </div>
                        <div class="table-row">
                            <div class="table-cell">John Doe</div>
                            <div class="table-cell">Online</div>
                        </div>
                        <div class="table-row">
                            <div class="table-cell">Jane Smith</div>
                            <div class="table-cell">Offline</div>
                        </div>

                        <!-- Add more rows as needed -->
                    </div>
                </div>
            </div>
            <!-- Inside the "MessagesSection" -->
            <!-- Inside the "MessagesSection" -->
            <div id="MessagesSection" class="section">
                <!-- ... Your existing code ... -->
                <div class="section-content">
                    <div class="messages-table">
                        <div class="table-row header-row">
                            <div class="table-cell">Sender</div>
                            <div class="table-cell">Message</div>
                            <!-- Add more headers as needed -->
                        </div>
                        <!-- Add initial table rows and data as needed -->
                        <div class="table-row">
                            <div class="table-cell">John Doe</div>
                            <div class="table-cell">Hello, how are you?</div>
                        </div>
                        <div class="table-row">
                            <div class="table-cell">Jane Smith</div>
                            <div class="table-cell">I'm doing well, thank you!</div>
                        </div>
                        <div class="table-row">
                            <div class="table-cell">John Doe</div>
                            <div class="table-cell">Hello, how are you?</div>
                        </div>
                        <div class="table-row">
                            <div class="table-cell">Jane Smith</div>
                            <div class="table-cell">I'm doing well, thank you!</div>
                        </div>
                        <!-- Add more rows as needed -->
                    </div>
                </div>
            </div>
            <%--<div id="UserAccountSection" class="section">
                <div id="UserAccountSectionBackground" class="section-background"></div>
                <div class="section-content">
                </div>
            </div>
            <div id="ChangeThemeSection" class="section">
                <div id="ChangeThemeSectionBackground" class="section-background"></div>
                <div class="section-content">
                    <div class="change-theme">
                    </div>
                </div>
            </div>--%>
            <%}

                else
                {%>
            <div id="CreateAccountSection" class="section">
                <div id="CreateAccountSectionBackground" class="section-background"></div>
                <div class="section-content">
                    <button type="button" class="Btn Btn-link">
                    <i class="Btn-link-icon fa-solid fa-circle-exclamation"></i>
                    <p class="Btn-link-text">Create an Account!</p>
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </button>
                </div>
            </div>
            <div id="LoginSection" class="section">
                <div id="LoginSectionBackground" class="section-background"></div>
                <div class="section-content">
                     <button type="button" class="Btn Btn-link">
                    <i class="Btn-link-icon fa-regular fa-circle-question"></i>
                    <p class="Btn-link-text">Have an account?</p>
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </button>
                </div>
            </div>
           <%-- <div id="AccountsOnlySection" class="section">
                <div id="AccountsOnlySectionBackground" class="section-background"></div>
                <div class="section-content">
                  <button class="Btn Btn-primary overlay-button">
                      <b>CREATE ACCOUNT</b> OR <b>LOGIN</b><br />TO ACCESS
                  </button>
                    <img src="Images/accountsonly.gif" class="blurred-image"/>
                </div>

            </div>--%>
            <%}%>

        </div>

    </div>
    <div class="modal fade" id="AccountsOnlyModal" tabindex="-1" aria-labelledby="AccountsOnlyModal" aria-hidden="true">
        <div class="modal-dialog  modal-fullscreen">
            <div class="modal-content">
                <div class="modal-head">
                    <i class="fa-solid fa-warning modal-icon my-auto"></i>
                    <h1 class="modal-title">Account Needed
                    </h1>
                    <button type="button" class="Btn Btn-secondary modal-close pe-0" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
                </div>
                <hr />
                <div class="modal-body my-auto gap-2">
                    <span class="modal-icon fa fa-warning"></span>
                    <h1 class="modal-heading">LOGIN</h1>
                    <h2 class="modal-subheading">To continue you will need to<b> Login</b></h2>
                </div>
                <hr />
                <div class="modal-footer">
                    <button type="button" class="Btn Btn-secondary ps-0" data-bs-dismiss="modal">Cancle</button>
                    <asp:Button runat="server" ID="ModalLoginBtn" OnClick="ModalLoginBtn_Click" type="button" class="Btn Btn-primary ms-auto" Text="Login"></asp:Button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>


