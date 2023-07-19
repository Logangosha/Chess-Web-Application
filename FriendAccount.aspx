<%@ Page Language="C#" Title="Friend Account" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FriendAccount.aspx.cs" Inherits="Chess_App.FriendAccount" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row p-0 justify-content-center h-100 MainCard overflow-scroll hidden-scroll-bar">
        <div class="col-auto col-lg-7 col-xl-5 py-4 p-0 justify-content-center my-auto align-items-center">
            <div class="profile-body p-0 px-4 d-flex flex-column">
                <div>
                    <div class="profile-img-container">
                        <img runat="server" id="profileImg" class="profile-img" />
                    </div>
                    <h1 runat="server" id="usernameLbl" class="mt-3 h1-landing-sm text-break"></h1>
                </div>
                <hr />
                <button type="button" class="Btn Btn-link" runat="server" id="FriendStatusBtn" onserverclick="FriendStatusBtn_Click">
                    <%if ((int)ViewState["friendStatus"] == 0){%>
                    <i class="Btn-link-icon fa-solid fa-plus"></i>
                    Add Friend
                    <%}%>
                    <%else if((int)ViewState["friendStatus"] == 1){%>
                    <i class="Btn-link-icon fa-solid fa-minus"></i>
                    Remove Friend
                    <%}%>
                    <%else if((int)ViewState["friendStatus"] == 2){%>
                    <i class="Btn-link-icon fa-solid fa-clock"></i>
                    Pending
                    <%}%>
                    <%else{%>
                    <i class="Btn-link-icon fa-solid fa-triangle-exclamation"></i>
                    Error
                    <%}%>
                </button>
                <button type="button" class="Btn Btn-link">
                    <i class="Btn-link-icon fa-solid fa-envelope"></i>
                    Send Message
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </button>
                 <button type="button" class="Btn Btn-link">
                    <i class="Btn-link-icon fa-solid fa-chess-board"></i>
                    Challenge
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </button>
                <asp:LinkButton runat="server" ID="goHomeBtn" OnClick="goHomeBtn_Click" CssClass="Btn Btn-primary Btn-large mt-2"><span class="user-control-pannel-body-btn-icon fa fa-sign-in"></span>&nbsp;Go Home</asp:LinkButton>
            </div>
        </div>
    </div>
</asp:Content>
