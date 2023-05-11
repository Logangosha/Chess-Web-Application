<%@ Page Language="C#" Title="Friend Account" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FriendAccount.aspx.cs" Inherits="Chess_App.FriendAccount" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid h-100">
        <div class="row h-100">
            <asp:Button runat="server" ID="btnRemoveFriend" Text="Remove Friend" OnClick="BtnRemoveFriend_Click" />
            <asp:Button runat="server" ID="btnPlayFriend" Text="Play" OnClick="BtnPlayFriend_Click" />
        </div>
    </div>
</asp:Content>
