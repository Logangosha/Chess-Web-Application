<%@ Page Language="C#" Title="Friends" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Friends.aspx.cs" Inherits="Chess_App.Friends" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid h-100">
        <div class="row h-100 justify-content-center">
            <div class="d-flex gap-3 flex-column justify-content-center align-items-center col-lg-6 col-10 mb-4">
                <h1 class=" h1-landing">FRIENDS</h1>
                <hr class="w-100" />
                <div class="search-bar">
                    <input class="search-bar-input" type="text" placeholder="Search" />
                    <button class="Btn Btn-primary search-bar-Btn">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
                <%--<asp:PlaceHolder runat="server" ID="FriendTilesPlaceholder"></asp:PlaceHolder>--%>
                <div class="Btn friend-tile">
                    <img src="Images/whitehandmovingchesspiece.jpg" />
                    <p>Friend 1</p>
                    <span class="status-indicator offline"></span>
                </div>
                <div class="Btn friend-tile">
                    <img src="Images/twomenplayingchessdarkroom.jpg" />
                    <p>Friend 2</p>
                    <span class="status-indicator"></span>
                </div>
                <div class="Btn friend-tile offline">
                    <img src="Images/unclewiggly.png" />
                    <p>Friend 3</p>
                    <span class="status-indicator"></span>
                </div>
                <div class="Btn friend-tile">
                    <img src="Images/untitled.png" />
                    <p>Friend 4</p>
                    <span class="status-indicator"></span>
                </div>
                <div class="Btn friend-tile">
                    <img src="Images/whitehandmovingchesspiece.jpg" />
                    <p>Friend 1</p>
                    <span class="status-indicator"></span>
                </div>
                <div class="Btn friend-tile">
                    <img src="Images/twomenplayingchessdarkroom.jpg" />
                    <p>Friend 2</p>
                    <span class="status-indicator"></span>
                </div>
                <div class="Btn friend-tile">
                    <img src="Images/unclewiggly.png" />
                    <p>Friend 3</p>
                    <span class="status-indicator"></span>
                </div>
                <div class="mt-5"></div>
            </div>
        </div>
    </div>
</asp:Content>
