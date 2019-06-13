<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="filterByGenre.aspx.cs" Inherits="filterByAuthor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="body">
        <div class="filterByGenreTitle text-center" style="border-color: #CC0000; background-color: #FFFFCC; border-radius: 1px; padding-top: 1px; padding-bottom: 1px; margin-bottom: 5px; border-top-style: solid; border-bottom-style: solid;">
            <h3><b>Search By Genre</b></h3>
            <h5><span class="glyphicon glyphicon-pencil"></span><i style="color: #FF0000">Please enter the type of genre in the input box..</i></h5>

            <div class="container-fluid">
                <div class="form-group">
                    <asp:TextBox ID="genreTxt" runat="server" CssClass="form-control center-block text-center" placeholder="please enter the type of genre here.." Font-Bold="False"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:Button ID="searchBtn" runat="server" Text="Search" CssClass="btn btn-primary form-control" OnClick="searchBtn_Click" />
                </div>
            </div>
        </div>

        <div class="col-xs-12" style="margin-top: 0%; background-color: #CCFFFF; text-align: center;">
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
            <asp:SqlDataSource ID="booksDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="selectBookByGenre" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="genreTxt" Name="genre" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>