<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="basket.aspx.cs" Inherits="basket" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:label id="productIDLbl" runat="server" text="Label" visible="False"></asp:label>
    <asp:label id="quantityLbl" runat="server" text="Label" visible="False"></asp:label>
    <asp:label id="usernameLbl" runat="server" text="Label" visible="False"></asp:label>
    <asp:textbox id="cusIDTxt" runat="server" textmode="Number" visible="False"></asp:textbox>

    <div class="jumbotron jumbotron-list" style="background-color: #ff3355; color: #FFF; padding-top: 10px; padding-bottom: 15px; margin-bottom: 10px;">
        <div class="container">
            <div class="row">
                <div class="col-sm-12 col-lg-12" style="color: #FFFFFF">
                    <%if (Session["username"] == null)
                        { %>
                    <h1 class="h1">Shopping Basket <small style="color: yellow">Please login first!</small></h1>

                    <%}
                        else
                        {
                            String user = Session["username"].ToString();%>
                    <h1 class="h1">Shopping Basket <small style="color: #CCCCCC"><%=user%></small></h1>

                    <%} %>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xs-12 text-center">
        <asp:label id="messageLbl" runat="server" text="" font-bold="False" font-size="Small" borderstyle="Solid" bordercolor="Black" backcolor="Yellow" borderwidth="1"></asp:label>
    </div>

    <div class="col-xs-12 col-lg-5 col-md-5 col-sm-7">
        <asp:label id="headerLbl" runat="server" text="" font-bold="True" font-italic="True" font-size="15pt"></asp:label>
        <br />
        <asp:datalist id="DataList1" runat="server" datakeyfield="basketID" datasourceid="SqlDataSource1" cellpadding="0" onitemcommand="Datalist1_ItemCommand">
            <ItemStyle BackColor="#CCFFFF" BorderColor="#D3D3D3" BorderStyle="solid" BorderWidth="10px" />
            <ItemTemplate>
                <div class="col-xs-12 title">
                    <a href="bookSingle.aspx?iSBNNo=<%#Eval("iSBNNo")%>">
                        <asp:Label ID="titleLbl" runat="server" Text='<%# Eval("title") %>' Font-Size="X-Large" ForeColor="#C7254E" />
                    </a>
                </div>

                <div class="col-lg-4 col-md-5 col-sm-5 image" style="padding-bottom: 5px;">
                    <a href="bookSingle.aspx?iSBNNo=<%#Eval("iSBNNo")%>">
                        <asp:Image ID="image2" runat="server" ImageUrl='<%#("images/") + Eval("image").ToString().Trim() %>' CssClass="img-responsive img-rounded" />
                    </a>
                </div>

                <div class="col-lg-8 bookInfo" style="padding-top: 0px; margin-top: 0px;">
                    <b>Book ID: </b>
                    <asp:Label ID="bookIDLbl" runat="server" Text='<%#Eval("iSBNNo") %>' />
                    <br>

                    <b>Author: </b>
                    <asp:Label ID="authorLbl" runat="server" Text='<%#Eval("author") %>' />
                    <br>

                    <b>Available Copies: </b>
                    <asp:Label ID="availableQtyLbl" runat="server" Text='<%# Eval("quantity1") %>' Visible="True" />
                    <br />

                    <b>Quantity: </b>
                    <asp:Label ID="qtyInBasketLbl" runat="server" Text='<%#Eval("quantity") %>' />
                    <br>

                    <b>Price Per Qty: </b>
                    <%#:String.Format("{0:c}", Eval("price"))%>
                    <asp:Label ID="priceLbl" runat="server" Text='<%#Eval("price") %>' Visible="False" />
                    <br>

                    <b>Total Price: </b>
                    <%#:String.Format("{0:c}", Eval("totalPrice"))%>
                    <asp:Label ID="totalPriceLbl" runat="server" Text='<%#Eval("totalPrice") %>' Visible="False" />
                    <br>
                    <br />

                    <asp:Label ID="selectQtyLbl" runat="server" Text="Change Qty: " ForeColor="#660066" Font-Bold="True"></asp:Label>
                    
                    <asp:TextBox ID="quantityToUpdateTxt" runat="server" Height="22" Width="50" Enabled="true" TextMode="Number" min="0" max='<%#System.Convert.ToInt32(Eval("quantity1"))%>'></asp:TextBox>
                    <%--<asp:RequiredFieldValidator ID="updateQuantityReqVal" runat="server" ControlToValidate="quantityToUpdateTxt" Text="*" ForeColor="Red" Font-Size="Medium"></asp:RequiredFieldValidator>--%>                 
                    
                    <asp:Button ID="updateBtn" runat="server" Text="Update" CssClass="btn btn-primary" Width="70px" Enabled="true" CommandArgument='<%#Eval("productID")%>' CommandName="updateQuantity" />
                </div>

                <div class="col-lg-12" style="padding-top: 5px; padding-bottom: 15px">
                    <asp:Button ID="deleteBtn" runat="server" Text="Delete Item" CssClass="btn btn-danger form-control" CommandArgument='<%#Eval("productID")%>' CommandName="deleteItem"  OnClientClick="return confirm('Are you sure you want to delete this item?')"/>
                </div>               
            </ItemTemplate>
        </asp:datalist>
    </div>

    <%if (Session["username"] != null)
        { %>
    <div class="col-lg-3 col-md-3 col-sm-4 col-xs-12" style="margin-top: 25px">
        <div class="form-group">
            <legend><span class="glyphicon glyphicon-gbp"></span>Confirmation</legend>
            <asp:label id="grandTotalLbl" runat="server" text="Total Price: £0.00" font-size="Medium"></asp:label>
            <br>
        </div>

        <div class="form-group">
            <asp:button id="clearBtn" runat="server" text="Clear Basket" cssclass="form-control btn btn-warning" onclick="clearBtn_Click" onclientclick="return confirm('Are you sure you want to clear all items in your basket?')" />
        </div>
        <div class="form-group">
            <asp:button id="checkoutBtn" runat="server" text="Proceed To Checkout" cssclass="btn btn-success form-control" onclick="checkoutBtn_Click" onclientclick="return confirm('Please click OK to confirm your purchases!')" />
        </div>
    </div>
    <%} %>


    <asp:sqldatasource id="SqlDataSource1" runat="server" connectionstring="<%$ ConnectionStrings:ConnectionString %>" selectcommand="selectBasket" selectcommandtype="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cusIDTxt" Name="customerID" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:sqldatasource>


    <asp:formview id="totalPriceInBasketFormView" runat="server" datasourceid="grandTotalDataSource" visible="False">
        <ItemTemplate>
            <asp:Label ID="grandTotalLbl" runat="server" Text='<%# Bind("Expr1") %>' />
            <br />

        </ItemTemplate>
    </asp:formview>



    <asp:sqldatasource id="grandTotalDataSource" runat="server" connectionstring="<%$ ConnectionStrings:ConnectionString %>" selectcommand="SELECT SUM(totalPrice) AS Expr1 FROM Basket WHERE (customerID = @customerID)">
        <SelectParameters>
            <asp:SessionParameter Name="customerID" SessionField="customerID" />
        </SelectParameters>
    </asp:sqldatasource>



    <asp:datalist id="basketDataList" runat="server" datakeyfield="basketID" datasourceid="basketDataSource" visible="False">
        <ItemTemplate>
            basketID:
            <asp:Label ID="basketIDLabel" runat="server" Text='<%# Eval("basketID") %>' />
            <br />
            quantity:
            <asp:Label ID="quantityLabel" runat="server" Text='<%# Eval("quantity") %>' />
            <br />
            totalPrice:
            <asp:Label ID="totalPriceLabel" runat="server" Text='<%# Eval("totalPrice") %>' />
            <br />
            productID:
            <asp:Label ID="productIDLabel" runat="server" Text='<%# Eval("productID") %>' />
            <br />
            customerID:
            <asp:Label ID="customerIDLabel" runat="server" Text='<%# Eval("customerID") %>' />
            <br />
            <br />
        </ItemTemplate>
    </asp:datalist>
    <asp:sqldatasource id="basketDataSource" runat="server" connectionstring="<%$ ConnectionStrings:ConnectionString %>" selectcommand="SELECT * FROM [Basket]"></asp:sqldatasource>

    <asp:datalist id="booksDataList" runat="server" datakeyfield="iSBNNo" datasourceid="booksDataSource" visible="False">
        <ItemTemplate>
            iSBNNo:
            <asp:Label ID="iSBNNoLabel" runat="server" Text='<%# Eval("iSBNNo") %>' />
            <br />
            title:
            <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("title") %>' />
            <br />
            author:
            <asp:Label ID="authorLabel" runat="server" Text='<%# Eval("author") %>' />
            <br />
            yearPublished:
            <asp:Label ID="yearPublishedLabel" runat="server" Text='<%# Eval("yearPublished") %>' />
            <br />
            genre:
            <asp:Label ID="genreLabel" runat="server" Text='<%# Eval("genre") %>' />
            <br />
            price:
            <asp:Label ID="priceLabel" runat="server" Text='<%# Eval("price") %>' />
            <br />
            quantity:
            <asp:Label ID="quantityLabel" runat="server" Text='<%# Eval("quantity") %>' />
            <br />
            description:
            <asp:Label ID="descriptionLabel" runat="server" Text='<%# Eval("description") %>' />
            <br />
            image:
            <asp:Label ID="imageLabel" runat="server" Text='<%# Eval("image") %>' />
            <br />
            <br />
        </ItemTemplate>
    </asp:datalist>
    <asp:sqldatasource id="booksDataSource" runat="server" connectionstring="<%$ ConnectionStrings:ConnectionString %>" selectcommand="SELECT * FROM [Books]"></asp:sqldatasource>

    <asp:datalist id="orderHistoryDataSet" runat="server" datakeyfield="orderID" datasourceid="orderHistoryDataSource" visible="False">
        <ItemTemplate>
            orderID:
            <asp:Label ID="orderIDLabel" runat="server" Text='<%# Eval("orderID") %>' />
            <br />
            quantity:
            <asp:Label ID="quantityLabel" runat="server" Text='<%# Eval("quantity") %>' />
            <br />
            pricePerQuantity:
            <asp:Label ID="pricePerQuantityLabel" runat="server" Text='<%# Eval("pricePerQuantity") %>' />
            <br />
            totalPrice:
            <asp:Label ID="totalPriceLabel" runat="server" Text='<%# Eval("totalPrice") %>' />
            <br />
            dateTime:
            <asp:Label ID="dateTimeLabel" runat="server" Text='<%# Eval("dateTime") %>' />
            <br />
            productID:
            <asp:Label ID="productIDLabel" runat="server" Text='<%# Eval("productID") %>' />
            <br />
            customerID:
            <asp:Label ID="customerIDLabel" runat="server" Text='<%# Eval("customerID") %>' />
            <br />
            <br />
        </ItemTemplate>
    </asp:datalist>
    <asp:sqldatasource id="orderHistoryDataSource" runat="server" connectionstring="<%$ ConnectionStrings:ConnectionString %>" selectcommand="SELECT * FROM [OrderHistory]"></asp:sqldatasource>

</asp:Content>
