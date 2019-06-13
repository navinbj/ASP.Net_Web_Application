<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="bookSingle.aspx.cs" Inherits="bookSingle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="productIDLbl" runat="server" Text="Label" Visible="False"></asp:Label>
    <div class="col-xs-12 text-center">
        <asp:Label ID="messageLbl" runat="server" Font-Bold="True" Font-Size="Medium" Font-Italic="False"></asp:Label>
    </div>
    <div class="container">
        <asp:DataList ID="DataList1" runat="server" DataKeyField="iSBNNo" DataSourceID="SqlDataSource1">
            <ItemStyle BackColor="#CCFFFF" BorderColor="#CC3300" BorderStyle="Ridge" BorderWidth="5px" />
            <ItemTemplate>
                <div class="book">
                    <div class="col-xs-12 title">
                        <asp:Label ID="titleLbl" runat="server" Text='<%# Eval("title") %>' Font-Size="XX-Large" />
                    </div>

                    <div class="col-lg-3 col-md-4 col-sm-5 image" style="padding-bottom: 15px;">
                        <asp:Image ID="image1" runat="server" ImageUrl='<%#("images/") + Eval("image").ToString().Trim() %>' Height="300px" Width="200px" />
                    </div>

                    <div class="col-lg-4 bookInfo" style="padding-top: 0px; margin-top: 0px;">
                        <b>Author: </b>
                        <asp:Label ID="authorLbl" runat="server" Text='<%#Eval("author") %>' />
                        <br>

                        <b>Published: </b>
                        <asp:Label ID="yearPublishedLbl" runat="server" Text='<%#Eval("yearPublished") %>' />
                        <br>

                        <b>Genre/s: </b>
                        <asp:Label ID="genreLbl" runat="server" Text='<%#Eval("genre") %>' />
                        <br>

                        <b>Price: </b>
                        <%#:String.Format("{0:c}", Eval("price"))%>
                        <asp:Label ID="priceLbl" runat="server" Text='<%#Eval("price") %>' Visible="False" />
                        <br>

                        <b>Available Copies: </b>
                        <asp:Label ID="quantityLbl" runat="server" Text='<%#Eval("quantity") %>' />
                        

                        <%if (Session["username"] != null)
                            {%>
                        <br>
                        <br />
                        <asp:Label ID="selectQtyLbl" runat="server" Text="Enter Quantity: " ForeColor="#660066" Font-Bold="True"></asp:Label>
                        <asp:TextBox ID="quantityTxt" runat="server" Height="22" Width="50" TextMode="Number" ValidationGroup="1" min="0" max='<%#System.Convert.ToInt32(Eval("quantity"))%>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="quantityReqVal" runat="server" ControlToValidate="quantityTxt" Text="*Please enter quantity first!" ForeColor="Red" ValidationGroup="1"></asp:RequiredFieldValidator>
                        <br />
                        <asp:Button ID="addBtn" runat="server" Text="Add To Basket" CssClass="btn btn-primary" OnClick="addBtn_Click" Enabled="True" ValidationGroup="1" />
                        <asp:Label ID="warningLbl" runat="server" Text="" ></asp:Label>
                        <%} %>
                    </div>

                    <div class="col-lg-9 description" style="padding-top: 0px; margin-top: 20px; padding-bottom: 10px; color: #006699;">
                        <b style="font-size: 14px">Description: </b>
                        <asp:Label ID="descriptionLbl" runat="server" Text='<%# Eval("description") %>' Font-Size="14px" />
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>

        <div class="warning" style="text-align: right;">
            <asp:Label ID="lblWarning" runat="server" Text="" Font-Bold="True" Font-Italic="True" Font-Size="Medium" CssClass="text-right"></asp:Label>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Books] WHERE ([iSBNNo] = @iSBNNo)">
        <SelectParameters>
            <asp:ControlParameter ControlID="productIDLbl" Name="iSBNNo" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <% if (Session["username"] != null)
        {
    %>
    <div class="container">
        <div class="form">
            <div class="col-xs-12" style="border: 1px solid #009900; border-radius: 5px; margin-top: 1%; background-color: #F0FFF0;">
                <div class="head">
                    <h4 style="font-family: Consolas; color: #009900; font-weight: bold;">Tell us what you think!</h4>
                </div>
                
                <div class="form-group">
                    <asp:TextBox ID="commentTxt" runat="server" CssClass="form-control text-capitalize" TextMode="MultiLine" Columns="30" Rows="4" placeholder="please enter your comment here..." Font-Bold="False" BorderColor="#009933" ValidationGroup="2"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="commentReqVal" runat="server" ErrorMessage="Please enter comment first!" ControlToValidate="commentTxt" Text="*Please enter comment first!" ForeColor="Red" ValidationGroup="2"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:Button ID="submitBtn" runat="server" Text="SUBMIT" CssClass="btn" BackColor="#006600" ForeColor="White" Font-Names="Consolas" Font-Size="Medium" Font-Bold="False" OnClick="submitBtn_Click" ValidationGroup="2" />
                </div>
            </div>
        </div>
    </div>
    <%} %>

    <div class="container" style="margin-top: 25px">
        <div class="form">
            <div class="head" style="background-color: #CCFFFF;">
                <h4 style="border: 1px solid #66CCFF; padding: 3px; font-family: Consolas; color: #000000; font-weight: bold; border-radius: 5px;">Submitted Comments</h4>
            </div>

            <asp:DataList ID="DataList2" runat="server" DataKeyField="commentID" DataSourceID="SqlDataSource2" CssClass="table table-responsive" OnItemCommand="Datalist2_ItemCommand">
                <ItemTemplate>
                    <div class="col-xs-12" style="border: 1px solid #CCCCCC; background-color: #E6E6FA; margin-bottom: 5px; padding-top: 5px; padding-bottom: 5px;">
                        <asp:Label ID="customerIDLbl" runat="server" Text='<%# Eval("customerID") %>' Visible="False"></asp:Label>
                        <asp:Label ID="selectedCommentIDLbl" runat="server" Text='<%# Eval("commentID") %>' Visible="False"></asp:Label>
                        <asp:Label ID="productIDLbl" runat="server" Text='<%# Eval("productID") %>' Visible="false" />
                        <asp:Label ID="commentLabel" runat="server" Text='<%# Eval("comment") %>' />
                        <br />
                        <asp:Label ID="Label1" runat="server" Text="By:" ForeColor="#3399FF"></asp:Label>
                        <asp:Label ID="emailLabel" runat="server" Text='<%# Eval("email") %>' ForeColor="#3399FF" />
                        <br />
                        <asp:Label ID="dateTimeLabel" runat="server" Text='<%# Eval("dateTime") %>' ForeColor="#3399FF" />
                        <br />

                        <%if (Session["username"] != null)
                        {%>
                            <asp:Button ID="deleteCommentBtn" runat="server" Text="Delete" CssClass="btn btn-link" Font-Underline="True" Font-Bold="False" ForeColor="#FF6666" CommandName="deleteComment" Visible="True" OnClientClick="return confirm('Are you sure you want to delete this comment?')"/>
                            <br>
                        <%}%>
                    </div>
                </ItemTemplate>           
            </asp:DataList>

            <asp:DataList ID="commentsDataList" runat="server" DataKeyField="commentID" DataSourceID="commentsDataSource" Visible="False">
                <ItemTemplate>
                    commentID:
                    <asp:Label ID="commentIDLabel" runat="server" Text='<%# Eval("commentID") %>' />
                    <br />
                    comment:
                    <asp:Label ID="commentLabel" runat="server" Text='<%# Eval("comment") %>' />
                    <br />
                    productID:
                    <asp:Label ID="productIDLabel" runat="server" Text='<%# Eval("productID") %>' />
                    <br />
                    customerID:
                    <asp:Label ID="customerIDLabel" runat="server" Text='<%# Eval("customerID") %>' />
                    <br />
                    dateTime:
                    <asp:Label ID="dateTimeLabel" runat="server" Text='<%# Eval("dateTime") %>' />
                    <br />
<br />
                </ItemTemplate>
            </asp:DataList>

            <asp:SqlDataSource ID="commentsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [BooksComments]"></asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="selectBooksComment" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="productIDLbl" Name="iSBNNo" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:DataList ID="basketDataList" runat="server" DataSourceID="basketDataSource" Visible="False">
                <ItemTemplate>
                    quantity:
                    <asp:Label ID="quantityInBasketLabel" runat="server" Text='<%# Eval("quantity") %>' />
                    <br />
                    productID:
                    <asp:Label ID="productIDLabel" runat="server" Text='<%# Eval("productID") %>' />
                    <br />
                    customerID:
                    <asp:Label ID="customerIDLabel" runat="server" Text='<%# Eval("customerID") %>' />
                    <br />
                    <br />
                </ItemTemplate>
            </asp:DataList>

            <asp:SqlDataSource ID="basketDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [quantity], [productID], [customerID] FROM [Basket]"></asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
