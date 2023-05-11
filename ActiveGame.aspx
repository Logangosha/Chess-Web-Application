<%@ Page Language="C#" Title="Game" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ActiveGame.aspx.cs" Inherits="Chess_App.Game" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid h-100">
        <div class="row h-100">
            <asp:Button runat="server" Text="GameOver" OnClick="Unnamed_Click" />
        </div>
    </div>
</asp:Content>
