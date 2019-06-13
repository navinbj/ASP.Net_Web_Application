using System;
using System.Web.Security;

public partial class login : System.Web.UI.Page
{
    //creating a new instance of class Login
    Login cusLogin = new Login();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void submitBtn_Click(object sender, EventArgs e)
    {
        bool test;  //a boolean variable to store eithe true or a false. 

        String username = usernameTxt.Text;
        String password = passwordTxt.Text;

        //hashing the password and storing it into a new local variable.
        String passwordEncrypt = FormsAuthentication.HashPasswordForStoringInConfigFile(password, "SHA1");

        if (charactersTxt.Text.Equals(charsToValidateLbl.Text))
        {
            //calling a authenticateLogin function of class Login and then providing the inputs 
            //entered by a user to the parameters.
            test = cusLogin.authenticateUsersViaDatabase(username, passwordEncrypt);

            if (test)
            {
                Session["username"] = username;     //creating a session variable for username. 
                int cusID = cusLogin.getCustomerID(username);
                Session["customerID"] = cusID;      //creating a session variable for customer ID. 

                System.Web.Security.FormsAuthentication.RedirectFromLoginPage(usernameTxt.Text, false);
                Response.Redirect("Default.aspx");
            }
            else
            {
                incorrectLoginLbl.Text = "***ERROR: Incorrect Username or Password !";
            }
        }
        else
        {
            //***ERROR: Characters do not match!;
        }
    }
}