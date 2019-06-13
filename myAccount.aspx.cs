using System;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;

public partial class myAccount : System.Web.UI.Page
{
    //creating a new instance of a Login class.
    Login login = new Login();
    Mail mail = new Mail();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void customerDataList_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void saveBtn_Click1(object sender, EventArgs e)
    {
        //local variables for storing all customer related data.
        string customerID = "";
        string address = "";
        string city = "";
        string postcode = "";
        string mobile = "";
        string email = "";
        string firstName = "";
        string lastName = "";

        //looping through the datalist that contains all the information about a customer in a current session.
        foreach (DataListItem item in customerDataList.Items)
        {
            //finding the controls that contain different types of information about a customer and storing them in the local variables..
            Label cusIDLbl = (Label)item.FindControl("cusIDLbl");
            customerID = cusIDLbl.Text;

            TextBox addressTxt = (TextBox)item.FindControl("addressTxt");
            address = addressTxt.Text;

            TextBox cityTxt = (TextBox)item.FindControl("cityTxt");
            city = cityTxt.Text;

            TextBox postcodeTxt = (TextBox)item.FindControl("postcodeTxt");
            postcode = postcodeTxt.Text;

            TextBox mobileTxt = (TextBox)item.FindControl("mobileTxt");
            mobile = mobileTxt.Text;

            TextBox emailTxt = (TextBox)item.FindControl("emailTxt");
            email = emailTxt.Text;

            TextBox firstNameTxt = (TextBox)item.FindControl("firstNameTxt");
            firstName = firstNameTxt.Text;

            TextBox lastNameTxt = (TextBox)item.FindControl("lastNameTxt");
            lastName = lastNameTxt.Text;
        }

        string updateQuery;
        //sql update query for updating the customer details in the Customers class.
        updateQuery = "update Customers set address_street = '" + address + "', address_city = '" + city + "', postcode = '" + postcode + "', mobile = '" + mobile + "' where customerID = " + customerID;
        customerUpdatedDataSource.SelectCommand = updateQuery;
        customerUpdatedDataList.DataBind();

        //sending email to the customer notifying them of the account update.
        string fromEmail = "nbajgai@gmail.com";
        string toEmail = email;
        string localHost = HttpContext.Current.Request.Url.Authority.ToString();
        string mailSubject = "Successful Update of your Navin's Wordery Account";
        string mailBody = "Dear " + firstName + ",\n\n"
            + "It has come to our attention that you have recently updated your Navin's Wordery's account details.\n"
            + "We hope that it was you who updated your account details.\n"
            + "If that wasn't you, please contact our customer service on the contact details mentioned in the email.\n"
            + "However, if that was you, please keep track of your updated account details.\n\n"
            + "YOUR NEW ACCOUNT DETAILS HERE...\n"
            + "----------------------------------------------------------------------\n"
            + "First Name: " + firstName + "\n"
            + "Last Name: " + lastName + "\n"
            + "Address: " + address + ", " + city + ", " + postcode + "\n"
            + "Mobile: " + mobile + "\n\n\n"
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

        statusLbl.Text = "ACCOUNT DETAILS UPDATE SUCCESSFUL" + "<br />" + "Please check you email for more details!";
        Response.AddHeader("REFRESH", "4");
    }

    protected void cancelBtn_Click(object sender, EventArgs e)
    {
        
    }

    protected void resetBtn_Click(object sender, EventArgs e)
    {
        string customerID = "";
        string oldPassword = oldPasswordTxt.Text;

        //hashing the password and storing it into a new local variable.
        string oldPasswordHashed = FormsAuthentication.HashPasswordForStoringInConfigFile(oldPassword, "SHA1");

        string newPassword = newPasswordTxt.Text;
        string newPasswordHashed = "";
        string email = "";
        string firstName = "";

        //looping through the datalist that contains all the information about a customer in a current session.
        foreach (DataListItem item in customerDataList.Items)
        {
            Label cusIDLbl = (Label)item.FindControl("cusIDLbl");
            customerID = cusIDLbl.Text;

            TextBox emailTxt = (TextBox)item.FindControl("emailTxt");
            email = emailTxt.Text;

            TextBox firstNameTxt = (TextBox)item.FindControl("firstNameTxt");
            firstName = firstNameTxt.Text;
        }

        //calling a checkPassword method of a Login class to check if the password enetered by a customer matches
        //against the record in the database.
        bool isValidPassword = login.checkPassword(oldPasswordHashed, System.Convert.ToInt32(customerID));

        if(isValidPassword)
        {
            //if the password matches, then hash the password first (decrypting this time)
            newPasswordHashed = FormsAuthentication.HashPasswordForStoringInConfigFile(newPassword, "SHA1");

            //now simply update the password for a specified customer. 
            string updatePasswordQuery = "";
            updatePasswordQuery = "update Customers set password = '" + newPasswordHashed + "' where customerID = " + customerID;
            customerUpdatedDataSource.SelectCommand = updatePasswordQuery;
            customerUpdatedDataList.DataBind();

            messageLbl.ForeColor = System.Drawing.Color.Green;
            messageLbl.Text = "Password reset successful!";
            Response.AddHeader("REFRESH", "4");

            //sending email to the customer notifying them of the password reset.
            string fromEmail = "nbajgai@gmail.com";
            string toEmail = email;
            string localHost = HttpContext.Current.Request.Url.Authority.ToString();
            string mailSubject = "Password Changed for Navin's Wordery Account";
            string mailBody = "Dear " + firstName + ",\n\n"
                + "Thank you for resetting your password because we always encourage our customer to reset their password often, atleast every 3 months, for security purposes.\n"
                + "Please keep track of your new password as you would need it to log into our website.\n\n"
                + "YOUR NEW PASSWORD IS..." + newPassword + "\n\n\n"
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
            messageLbl.ForeColor = System.Drawing.Color.Red;
            messageLbl.Text = "**Cannot reset: your old password is invalid!";
        }
    }
}