<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="myAccount.aspx.cs" Inherits="myAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

    <div class="container">
        <div class="header">
            <h3><b>Your Personal Details: </b></h3>
            <h5><i style="color: darkblue">You can edit your account details on this page and save the new changes!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </i></h5>
            <br />
        </div>

        <div class="row">
            <div class="col-md-6">
                <asp:Label ID="statusLbl" runat="server" Font-Bold="True" ForeColor="Green"></asp:Label>
                <asp:DataList ID="customerDataList" runat="server" DataKeyField="customerID" DataSourceID="SqlDataSource1" CssClass="form-group table table-responsive" OnSelectedIndexChanged="customerDataList_SelectedIndexChanged">
                    <ItemTemplate>
                        <fieldset style="border: 2px groove #000000; background-color: #FFFFCC; padding-top: 10px; padding-right: 10px; padding-left: 10px;">
                            <div class="form-group text-center" style="background-color: #FFFFCC; color: #CC0000;">
                                <b style="font-size: medium">Membership ID: </b>
                                <asp:Label ID="cusIDLbl" runat="server" Text='<%# Eval("customerID") %>' Font-Size="Medium" Font-Bold="False"></asp:Label>
                            </div>

                            <div class="details" style="border: 1px ridge #999999; background-color: #CCFFFF; padding-top: 5px; padding-right: 10px; padding-left: 10px;">
                                <div class="form-group">
                                    <asp:Label ID="firstNameLbl" runat="server" Text="First Name: " Font-Bold="True"></asp:Label>
                                    <asp:TextBox ID="firstNameTxt" runat="server" Text='<%# Eval("firstName").ToString().Trim() %>' CssClass="form-control" Font-Bold="False" Enabled="False"></asp:TextBox>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="lastNameLbl" runat="server" Text="Last Name: " Font-Bold="True"></asp:Label>
                                    <asp:TextBox ID="lastNameTxt" runat="server" Text='<%# Eval("lastName").ToString().Trim() %>' CssClass="form-control" Font-Bold="False" Enabled="False"></asp:TextBox>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="addressLbl" runat="server" Text="Address: " Font-Bold="True"></asp:Label>
                                    <asp:RegularExpressionValidator ID="addressRegExVal" runat="server" ControlToValidate="addressTxt" ErrorMessage="***ERR: not a valid address!" ForeColor="Red" ValidationExpression="^\d+\s[A-z]+\s[A-z]+" Font-Bold="False" ValidationGroup="1"></asp:RegularExpressionValidator>
                                    <asp:TextBox ID="addressTxt" runat="server" Text='<%# Eval("address_street").ToString().Trim() %>' CssClass="form-control" Font-Bold="False" ValidationGroup="1"></asp:TextBox>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="cityLbl" runat="server" Text="City: " Font-Bold="True"></asp:Label>
                                    <asp:RegularExpressionValidator ID="cityRegExVal" runat="server" ControlToValidate="cityTxt" ErrorMessage="***ERR: not a valid city name!" ForeColor="Red" ValidationExpression="[A-Za-z ]*" Font-Bold="False" ValidationGroup="1"></asp:RegularExpressionValidator>
                                    <asp:TextBox ID="cityTxt" runat="server" Text='<%# Eval("address_city").ToString().Trim() %>' CssClass="form-control" Font-Bold="False" ValidationGroup="1"></asp:TextBox>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="postcodeLbl" runat="server" Text="Postcode: " Font-Bold="True"></asp:Label>
                                    <asp:RegularExpressionValidator ID="postcodeRegExVal" runat="server" ControlToValidate="postcodeTxt" ErrorMessage="***ERR: not a valid postcode!" ForeColor="Red" ValidationExpression="^[A-Z]{1,2}[0-9]{1,2}[A-Z]?\s[0-9][A-Z][A-Z]$" Font-Bold="False" ValidationGroup="1"></asp:RegularExpressionValidator>
                                    <asp:TextBox ID="postcodeTxt" runat="server" Text='<%# Eval("postcode").ToString().Trim() %>' CssClass="form-control" Font-Bold="False" ValidationGroup="1"></asp:TextBox>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="mobileLbl" runat="server" Text="Mobile: " Font-Bold="True"></asp:Label>
                                    <asp:RegularExpressionValidator ID="mobileRegExVal" runat="server" ControlToValidate="mobileTxt" ErrorMessage="***ERR: not a valid mobile number!" ForeColor="Red" ValidationExpression="^(\+44\s?7\d{3}|\(?07\d{3}\)?)\s?\d{3}\s?\d{3}$" Font-Bold="False" ValidationGroup="1"></asp:RegularExpressionValidator>
                                    <asp:TextBox ID="mobileTxt" runat="server" Text='<%# Eval("mobile").ToString().Trim() %>' CssClass="form-control" Font-Bold="False" ValidationGroup="1"></asp:TextBox>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="emailLbl" runat="server" Text="Email: " Font-Bold="True"></asp:Label>
                                    <asp:TextBox ID="emailTxt" runat="server" Text='<%# Eval("email").ToString().Trim() %>' CssClass="form-control" Font-Bold="False" Enabled="False"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group" style="margin-top: 10px">
                                <asp:Button ID="saveBtn" runat="server" Text="Save Changes" CssClass="btn btn-success form-control" OnClick="saveBtn_Click1" ValidationGroup="1" OnClientClick="return confirm('Are you sure you want to make changes to your account details?')" />
                            </div>
                            <div class="form-group" style="margin-top: 10px">
                                <asp:Button ID="cancelBtn" runat="server" Text="Cancel" CssClass="btn btn-warning form-control" OnClinetClick="window.history.back();" OnClick="cancelBtn_Click" ValidationGroup="1" />
                            </div>

                        </fieldset>
                    </ItemTemplate>
                </asp:DataList>
            </div>

            <div class="col-md-4">
                <asp:Label ID="messageLbl" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                <div class="panel panel-default" style="border: 1px ridge #666666; background-color: #F0FFF0; margin-bottom: 10px;">
                    <div class="panel-body">
                        <div class="text-center">
                            <h3><i class="fa fa-lock fa-4x"></i></h3>
                            <h2 class="text-center">Change a password?</h2>
                            <p>You can reset your password here.</p>
                            <div class="panel-body">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                        <asp:TextBox ID="oldPasswordTxt" runat="server" CssClass="form-control" placeholder="Enter current password" Font-Bold="False" TextMode="Password" ValidationGroup="2"></asp:TextBox>
                                    </div>
                                     <asp:RequiredFieldValidator ID="oldPassReqVal" runat="server" ControlToValidate="oldPasswordTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False" ValidationGroup="2"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                        <asp:TextBox ID="newPasswordTxt" runat="server" CssClass="form-control" placeholder="Enter new password" Font-Bold="False" TextMode="Password" ValidationGroup="2"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="newPassReqVal" runat="server" ControlToValidate="newPasswordTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False" ValidationGroup="2"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Button ID="resetBtn" runat="server" Text="Reset Password" CssClass="form-control btn btn-primary" Font-Size="Medium" OnClick="resetBtn_Click" ValidationGroup="2" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4 text-center" style="margin-bottom: 10px">
                <a href="orderHistory.aspx" style="font-size: large; font-weight: bold;">See My Order History</a>
            </div>
        </div>

    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="selectCustomer" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="username" SessionField="username" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:DataList ID="customerUpdatedDataList" runat="server" DataKeyField="customerID" DataSourceID="customerUpdatedDataSource" Visible="False">
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

    <asp:SqlDataSource ID="customerUpdatedDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Customers]"></asp:SqlDataSource>

</asp:Content>