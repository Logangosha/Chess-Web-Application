<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Chess_App.Home" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="user-content">

        <div class="user-content-pannel overflow-auto">
            <div class="section"></div>
            <div class="section"></div>
            <div class="section"></div>
            <div class="section"></div>
            <div class="section"></div>
            <div class="section"></div>
        </div>
        <div class="user-control-pannel">

            <%
                if (UsingAccount)
                {%>
            <asp:LinkButton runat="server" ID="AccountBtn" OnClick="AccountBtn_Click" type="button" class="Btn Btn-icon Btn-primary">
                <img src="<%=(HttpContext.Current.Session["AccountInfo"] as Chess_App.PlayerAccount).ProfilePictureString %>" class="profile-img" /></asp:LinkButton>
            <%}
                else
                {%> 
                        <button text="Modal" type="button" class="Btn Btn-icon Btn-primary d-lg-inline-block" data-bs-toggle="modal" data-bs-target="#AccountsOnlyModal"><img src="<%=(HttpContext.Current.Session["AccountInfo"] as Chess_App.Guest).ProfilePictureString %>" class="profile-img"/></button>

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


