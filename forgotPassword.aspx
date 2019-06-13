<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="forgotPassword.aspx.cs" Inherits="forgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

    <div class="form-gap"></div>
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-md-offset-3 text-center">
                <asp:Label ID="statusLbl" runat="server" Font-Bold="True" ForeColor="Green"></asp:Label>
                <div class="panel panel-default" style="border: 1px ridge #666666; background-color: #F0FFF0">
                    <div class="panel-body">
                        <div class="text-center">
                            <h3><i class="fa fa-lock fa-4x"></i></h3>
                            <h2 class="text-center">Forgot Password?</h2>
                            <p>You can reset your password here.</p>
                            <div class="panel-body">
                                <div class="form-group">
                                    <asp:RequiredFieldValidator ID="emailReqVal" runat="server" ControlToValidate="emailTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False"></asp:RequiredFieldValidator>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                                        <asp:TextBox ID="emailTxt" runat="server" CssClass="form-control" placeholder="Enter your email here" Font-Bold="False" TextMode="Email"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <asp:RequiredFieldValidator ID="passwordReqVal" runat="server" ControlToValidate="passwordTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="passwordRegExVal" runat="server" ControlToValidate="passwordTxt" ErrorMessage="***ERR: not a valid password pattern!" ForeColor="Red" ValidationExpression="[A-Za-z ]*" Font-Bold="False"></asp:RegularExpressionValidator>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                        <asp:TextBox ID="passwordTxt" runat="server" CssClass="form-control" placeholder="Enter new password" Font-Bold="False" TextMode="Password"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <asp:RequiredFieldValidator ID="passwordConfirmReqVal" runat="server" ControlToValidate="passwordConfirmTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="passwordCompVal" runat="server" ControlToCompare="passwordTxt" ControlToValidate="passwordConfirmTxt" ErrorMessage="Passwords do not match!" ForeColor="Red" Font-Bold="False"></asp:CompareValidator>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                        <asp:TextBox ID="passwordConfirmTxt" runat="server" CssClass="form-control" placeholder="Re-enter new password" Font-Bold="False" TextMode="Password"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Button ID="resetBtn" runat="server" Text="Reset Password" CssClass="form-control btn btn-primary" Font-Size="Medium" OnClick="resetBtn_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <asp:DataList ID="customersDataList" runat="server" DataKeyField="customerID" DataSourceID="customersDataSource" Visible="False">
        <ItemTemplate>
            customerID:
            <asp:Label ID="customerIDLabel" runat="server" Text='<%# Eval("customerID") %>' />
            <br />
            firstName:
            <asp:Label ID="firstNameLabel" runat="server" Text='<%# Eval("firstName") %>' />
            <br />
            lastName:
            <asp:Label ID="lastNameLabel" runat="server" Text='<%# Eval("lastName") %>' />
            <br />
            address_street:
            <asp:Label ID="address_streetLabel" runat="server" Text='<%# Eval("address_street") %>' />
            <br />
            address_city:
            <asp:Label ID="address_cityLabel" runat="server" Text='<%# Eval("address_city") %>' />
            <br />
            postcode:
            <asp:Label ID="postcodeLabel" runat="server" Text='<%# Eval("postcode") %>' />
            <br />
            mobile:
            <asp:Label ID="mobileLabel" runat="server" Text='<%# Eval("mobile") %>' />
            <br />
            email:
            <asp:Label ID="emailLabel" runat="server" Text='<%# Eval("email") %>' />
            <br />
            password:
            <asp:Label ID="passwordLabel" runat="server" Text='<%# Eval("password") %>' />
            <br />
            <br />
        </ItemTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="customersDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Customers]"></asp:SqlDataSource>
</asp:Content>
