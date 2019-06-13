using System;

public partial class orderHistory : System.Web.UI.Page
{
    string customerID = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        //save the session username and customerID into variables on the page load, if the customer is logged in.
        //the customerID is used in the stored procedure for displaying the purchase history for a specified customer.
        if (Session["username"] != null && Session["customerID"] != null)
        {
            customerID = Session["customerID"].ToString();
            customerIDLbl.Text = customerID;
        }
    }
}