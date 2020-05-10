using System;
using System.Net;
using System.Net.Mail;

/// <summary>
/// The class Mail uses a SMTP server for sending email messages to peoples inlcluding customers, etc.
/// </summary>
public class Mail
{
    //fields needed for a Mail system to work. 
    private string smtpServer;
    private int smtpPort;
    private string smtpUsername;
    private string smtpPassword;

    //constructor for the objects of class Mail
    public Mail()
    {
        smtpServer = "smtp.gmail.com";      //smtp server to be passed in the initialisation of smtp client class.
        smtpPort = 587;     //smtp port to be passed in the initialisation of smtp client class.
        smtpUsername = "";
        smtpPassword = "";
    }

    //method for sending email to people, mainly customers when specified the mail requirements like sender, reciever, subject and body in the parameter.
    public void sendMail(string fromEmail, string toEmail, string mailSubject, string mailMessage)
    {
        //this represents an email message that can be sent using smtp client.
        MailMessage mail = new MailMessage(fromEmail, toEmail);
        mail.Subject = mailSubject;     //this represents the subject of an email.
        mail.Body = mailMessage;        //this represents the body of an email.

        //initialising the new instance of SMTP client class which is to be used for sending email by passing the smtp server and port number in parameters.
        SmtpClient client = new SmtpClient(smtpServer, smtpPort);
        client.UseDefaultCredentials = false;
        client.EnableSsl = true;    //enabling the SSL for encrypting the connection.
        client.Credentials = new NetworkCredential(smtpUsername, smtpPassword);     //using the credentials to authenticate the user.

        try
        {
            client.Send(mail);  //sending the mail message to SMTP server for delivery.
        }
        catch (Exception exp)
        {
            Console.WriteLine(exp.Message);
        }
    }
}
