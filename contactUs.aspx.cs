using System;

public partial class contactUs : System.Web.UI.Page
{
    //creating a new instance of Mail class.
    Mail mail = new Mail();

    protected void Page_Load(object sender, EventArgs e)
    {
        //getting the username session variable of a logged in customer.
        if (Session["username"] != null)
        {
            emailTxt.Text = Session["username"].ToString();
        }
    }

    protected void submitBtn_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            //if the page validation is all complete and succeeded,then send the email..
            string fromEmail = emailTxt.Text;
            string senderName = nameTxt.Text;
            string message = messageTxt.Text;
            string toEmail = "nbajgai@gmail.com";
            string mailSubject = subjectTxt.Text;
            string mailBody = "From: " + fromEmail + "\n"
                + "--------------------------------------------\n"
                + "Sender Full Name: " + senderName + "\n"
                + "--------------------------------------------\n"
                + "To: " + toEmail + "\n"
                + "--------------------------------------------\n"
                + "\n"
                + "Message:\n"
                + "--------------------------------------------\n"
                + message;

            //calling the sendMail method of mail class to send email to the customer.
            mail.sendMail(fromEmail, toEmail, mailSubject, mailBody);

            lblStatus.Text = "SUCCESS: Thanks for your message!";
            lblStatus.ForeColor = System.Drawing.Color.Green;
            Response.AddHeader("REFRESH", "3;URL=contactUs.aspx");
        }
    }
}