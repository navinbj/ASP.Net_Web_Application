using System;
using System.Web;
using System.Web.Security;

public partial class register : System.Web.UI.Page
{
    //creating a new instance of class Login.
    Login login = new Login();
    Mail mail = new Mail();

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void submitBtn_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            //if the page validation is successful, then do the following...

            //get the values from textboxes entered by a user and store them in the local variables.
            String firstName = firstNameTxt.Text;
            String lastName = lastNameTxt.Text;
            String street = addressStreetTxt.Text;
            String city = cityTxt.Text;
            String postcode = postcodeTxt.Text;
            String mobile = mobileTxt.Text;
            String email = emailTxt.Text;
            String password = passwordTxt.Text;

            //hashing the password and storing it into a new local variable.
            String passwordEncrypt = FormsAuthentication.HashPasswordForStoringInConfigFile(password, "SHA1");

            bool test;

            //calling the checkEmail method of a Login class by passing the email enetered by the user.
            test = login.checkEmail(email);
            if (test)
            {
                //if the email matches the one already in the database, the registration is unsuccessful
                //because a user cannot register twice with the same email.
                statusLbl.Text = "***Email already in use!";
            }
            else
            {
                //if the email is distinct from the one in the database, then insert the user into the database.
                string mySql;
                mySql = "insert into Customers (firstName,lastName,address_street,address_city,postcode,mobile,email,password)" +
                    "values ('" + firstName + "','" + lastName + "','" + street + "','" + city + "','" + postcode + "','" + mobile + "','" +
                    email + "','" + passwordEncrypt + "')";
                SqlDataSource1.SelectCommand = mySql;
                customersDataList.DataBind();

                //sending an email to the user to let them know of successful registration.
                //the email will also notify the user about their account details and where to login.
                string fromEmail = "nbajgai@gmail.com";
                string toEmail = emailTxt.Text;
                string localHost = HttpContext.Current.Request.Url.Authority.ToString();
                string mailSubject = "Your Navin's Wordery Registration";
                string mailBody = "Dear " + firstNameTxt.Text + ",\n\n"
                    + "Your registration has been successful!\n"
                    + "Welcome to Navin's Wordery Limited- Online Books Store.\n"
                    + "Manage your personal information from the 'My Account' page when you login to our website. You simply need to click on your email/ username to view your details.\n"
                    + "You can change your contact details and password, track recent orders and add alternative delivery addresses.\n"
                    + "To visit your 'My Account' page go to http://" + localHost + "/login.aspx."
                    + "\n\n"

                    + "YOUR DETAILS HERE.........please keep track of them!\n"
                    + "----------------------------------------------------------------------\n"
                    + "First Name: " + firstNameTxt.Text + "\n"
                    + "Last Name: " + lastNameTxt.Text + "\n"
                    + "Address: " + addressStreetTxt.Text + ", " + cityTxt.Text + ", " + postcodeTxt.Text + "\n"
                    + "Mobile: " + mobileTxt.Text + "\n"
                    + "Password: " + passwordConfirmTxt.Text + "\n\n"
                    + "Thanks\n"
                    + "Navin's Wordery Ltd\n"
                    + "Customer Service Team\n"
                    + "01234567898";

                //calling the sendMail method of mail class to send email to the customer.
                mail.sendMail(fromEmail, toEmail, mailSubject, mailBody);

                statusLbl.Text = "REGISTRATION SUCCESSFUL: Please check you email for more details!";
                statusLbl.ForeColor = System.Drawing.Color.Green;
                Response.AddHeader("REFRESH", "5;URL=register.aspx");
            }
        }
    }

    protected void resetBtn_Click(object sender, EventArgs e)
    {
        
    }
}