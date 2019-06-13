using System;
using System.Web;
using System.Web.UI.WebControls;

public partial class basket : System.Web.UI.Page
{
    //fields for storing the books and basket related data.
    int customerID = 0;
    int quantityInBasket = 0;
    String qtyToUpdate = "";
    int quantityToUpdate = 0;
    int availableQuantity = 0;
    String productID = "";
    double totalPrice = 0;
    double newTotalPrice = 0;
    double grandTotal = 0;
    string username = "";
    double num = 0;

    //creating a new instance of Mail class.
    Mail mail = new Mail();

    protected void Page_Load(object sender, EventArgs e)
    {
        //save the session username and customerID into variables on the page load, if the customer is logged in.
        //the customerID is used in the stored procedure for displaying the basket data for a specified customer.
        if (Session["username"] != null && Session["customerID"] != null)
        {
            String tempID = Session["customerID"].ToString();
            customerID = System.Convert.ToInt32(tempID);
            username = Session["username"].ToString();

            headerLbl.Text = "Your Items: ";
        }
        else
        {
            usernameLbl.Text = "Please login first!";
        }
        cusIDTxt.Text = customerID.ToString();

        //for displaying the grand total price of the customer basket.
        if (DataList1.Items.Count > 0)
        {
            //finding the label that holds the sum of the total prices for all items in the basket. 
            //the totalPriceInBasketFormView returns the sum of totalPrice column in the basket table for a specified customer.
            Label grandTotalLabel = (Label)totalPriceInBasketFormView.FindControl("grandTotalLbl");
            String grandTotalString = grandTotalLabel.Text;

            if (double.TryParse(grandTotalString, out num))
            {
                //this formats the number to only display the first four digits and ignore the rest.
                grandTotal = System.Convert.ToDouble(num.ToString("F4"));
            }

            //setting the text of grandTotalLabel to the actual grand total price.
            grandTotalLbl.Text = "Total Price: £" + grandTotal;
        }
    }

    protected void clearBtn_Click(object sender, EventArgs e)
    {
        string deleteAllBasketQuery;

        // the SQL query for deleting item from the basket when specified the customer.
        deleteAllBasketQuery = "delete from Basket where customerID=" + customerID;

        //giving the sql data source a query so that the query will be executed. 
        basketDataSource.SelectCommand = deleteAllBasketQuery;
        basketDataList.DataBind();  //binding or saving the data list after making changes to it so that it remains up-to-date. 
        Response.Redirect("basket.aspx");
    }

    protected void checkoutBtn_Click(object sender, EventArgs e)
    {
        //local variables for temporarily storing the information about the item/s in the basket which are to be checked out.
        double pricePerQty = 0;
        double totalPrice = 0;
        string productName = "";
        string author = "";

        //looping through the items in the basket data list that a customer currently has..
        foreach (DataListItem item in DataList1.Items)
        {
            //finding the controls in the basket data list that holds the information about each item in the basket and then
            //storing them into the fields/ variables.

            TextBox qtyTxt = (TextBox)item.FindControl("quantityToUpdateTxt");
            qtyToUpdate = qtyTxt.Text;

            Label productIDLbl = (Label)item.FindControl("bookIDLbl");
            productID = productIDLbl.Text;

            Label productNameLbl = (Label)item.FindControl("titleLbl");
            productName = productNameLbl.Text;

            Label authorLbl = (Label)item.FindControl("authorLbl");
            author = authorLbl.Text;

            Label priceLbl = (Label)item.FindControl("priceLbl");
            String tempPrice = priceLbl.Text;
            pricePerQty = System.Convert.ToDouble(tempPrice);

            Label totalPriceLbl = (Label)item.FindControl("totalPriceLbl");
            String tempTotalPrice = totalPriceLbl.Text;
            totalPrice = System.Convert.ToDouble(tempTotalPrice);

            Label availableQtyLbl = (Label)item.FindControl("availableQtyLbl");
            String availableQty = availableQtyLbl.Text;
            availableQuantity = System.Convert.ToInt32(availableQty);

            Label qtyInBasketLbl = (Label)item.FindControl("qtyInBasketLbl");
            String qtyInBasket = qtyInBasketLbl.Text;
            quantityInBasket = System.Convert.ToInt32(qtyInBasket);

            //checking to make sure if the quantity customer wants to checkout is more or less than the available quantity
            if (quantityInBasket > availableQuantity)
            {
                //displaying the warning message if the quantity to be checked out is more than the available quantity.
                messageLbl.ForeColor = System.Drawing.Color.Black;
                messageLbl.BackColor = System.Drawing.Color.Yellow;
                messageLbl.Text = "Sorry, this item is not currently available to checkout: " + productID + ". It may be because another customer has already purchased it and that there is not enough quantity left in the stock." + "<br />" +
                    "You want: " + quantityInBasket + "<br />" +

                    "Currently Available: " + availableQuantity + "<br />" +
                    "Please try updating the quantity and then checkout again!";
            }
            else
            {
                //do the following things if the quantity at checkout is less than or equal to available quantity..
                messageLbl.ForeColor = System.Drawing.Color.Green;
                messageLbl.BackColor = System.Drawing.Color.White;
                messageLbl.Font.Bold = true;
                messageLbl.Text = "Thanks for your purchase, see you soon again!";

                string dateTime = DateTime.Now.ToLocalTime().ToString();    //getting the current local date and time.

                string insertOrderHistoryQuery;
                //an SQL query for inserting the basket data into a OrderHistory table.
                insertOrderHistoryQuery = "insert into OrderHistory (quantity, pricePerQuantity, totalPrice, dateTime, productID, customerID) values(" + quantityInBasket + "," + pricePerQty + "," + totalPrice + ", '" + dateTime + "','" + productID + "'," + customerID + ")";

                //giving the sql data source a query so that the query will be executed.
                orderHistoryDataSource.SelectCommand = insertOrderHistoryQuery;
                orderHistoryDataSet.DataBind();     //binding or saving the data list after making changes to it so that it remains up-to-date.

                //an SQL query for updating the quantity of the books in Books table after the checkout.
                //the query will simply deduct the quantity this is checked out from the available quantity in the Books table.
                string updateBookQuantityQuery = "update Books set quantity = quantity-" + quantityInBasket + "where iSBNNo = '" + productID + "'";
                booksDataSource.SelectCommand = updateBookQuantityQuery;
                booksDataList.DataBind();

                string deleteItemQuery;
                //finally, an SQL query for deleteting the checked out items from the basket. 
                deleteItemQuery = "delete from Basket where customerID=" + customerID + "and productID='" + productID + "'";
                basketDataSource.SelectCommand = deleteItemQuery;
                basketDataList.DataBind();              
            }

            //procedure for sendind email to customer to let them know of the product/s that have been checked out.
            string fromEmail = "nbajgai@gmail.com";
            string toEmail = username;
            string localHost = HttpContext.Current.Request.Url.Authority.ToString();    //getting the current HTTP request url and the host name.
            string mailSubject = "Your Navin's Wordery Order Of '" + productName.ToUpper() + "'";
            string mailBody = "Dear " + username + ",\n\n"
                + "Thank you for your order with Navin's Wordery.\n"
                + "We will let you know once your item(s) have dispatched. Your estimated delivery date is indicated below.\n\n"
                + "ORDER DETAILS\n"
                + "------------------------------------------------------------\n"
                + "Book Title: " + productName + "\n"
                + "Author: " + author + "\n"
                + "Quantity: " + quantityInBasket + "\n"
                + "Price per quantity: £" + pricePerQty + "\n"
                + "Total Price: £" + totalPrice + "\n\n\n"
                + "To visit your 'My Account' page, please go to http://" + localHost + "/myAccount.aspx."
                + "\n\n\n"
                + "Thanks\n"
                + "Navin's Wordery Ltd\n"
                + "Customer Service Team\n"
                + "01234567898";

            //calling the sendMail method of mail class to send email to the customer.
            mail.sendMail(fromEmail, toEmail, mailSubject, mailBody);
        }
        Response.AddHeader("REFRESH", "4");     //refreshes the page after 4 seconds.
    }

    //the item command event is to be raised when any button is clicked in the DataList control.
    protected void Datalist1_ItemCommand(object source, DataListCommandEventArgs e)
    {
        int quantityInBasket = 0;
        String qtyToUpdate = "";
        int quantityToUpdate = 0;
        int availableQuantity = 0;
        String productID = "";
        double totalPrice = 0;
        double newTotalPrice = 0;
        double grandTotal = 0;


        //if the command name of the control(button) is the updateQuantity, then do the following operation..
        if (e.CommandName == "updateQuantity")
        {
            TextBox qtyTxt = (TextBox)e.Item.FindControl("quantityToUpdateTxt");    //gets the quantity for the selected item in the datalist.
            if (!qtyTxt.Text.Equals(null))
            {
                if (DataList1.Items.Count > 0)
                {
                    qtyToUpdate = qtyTxt.Text;
                    quantityToUpdate = System.Convert.ToInt32(qtyToUpdate);
                }             
            }

            Label productIDLbl = (Label)e.Item.FindControl("bookIDLbl");
            productID = productIDLbl.Text;

            Label priceLbl = (Label)e.Item.FindControl("priceLbl");
            String tempPrice = priceLbl.Text;
            totalPrice = System.Convert.ToDouble(tempPrice);

            Label availableQtyLbl = (Label)e.Item.FindControl("availableQtyLbl");
            String availableQty = availableQtyLbl.Text;
            availableQuantity = System.Convert.ToInt32(availableQty);

            Label qtyInBasketLbl = (Label)e.Item.FindControl("qtyInBasketLbl");
            String qtyInBasket = qtyInBasketLbl.Text;
            quantityInBasket = System.Convert.ToInt32(qtyInBasket);

            //the total price for one particular item in the basket is the price per quantity plus quantity to be updated.
            newTotalPrice = totalPrice * quantityToUpdate;

            //incrementing the grand total price eveytime customer updates the quantity in the basket.
            grandTotal += newTotalPrice;

            //checking to make sure if the quantity customer wants to update is more or less than the available quantity
            if (quantityToUpdate > availableQuantity)
            {
                messageLbl.ForeColor = System.Drawing.Color.Black;
                messageLbl.BackColor = System.Drawing.Color.Yellow;
                messageLbl.Text = "Quantity Limit Exceeded!" + "<br />" + "You want: " + qtyToUpdate + "<br />" + "Available: " + availableQuantity;
            }
            else
            {
                //if the quanity to update is less than or equal to available quantity, then do the following..

                string updateQtyQuery;
                //an SQL query for updating the quantity in the basket for a specified product and customer.
                updateQtyQuery = "update Basket set quantity=" + quantityToUpdate + ", totalPrice=" + grandTotal + "where customerID =" + customerID + "and productID='" + productID + "'";
                basketDataSource.SelectCommand = updateQtyQuery;
                basketDataList.DataBind();
                Response.Redirect("basket.aspx");

                grandTotalLbl.Text = "Total Price: £" + grandTotal;     //displaying the grand total price after a successful quantity updation.
            }
        }

        //if the command name of the control(button) is the deleteItem, then do the following operation..
        if (e.CommandName == "deleteItem")
        {
            //get the productID of item that needs to be deleted.
            Label productIDLbl = (Label)e.Item.FindControl("bookIDLbl");
            productID = productIDLbl.Text;

            string deleteItemQuery;
            //an SQL query for deleting the product from the basket for a specified product and a customer.
            deleteItemQuery = "delete from Basket where customerID=" + customerID + "and productID='" + productID + "'";
            basketDataSource.SelectCommand = deleteItemQuery;
            basketDataList.DataBind();
            Response.Redirect("basket.aspx");
        }
    }
}