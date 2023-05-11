<%@ Page Language="C#" Title="Game Over" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GameOver.aspx.cs" Inherits="Chess_App.GameOver" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid h-100">
        <div class="row h-100">
           <asp:Label runat="server" Text="Rematch?"/>
            <asp:Button runat="server" Text="Yes" OnCommand="Rematch_Command" CommandName="Yes" />
            <asp:Button runat="server" Text="No" OnCommand="Rematch_Command" CommandName="No"/>
        </div>
    </div>
</asp:Content>
