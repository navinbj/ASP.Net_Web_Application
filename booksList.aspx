<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="booksList.aspx.cs" Inherits="test" %>

<%@ Import Namespace="System.ComponentModel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="jumbotron jumbotron-sm" style="background-color: #996600; color: #FFF; padding-top: 10px; padding-bottom: 10px; margin-bottom: 10px;">
        <div class="container">
            <div class="row">
                <div class="col-sm-12 col-lg-12 pull-left" style="color: #FFFFFF">
                    <h2><b>Books Available At Our Store</b></h2>
                    <i style="color: #CCCCCC; padding-left: -10px;">You can select the book/books of your choice and add it to your basket!</i>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <asp:DataList ID="DataList2" runat="server" DataKeyField="iSBNNo" DataSourceID="SqlDataSource1" RepeatColumns="4" RepeatDirection="Horizontal" Visible="False">
            <ItemStyle BorderColor="#999999" BorderStyle="Groove" BorderWidth="2px" BackColor="#FFFFCC" />
            <ItemTemplate>
                <div class="text-center">
                    <div class="col-xs-12 title" style="padding-bottom: 5px">
                        <a href="bookSingle.aspx?iSBNNo=<%#Eval("iSBNNo")%>">
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("title") %>' ForeColor="#C7254E" />
                        </a>

                    </div>

                    <div class="col-xs-12 image">
                        <a href="bookSingle.aspx?iSBNNo=<%#Eval("iSBNNo")%>">
                            <asp:Image ID="image1" runat="server" ImageUrl='<%#("images/") + Eval("image").ToString().Trim() %>' Height="200" Width="160" />
                        </a>
                        <br />
                    </div>

                    <div class="col-xs-12 price" style="padding-bottom: 10px">
                        <b>Price: </b><%#:String.Format("{0:c}", Eval("price"))%>
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Books]"></asp:SqlDataSource>
    </div>

    <div class="container-fluid" style="margin-top: 0%; background-color: #CCFFFF; text-align: center;">
        <asp:ListView ID="booksListView" runat="server" DataKeyNames="iSBNNo" DataSourceID="booksDataSource" GroupItemCount="4" ItemPlaceholderID="itemHere" GroupPlaceholderID="groupHere">
            <GroupTemplate>
                <tr>
                    <asp:PlaceHolder ID="itemHere" runat="server"></asp:PlaceHolder>
                </tr>
            </GroupTemplate>
            <LayoutTemplate>
                <table align="center">
                    <asp:PlaceHolder ID="groupHere" runat="server"></asp:PlaceHolder>
                </table>
            </LayoutTemplate>

            <ItemTemplate>
                <td style="display: inline-grid; padding: 0px; margin: 10px; text-align: center;">
                    <div class="col-xs-12 eachBook text-center" style="background-color: #333333; border: 4px solid #FFFFFF; border-radius: 5px; width: auto;">
                        <%--<div class="title" style="padding-bottom: 5px">
                            <a href="bookSingle.aspx?iSBNNo=<%#Eval("iSBNNo")%>">
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("title") %>' ForeColor="#C7254E" />
                            </a>
                        </div>--%>

                        <div class="image" style="padding-top: 15px">
                            <a href="bookSingle.aspx?iSBNNo=<%#Eval("iSBNNo")%>">
                                <asp:Image ID="image1" runat="server" ImageUrl='<%#("images/") + Eval("image").ToString().Trim() %>' Height="250" Width="200" CssClass="img-thumbnail" />
                            </a>
                            <br />
                        </div>

                        <div class="price" style="padding-bottom: 10px; padding-top: 5px; color: pink; font-size: medium;">
                            <b>Price: </b><%#:String.Format("{0:c}", Eval("price"))%>
                        </div>
                    </div>
                </td>
            </ItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="booksDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Books]"></asp:SqlDataSource>
    </div>
</asp:Content>
