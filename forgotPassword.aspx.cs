using System;
using System.Web;
using System.Web.Security;

public partial class forgotPassword : System.Web.UI.Page
{
    //creating a new instance of a Login class.
    Login login = new Login();

    //creating a new instance of a Mail class
    Mail mail = new Mail();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void resetBtn_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            //if the page validation is successful, then do the following...

            String email = emailTxt.Text;
            String password = passwordTxt.Text;
            
            //hashing the password and storing it into a new local variable.
            String passwordHashed = FormsAuthentication.HashPasswordForStoringInConfigFile(password, "SHA1");

            //calling the checkEmail method of login class to check if the email entered by a user is valid.
            bool test = login.checkEmail(email);

            if (test)
            {
                //if the email matches against the record in the database, then update the password for the user.
                string updatePasswordQuery;
                updatePasswordQuery = "update Customers set password = '" + passwordHashed + "' where email = '" + email + "'";

                customersDataSource.SelectCommand = updatePasswordQuery;
                customersDataList.DataBind();

                statusLbl.ForeColor = System.Drawing.Color.Green;
                statusLbl.Text = "Password Reset Successful!" + "<br />" + "You may now login with your new password.";
                Response.AddHeader("REFRESH", "5;URL=login.aspx");

                //sending email to the customer notifying them of the password reset.
                string fromEmail = "nbajgai@gmail.com";
                string toEmail = email;
                string localHost = HttpContext.Current.Request.Url.Authority.ToString();
                string mailSubject = "Password Reset Successful - Navin's Wordery Account";
                string mailBody = "Dear " + email + ",\n\n"
                    + "Thank you for resetting your password because we always encourage our customer to reset their password often, atleast every 3 months, for security purposes.\n"
                    + "Please keep track of your new password as you would need it to log into our website.\n\n"
                    + "YOUR NEW PASSWORD IS..." + password + "\n\n\n"
                    + "Manage your personal information from the 'My Account' page when you login to our website. You simply need to click on your email/ username to view your details.\n"
                    + "You can change your contact details and password, track recent orders and add alternative delivery addresses.\n"
                    + "To visit your 'My Account' page go to http://" + localHost + "/login.aspx."
                    + "\n\n\n"
                    + "Thanks\n"
                    + "Navin's Wordery Ltd\n"
                    + "Customer Service Team\n"
                    + "01234567898";

                //calling the sendMail method of mail class to send email to the customer.
                mail.sendMail(fromEmail, toEmail, mailSubject, mailBody);
            }
            else
            {
                statusLbl.ForeColor = System.Drawing.Color.Red;
                statusLbl.Text = "***ERROR: username/email not recognized!";
            }
        }
    }
}