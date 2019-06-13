<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="orderHistory.aspx.cs" Inherits="orderHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="customerIDLbl" runat="server" Text="" Visible="False"></asp:Label>
    <div class="container">
        <div class="header">
            <h3><b>Your Order History</b></h3>
            <h5><i style="color: darkblue">Here you can see the items you have purchased in the past... </i></h5>
            <br />
        </div>

        <asp:DataList ID="orderHistoryDataList" runat="server" DataSourceID="orderHistoryDataSource" DataKeyField="orderID" CssClass="table table-responsive">
            <ItemTemplate>
                <div class="col-xs-12" style="border: 1px solid #CCCCCC; background-color: #E6E6FA; margin-bottom: 5px; padding-top: 10px; padding-bottom: 5px;">
                    <div class="col-xs-12 form-group" style="border: 1px ridge #999999; background-color: #FFFF99">
                        <b style="font-size: large; color: #6600CC;">Purchased on: </b>
                        <asp:Label ID="dateTimeLabel" runat="server" Text='<%# Eval("dateTime") %>' Font-Size="Medium" />
                    </div>

                    <div class="col-lg-10 col-md-8 col-sm-8 col-xs-12" style="margin-top: 0px; line-height: 23px;">
                        <b>Book ID: </b>
                        <asp:Label ID="bookIDLbl" runat="server" Text='<%# Eval("productID") %>' />
                        <br />

                        <b>Title: </b>
                        <asp:Label ID="tileLbl" runat="server" Text='<%# Eval("title") %>' />
                        <br />

                        <b>Genre/s: </b>
                        <asp:Label ID="genreLbl" runat="server" Text='<%# Eval("genre") %>' />
                        <br />

                        <b>Quantity: </b>
                        <asp:Label ID="quantityLbl" runat="server" Text='<%# Eval("quantity") %>' />
                        <br />

                        <b>Price Per Quantity: </b>
                        <asp:Label ID="pricePerQtyLbl" runat="server" Text='<%#:String.Format("{0:c}", Eval("pricePerQuantity")) %>' />
                        <br />

                        <b>Total Price: </b>
                        <asp:Label ID="totalPriceLbl" runat="server" Text='<%#:String.Format("{0:c}", Eval("totalPrice")) %>' />
                    </div>


                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12 pull-left" style="margin-top: 0px">
                        <a href="bookSingle.aspx?iSBNNo=<%#Eval("iSBNNo")%>">
                            <asp:Image ID="image1" runat="server" ImageUrl='<%#("images/") + Eval("image").ToString().Trim() %>' Height="140" Width="120" />
                        </a>
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="orderHistoryDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="selectOrderHistory" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="customerIDLbl" Name="customerID" PropertyName="Text" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>