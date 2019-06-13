<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="register
    " %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container">
        <div class="registerHeader">
            <h3><b>Register Here</b></h3>
            <h5><i style="color: #FF0000">Please note that all fields are mandatory* </i>
            </h5>
        </div>

        <div class="row">
            <div class="col-md-6">
                <asp:Label ID="statusLbl" runat="server" Font-Bold="True" Font-Italic="True" ForeColor="Red"></asp:Label>
                <fieldset>
                    <div class="form-group">
                        <label for="firstName"><span class="req">* </span>First Name/s: </label>
                        <asp:RequiredFieldValidator ID="firstNameReqVal" runat="server" ControlToValidate="firstNameTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False">This is Required!</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="firstNameRegExVal" runat="server" ControlToValidate="firstNameTxt" ErrorMessage="***ERR: not a valid name!" ForeColor="Red" ValidationExpression="[A-Za-z ]*" Font-Bold="False"></asp:RegularExpressionValidator>
                        <asp:TextBox ID="firstNameTxt" runat="server" CssClass="form-control" placeholder="please enter your first name/s here.." Font-Bold="False"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="lastName"><span class="req">* </span>Last Name: </label>
                        <asp:RequiredFieldValidator ID="lastNameReqVal" runat="server" ControlToValidate="lastNameTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False">This is Required!</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="lastNameRegExVal" runat="server" ControlToValidate="lastNameTxt" ErrorMessage="***ERR: not a valid name!" ForeColor="Red" ValidationExpression="[A-Za-z]*" Font-Bold="False"></asp:RegularExpressionValidator>
                        <asp:TextBox ID="lastNameTxt" runat="server" CssClass="form-control" placeholder="please enter your last name here.." Font-Bold="False"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="address"><span class="req">* </span>Address (street): </label>
                        <asp:RequiredFieldValidator ID="streetReqVal" runat="server" ControlToValidate="addressStreetTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False">This is Required!</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="addressRegExVal" runat="server" ControlToValidate="addressStreetTxt" ErrorMessage="***ERR: not a valid address!" ForeColor="Red" ValidationExpression="^\d+\s[A-z]+\s[A-z]+" Font-Bold="False"></asp:RegularExpressionValidator>
                        <asp:TextBox ID="addressStreetTxt" runat="server" CssClass="form-control" placeholder="please enter your street number and name here.." Font-Bold="False"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="city"><span class="req">* </span>City/ Town: </label>
                        <asp:RequiredFieldValidator ID="cityReqVal" runat="server" ControlToValidate="cityTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False">This is Required!</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="cityRegExVal" runat="server" ControlToValidate="cityTxt" ErrorMessage="***ERR: not a valid city name!" ForeColor="Red" ValidationExpression="[A-Za-z ]*" Font-Bold="False"></asp:RegularExpressionValidator>
                        <asp:TextBox ID="cityTxt" runat="server" CssClass="form-control" placeholder="please enter your city or town name.." Font-Bold="False"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="postcode"><span class="req">* </span>Postcode: </label>
                        <asp:RequiredFieldValidator ID="postcodeReqVal" runat="server" ControlToValidate="postcodeTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False">This is Required!</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="postcodeRegExVal" runat="server" ControlToValidate="postcodeTxt" ErrorMessage="***ERR: not a valid postcode!" ForeColor="Red" ValidationExpression="^[A-Z]{1,2}[0-9]{1,2}[A-Z]?\s[0-9][A-Z][A-Z]$" Font-Bold="False"></asp:RegularExpressionValidator>
                        <asp:TextBox ID="postcodeTxt" runat="server" CssClass="form-control" placeholder="please enter your postcode here.." Font-Bold="False"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="mobile"><span class="req">* </span>Mobile: </label>
                        <asp:RequiredFieldValidator ID="mobileReqVal" runat="server" ControlToValidate="mobileTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False">This is Required!</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="mobileRegExVal" runat="server" ControlToValidate="mobileTxt" ErrorMessage="***ERR: not a valid mobile number!" ForeColor="Red" ValidationExpression="^(\+44\s?7\d{3}|\(?07\d{3}\)?)\s?\d{3}\s?\d{3}$" Font-Bold="False"></asp:RegularExpressionValidator>
                        <asp:TextBox ID="mobileTxt" runat="server" CssClass="form-control" placeholder="please enter your mobile number.." Font-Bold="False"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="email"><span class="req">* </span>Email:  <small>This will be your login user name</small></label>
                        <asp:RequiredFieldValidator ID="emailReqVal" runat="server" ControlToValidate="emailTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False">This is Required!</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="emailRegExVal" runat="server" ControlToValidate="emailTxt" ErrorMessage="***ERR: not a valid email address!" ForeColor="Red" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" Font-Bold="False"></asp:RegularExpressionValidator>
                        <asp:TextBox ID="emailTxt" runat="server" CssClass="form-control" placeholder="please enter your email address here.." TextMode="Email" Font-Bold="False"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="password"><span class="req">* </span>Password: </label>
                        <asp:RequiredFieldValidator ID="passwordReqVal" runat="server" ControlToValidate="passwordTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False">This is Required!</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="passwordRegExVal" runat="server" ControlToValidate="passwordTxt" ErrorMessage="***ERR: not a valid password pattern!" ForeColor="Red" ValidationExpression="[A-Za-z ]*" Font-Bold="False"></asp:RegularExpressionValidator>
                        <asp:TextBox ID="passwordTxt" runat="server" CssClass="form-control" placeholder="please enter your new password here.." TextMode="Password" Font-Bold="False"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="passwordConfirm"><span class="req">* </span>Password Confirm: </label>
                        <asp:RequiredFieldValidator ID="passwordConfirmReqVal" runat="server" ControlToValidate="passwordConfirmTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False">This is Required!</asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="passwordTxt" ControlToValidate="passwordConfirmTxt" ErrorMessage="Passwords do not match!" ForeColor="Red" Font-Bold="False"></asp:CompareValidator>
                        <asp:TextBox ID="passwordConfirmTxt" runat="server" CssClass="form-control" placeholder="please enter your password again here.." TextMode="Password" Font-Bold="False"></asp:TextBox>
                    </div>


                    <div class="form-group">
                        <label for="validation"><span class="req">* </span>Anti-bot Validation: </label>
                        <asp:RequiredFieldValidator ID="charactersReqVal" runat="server" ControlToValidate="charactersTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False">This is Required!</asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="charsCompVal" runat="server" ControlToValidate="charactersTxt" ErrorMessage="***ERROR: Characters do not match!" ForeColor="Red" ValueToCompare="g&amp;KO0pq#!" Font-Bold="False"></asp:CompareValidator>
                        <br />
                        <asp:Label ID="charsToValidateLbl" runat="server" Text="g&KO0pq#!" BackColor="#FFFFCC" BorderColor="#669999" BorderStyle="None" Font-Size="18pt" ForeColor="#00CC00" Font-Bold="False"></asp:Label>
                        <asp:Label ID="valInfoLbl" runat="server" Font-Italic="True" ForeColor="#9900FF" Text="Type the characters you see, in the textbox!"></asp:Label>
                        <asp:TextBox ID="charactersTxt" runat="server" CssClass="form-control" placeholder="please type in the characters here.." Font-Bold="False"></asp:TextBox>
                        <asp:DataList ID="customersDataList" runat="server" DataSourceID="SqlDataSource1" Visible="False">
                            <ItemTemplate>
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
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [firstName], [lastName], [address_street], [address_city], [postcode], [mobile], [email], [password] FROM [Customers]"></asp:SqlDataSource>
                    </div>

                    <div class="form-group">
                        <asp:Button ID="submitBtn" runat="server" Text="Register" CssClass="btn btn-success" OnClick="submitBtn_Click" />
                        <asp:Button ID="resetBtn" runat="server" Text="Reset" CssClass="btn btn-warning" OnClick="resetBtn_Click" OnClientClick="this.form.reset(); return true;" />
                    </div>
                </fieldset>
                <!-- ends register form -->
            </div>
            <!-- ends col-6 -->

        </div>
    </div>
</asp:Content>
