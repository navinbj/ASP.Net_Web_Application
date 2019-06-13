<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="contactUs.aspx.cs" Inherits="contactUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="jumbotron jumbotron-list" style="background-color: #358CCE; color: #FFF; padding-top: 10px; padding-bottom: 15px; margin-bottom: 10px;">
        <div class="container">
            <div class="row">
                <div class="col-sm-12 col-lg-12" style="color: #FFFFFF">
                    <h1 class="h1">Contact us <small style="color: #CCCCCC">Feel free to contact us</small></h1>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <div class="well well-sm">
                    <form>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="nameLbl">Name </label>
                                    <asp:RequiredFieldValidator ID="nameReqVal" runat="server" ControlToValidate="nameTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False">This is Required!</asp:RequiredFieldValidator>
                                    <asp:TextBox ID="nameTxt" runat="server" CssClass="form-control" placeholder="please enter your name here.." Font-Bold="False"></asp:TextBox>
                                </div>

                                <div class="form-group">
                                    <label for="emailLbl">Email </label>
                                    <asp:RequiredFieldValidator ID="emailReqVal" runat="server" ControlToValidate="emailTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False">This is Required!</asp:RequiredFieldValidator>
                                    <asp:TextBox ID="emailTxt" runat="server" CssClass="form-control" placeholder="please enter your email here.." Font-Bold="False"></asp:TextBox>
                                </div>

                                <div class="form-group">
                                    <label for="subjectLbl">Subject </label>
                                    <asp:RequiredFieldValidator ID="subjectReqVal" runat="server" ControlToValidate="subjectTxt" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False">This is Required!</asp:RequiredFieldValidator>
                                    <asp:TextBox ID="subjectTxt" runat="server" CssClass="form-control" placeholder="please enter your subject here.." Font-Bold="False"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="name">Message </label>
                                    <asp:RequiredFieldValidator ID="messageReqVal" runat="server" ErrorMessage="This is Required!" ForeColor="Red" Font-Bold="False" ControlToValidate="messageTxt">This is Required!</asp:RequiredFieldValidator>
                                    <asp:TextBox ID="messageTxt" runat="server" CssClass="form-control" placeholder="please enter your message here.." Font-Bold="False" Columns="25" Rows="8" TextMode="MultiLine"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <asp:Button ID="submitBtn" runat="server" Text="Send Message" CssClass="btn btn-primary form-control" OnClick="submitBtn_Click" />
                                <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-md-4">
                <form>
                    <legend><span class="glyphicon glyphicon-globe"></span>Our office</legend>
                    <address>
                        <strong>Navin's Wordery Limited</strong><br>
                        18 Stevenson Road<br>
                        The Cresent, Salford<br>
                        M12 5GD<br>
                        <abbr title="Phone">
                            Phone:</abbr>
                        (123) 456-7890
           
                    </address>
                    <address>
                        <strong>Email Us</strong><br>
                        <a href="mailto:#">N.Bajgai@edu.salford.ac.uk</a>
                    </address>
                </form>
            </div>
        </div>
    </div>
</asp:Content>
