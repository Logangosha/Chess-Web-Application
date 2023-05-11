<%@ Page Language="C#" Title="test page" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="Chess_App.test" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row p-0 hidden-scroll-bar overflow-auto MainCard" style="height: 100vh;">
        <button class="Btn Btn-primary">
            Primary
        </button>
        <button class="Btn Btn-secondary">
            Secondary
        </button> 
        <button class="Btn Btn-disabled">
            Success
        </button>
    </div>
</asp:Content>
