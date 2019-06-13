<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container">
        <div class="registerHeader">
            <h3><b>Login Here</b></h3>
            <h5><i style="color: #FF0000">Please use the email which you used to register to us, in the username field.</i></h5>
        </div>

        <div class="row">
            <div class="col-md-6">
                <asp:Label ID="incorrectLoginLbl" runat="server" Font-Bold="True" Font-Italic="True" ForeColor="Red"></asp:Label>
                <fieldset>
                    <div class="form-group">
                        <label for="username"><span class="req">* </span>Username: </label>
                        <asp:RequiredFieldValidator ID="usernameReqVal" runat="server" ControlToValidate="usernameTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False">This is Required!</asp:RequiredFieldValidator>
                        <asp:TextBox ID="usernameTxt" runat="server" CssClass="form-control" placeholder="please enter your username here.." Font-Bold="False"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="password"><span class="req">* </span>Password: </label>
                        <asp:RequiredFieldValidator ID="passwordReqVal" runat="server" ControlToValidate="passwordTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False">This is Required!</asp:RequiredFieldValidator>
                        <asp:TextBox ID="passwordTxt" runat="server" CssClass="form-control" placeholder="please enter your password here.." TextMode="Password" Font-Bold="False"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="validation"><span class="req">* </span>Anti-bot Validation: </label>
                        <asp:RequiredFieldValidator ID="charactersReqVal" runat="server" ControlToValidate="charactersTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False">This is Required!</asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="charsCompVal" runat="server" ControlToValidate="charactersTxt" ErrorMessage="***ERROR: Characters do not match!" ForeColor="Red" ValueToCompare="g&amp;KO0pq#!" Font-Bold="False"></asp:CompareValidator>
                        <br />
                        <asp:Label ID="charsToValidateLbl" runat="server" Text="g&KO0pq#!" BackColor="#FFFFCC" BorderColor="#669999" BorderStyle="None" Font-Size="18pt" ForeColor="#00CC00" Font-Bold="False"></asp:Label>
                        <asp:Label ID="valInfoLbl" runat="server" Font-Italic="True" ForeColor="#9900FF" Text="Type the characters you see, in the textbox!"></asp:Label>
                        <asp:TextBox ID="charactersTxt" runat="server" CssClass="form-control" placeholder="please type in the characters here.." Font-Bold="False"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <asp:Button ID="submitBtn" runat="server" Text="Login" CssClass="btn btn-success" OnClick="submitBtn_Click" />
                        <asp:Button ID="resetBtn" runat="server" Text="Reset" CssClass="btn btn-warning" OnClientClick="this.form.reset(); return true;" />

                        <a href="forgotPassword.aspx" style="margin-left: 10px">Forgotton account?</a>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
</asp:Content>