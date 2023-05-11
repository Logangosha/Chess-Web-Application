<%@ Page Language="C#" Title="Friends" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Friends.aspx.cs" Inherits="Chess_App.Friends" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid h-100">
        <div class="row h-100">
            <asp:button runat="server" id="btnAddFriend" text="Add Friend" OnClick="BtnAddFriend_Click" />
            <asp:button runat="server" id="btnFindFrined" text="Find A Friend" OnClick="BtnFindFrined_Click"/>
            <asp:button runat="server" id="btnSelectFriend" text="Select Friend" OnClick="BtnSelectFriend_Click"/>
        </div>
    </div>
</asp:Content>