using System;

public partial class logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //this removes the form authentication ticket from the browser.
        System.Web.Security.FormsAuthentication.SignOut();

        //cancelling the current session.
        Session.Abandon();

        //redirecting user back to login page.
        Response.Redirect("login.aspx");
    }
}