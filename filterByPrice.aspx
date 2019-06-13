<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="filterByPrice.aspx.cs" Inherits="filterByAuthor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="body col-lg-3 col-xs-12 col-sm-4 col-md-3">
        <div class="filterByPriceTitle" style="border-color: #CC0000; background-color: #FFFFCC; border-radius: 1px; padding-top: 1px; padding-bottom: 1px; padding-right:10px; margin-bottom: 5px; border-style: solid; border-bottom-style: solid;; padding-left: 10px;">
            <h3><b>Search By Price</b></h3>
            <h5><span class="glyphicon glyphicon-pencil"></span><i style="color: #FF0000">Please specify the prices in the input boxes..</i></h5>
            
            <div class="form-group priceInput">
                <label for="lessThanLbl"><span class="glyphicon glyphicon-chevron-left"></span>Less Than: </label>
                <asp:TextBox ID="minPriceTxt" runat="server" CssClass="form-control" TextMode="Number" ValidationGroup="1"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Button ID="searchMinBtn" runat="server" Text="Search" CssClass="form-control btn btn-primary" ValidationGroup="1" />
            </div>

            <div class="form-group priceInput">
                <label for="moreThanLbl"><span class="glyphicon glyphicon-chevron-right"></span>More Than: </label>
                <asp:TextBox ID="maxPriceTxt" runat="server" CssClass="form-control" TextMode="Number" ValidationGroup="2"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Button ID="searchMaxBtn" runat="server" Text="Search" CssClass="form-control btn btn-primary" OnClick="searchMaxBtn_Click" ValidationGroup="2" />
            </div>
        </div>
    </div>

    <div class="resultsMin col-xs-12 col-lg-9 col-sm-8 col-md-9" style="margin-top: 0%; background-color: #CCFFFF; text-align: center;">
         <asp:ListView ID="booksListView" runat="server" DataKeyNames="iSBNNo" DataSourceID="booksDataSource" GroupItemCount="3" ItemPlaceholderID="itemHere" GroupPlaceholderID="groupHere">
                <GroupTemplate>
                    <tr style="text-align:center;">
                        <asp:PlaceHolder ID="itemHere" runat="server"></asp:PlaceHolder>
                    </tr>
                </GroupTemplate>
                <LayoutTemplate>
                    <table style="text-align:center">
                        <asp:PlaceHolder ID="groupHere" runat="server"></asp:PlaceHolder>
                    </table>
                </LayoutTemplate>

                <ItemTemplate>
                    <td style="display: inline-block; padding: 0px; margin: 10px; text-align:center;">
                        <div class="col-xs-12 eachBook text-center" style="background-color: #333333; border: 4px solid #FFFFFF; border-radius: 5px; width: auto;">
                            <div class="image" style="padding-top: 15px">
                                <a href="bookSingle.aspx?iSBNNo=<%#Eval("iSBNNo")%>">
                                    <asp:Image ID="image2" runat="server" ImageUrl='<%#("images/") + Eval("image").ToString().Trim() %>' Height="250" Width="200" CssClass="img-thumbnail" />
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
            <asp:SqlDataSource ID="booksDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="selectBookByPriceMinimum" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="minPriceTxt" Name="priceMin" PropertyName="Text" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
    </div>

    <div class="resultsMax col-xs-12 pull-right col-lg-9 col-sm-8 col-md-9">
        <asp:DataList ID="DataList1" runat="server" DataKeyField="iSBNNo" DataSourceID="SqlDataSource2" RepeatColumns="3">
            <ItemStyle BorderColor="#999999" BorderStyle="Groove" BorderWidth="2px" BackColor="#CCFFFF" />
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
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="selectBookByPriceMaximum" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="maxPriceTxt" Name="priceMax" PropertyName="Text" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>

    <%--<div class="resultsMax col-xs-12 pull-right col-lg-9 col-sm-8 col-md-9">
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="iSBNNo" DataSourceID="SqlDataSource1" GroupItemCount="2" ItemPlaceholderID="itemHere2" GroupPlaceholderID="groupHere2">
                <GroupTemplate>
                    <tr style="text-align:center">
                        <asp:PlaceHolder ID="groupHere2" runat="server"></asp:PlaceHolder>
                    </tr>
                </GroupTemplate>
                <LayoutTemplate>
                    <table style="text-align:center">
                        <asp:PlaceHolder ID="itemHere2" runat="server"></asp:PlaceHolder>
                    </table>
                </LayoutTemplate>

                <ItemTemplate>
                    <td style="display: inline-block; padding: 0px; margin: 10px; text-align:center;">
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="selectBookByPriceMaximum" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="maxPriceTxt" Name="priceMax" PropertyName="Text" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
    </div>--%>
</asp:Content>