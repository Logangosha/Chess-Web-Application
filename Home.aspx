<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Chess_App.Home" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex flex-lg-row flex-column h-100 p-0 m-0">
        <div class="col-12 col-lg-4 user-control-pannel">
            <div class="row user-control-pannel-nav align-items-center text-center">
                <div class="col">
                    <asp:LinkButton runat="server" ID="AccountBtn" OnClick="AccountBtn_Click" type="button" class="Btn Btn-icon Btn-primary"><i class="fa fa-user"></i></asp:LinkButton>
                </div>
                <div class="col">
                    <%
                        if (UsingAccount)
                        {%><asp:LinkButton runat="server" ID="FriendsBtn" OnClick="FriendsBtn_Click" type="button" class="Btn Btn-icon Btn-primary d-none d-lg-inline-block"><i class="fa fa-users"></i></asp:LinkButton><% }
                                                              else
                                                              {%>
                    <button text="Modal" type="button" class="Btn Btn-icon Btn-primary d-none d-lg-inline-block" data-bs-toggle="modal" data-bs-target="#AccountsOnlyModal"><i class="fa fa-users"></i></button>
                    <% }
                    %>

                    <asp:LinkButton runat="server" ID="GameSetupBtn" CommandArgument="Default" OnCommand="GameSetup_Command" type="button" class="Btn Btn-icon Btn-primary d-inline-block d-lg-none"><i class="fa-solid fa-chess-board"></i></asp:LinkButton>
                </div>
                <div class="col">
                    <%
                        if (UsingAccount)
                        {%><asp:LinkButton runat="server" ID="MessageBtn" OnClick="MessageBtn_Click" type="button" class="Btn Btn-icon Btn-primary"><i class="fa fa-message"></i></asp:LinkButton><% }
                                                              else
                                                              {%>
                    <button text="Modal" type="button" class="Btn Btn-icon Btn-primary" data-bs-toggle="modal" data-bs-target="#AccountsOnlyModal"><i class="fa fa-message"></i></button>
                    <% }
                    %>
                </div>
            </div>
            <div class="d-flex flex-column justify-content-start p-5 hidden-scroll-bar overflow-auto user-control-pannel-body">
                <div class="d-flex flex-column gap-4 justify-content-center">
                    <h1 class="py-3">Play Chess!</h1>
                    <asp:LinkButton runat="server" id="PlayOnlineBtn" CommandArgument="Online" OnCommand="GameSetup_Command"  CssClass="Btn Btn-primary user-control-pannel-body-btn-text w-100"><span class="user-control-pannel-body-btn-icon fa fa-globe"></span><span class="text-wrap">&nbsp;Play Online</span></asp:LinkButton>
                    <asp:LinkButton runat="server" id="PlayComputereBtn" CommandArgument="Computer" OnCommand="GameSetup_Command" CssClass="Btn Btn-primary user-control-pannel-body-btn-text w-100"><span class="user-control-pannel-body-btn-icon fa fa-computer"></span><span class="text-wrap">&nbsp;Play Computer</span></asp:LinkButton>
                    <asp:LinkButton runat="server" id="PlayFriendBtn" CommandArgument="Friends" OnCommand="GameSetup_Command" CssClass="Btn Btn-primary user-control-pannel-body-btn-text w-100"><span class="user-control-pannel-body-btn-icon fa fa-user"></span><span class="text-wrap">&nbsp;Play Friends</span></asp:LinkButton>
                </div>
                <div class="d-flex mt-auto pt-4 flex-column gap-3">
                    <hr />
                    <button type="button" class="Btn Btn-link"  data-bs-toggle="modal" data-bs-target="#ChangeThemeModal">
                        <i class="Btn-link-icon fa-solid fa-palette"></i>
                        Change Theme
                </button>
                    <% if (UsingAccount) { %>
                    <asp:LinkButton runat="server" ID="SignOutBtn" OnClick="SignOutBtn_Click"  CssClass="Btn Btn-link Btn-secondary"><i class="Btn-link-icon fa fa-sign-in"></i>&nbsp;Sign Out</asp:LinkButton>
                    <% } else { %>
                    <asp:LinkButton runat="server" ID="SignInBtn" OnClick="SignInBtn_Click"  CssClass="Btn Btn-link Btn-secondary"><i class="Btn-link-icon fa fa-sign-in"></i>&nbsp;Sign In</asp:LinkButton>
                    <% } %>
                </div>
            </div>
        </div>
        <div class="col-12 col-lg-8 user-content-pannel overflow-auto hidden-scroll-bar">
            <div class="section-col p-0 m-0">
                <div class="section row">
                </div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>
                <div class="section row"></div>

            </div>
        </div>
    </div>
    <div class="modal fade" id="AccountsOnlyModal" tabindex="-1" aria-labelledby="AccountsOnlyModal" aria-hidden="true">
    <div class="modal-dialog  modal-fullscreen">
      <div class="modal-content">
        <div class="modal-head">
         <i class="fa-solid fa-warning modal-icon my-auto"></i>
         <h1 class="modal-title">
             Account Needed
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
            <asp:Button runat="server" ID="ModalLoginBtn" onclick="ModalLoginBtn_Click" type="button" class="Btn Btn-primary ms-auto"  text="Login"></asp:Button>
          </div>
      </div>
    </div>
  </div>
    <div class="modal fade" id="ChangeThemeModal" tabindex="-1" aria-labelledby="Modal" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen">
      <div class="modal-content">
        <div class="modal-head">
         <i class="fa-solid fa-palette modal-icon my-auto"></i>
         <h1 class="modal-title">
             Account Needed
         </h1>
         <button type="button" class="Btn Btn-secondary modal-close pe-0" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
          </div>
          <hr />
          <div class="modal-body my-auto gap-2">
              <div class="pb-2">
                  <h1 class="h1-landing">Select Colors</h1>
              </div>
            <div>
                <p class="p-bg my-2 d-block">Primary Color</p>
                 <div class="d-flex justify-content-center align-items-center">
                    <i class="primary-color-picker-icon color-picker-icon fa-solid fa-paintbrush"></i><input runat="server" id="primaryColor" type="color" class="color-picker"/>
                </div>
            </div>
            <div>
                <p class="p-bg my-2 d-block">Background Color</p>
                <div class="d-flex justify-content-center align-items-center">
                    <i class="background-color-picker-icon  color-picker-icon fa-solid fa-paintbrush"></i><input runat="server" id="backgroundColor" type="color" class="color-picker"/>
                </div>
            </div>
          </div>
          <hr />
        <div class="modal-footer">
            <button type="button" class="Btn Btn-secondary ps-0" data-bs-dismiss="modal">
                Cancle
            </button>
            <asp:Button runat="server" OnClick="SaveBtn_Click" ID="SaveBtn" type="button" class="Btn Btn-primary ms-auto" text="Save"></asp:Button>
          </div>
      </div>
    </div>
  </div>
</asp:Content>


