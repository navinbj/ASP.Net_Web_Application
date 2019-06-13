using System;
using System.Web.UI.WebControls;

public partial class bookSingle : System.Web.UI.Page
{
    //fields for storing the books related data.
    string productID = "";
    int availableQty = 0;
    int quantity = 0;
    string customerID = "";
    double price = 0;
    double totalPrice = 0;
    bool isBookInBasket;
    bool isValidQuantity;
    string username = "";

    //creating a new instance of BasketData class.
    BasketData basketData = new BasketData();

    //operations to be done on the page load..
    protected void Page_Load(object sender, EventArgs e)
    {
        //getting the query string from the URL that has a bookID.
        //the bookID is then used in the stored procedure for displaying the information about this particular book.
        productID = Request.QueryString["iSBNNo"];
        productIDLbl.Text = productID;

        //looping through a datalist that that contains the information about a single book.
        foreach (DataListItem item in DataList1.Items)
        {
            Label qtyLbl = (Label)item.FindControl("quantityLbl");  //finding the control(label) that holds the quantity for a book.
            int qty = System.Convert.ToInt32(qtyLbl.Text);

            if (qty < 1)    //checking if the quantity is greater than or equal to 1.
            {
                lblWarning.ForeColor = System.Drawing.Color.Red;
                lblWarning.Text = "Currently out of stock!";
            }
        }

        //getting the username and customerID session variables of a logged in customer.
        if (Session["username"] != null)
        {
            username = Session["username"].ToString();
            customerID = Session["customerID"].ToString();
        }
    }

    protected void addBtn_Click(object sender, EventArgs e)
    {
        //a customer cannot add item to basket if he's not logged in. 
        //a customer will rather be redirected to a login page.
        if (Session["customerID"] != null)
        {
            customerID = Session["customerID"].ToString();
        }
        else
        {
            Response.Redirect("login.aspx");
        }

        //looping through the datalist that contains the information about a single book.
        foreach (DataListItem item in DataList1.Items)
        {
            Label availableQtyLbl = (Label)item.FindControl("quantityLbl");
            String tempAvailableQty = availableQtyLbl.Text;
            availableQty = System.Convert.ToInt32(tempAvailableQty);

            Label priceLbl = (Label)item.FindControl("priceLbl");
            String tempPrice = priceLbl.Text;
            price = System.Convert.ToDouble(tempPrice);

            TextBox qtyTxt = (TextBox)item.FindControl("quantityTxt");
            String qty = qtyTxt.Text;
            quantity = System.Convert.ToInt32(qty);
        }

        //setting the total price field to the price per book multiplied by the quantity to be added in the basket for that book.
        totalPrice = price * quantity;

        //calling the method of a BasketData class to check if the book to be added is already in the basket. 
        isBookInBasket = basketData.checkBookInBasket(productID, System.Convert.ToInt32(customerID));

        //calling the method of a BasketData class to check if the quantity to be added plus the quantity already in the basket
        //is less than or equal to available quantity for that particular book.
        isValidQuantity = basketData.checkQuantityInBasket(productID, System.Convert.ToInt32(customerID), quantity, availableQty);

        //getting the quantity from a basket for a specified customer and book.
        int quantityInBasket = basketData.getProductQuantity(productID, System.Convert.ToInt32(customerID));

        //quantity to be added in the basket is the quantity already in the basket plus that quantity customer wants to add again for the same product.
        int quantityToBeAdded = quantityInBasket + quantity;

        if (isBookInBasket)
        {
            //lblWarning.Text = "product already exists!";

            if (isValidQuantity)
            {
                //updating item's quantity in the basket
                //incrementing the quantity for the specified product.
                string updateQuery;
                updateQuery = "update Basket set quantity = quantity + " + quantity + "where productID = '" + productID + "' and customerID = " + customerID;
                basketDataSource.SelectCommand = updateQuery;
                basketDataList.DataBind();
                Response.Redirect("basket.aspx");
            }
            else
            {
                messageLbl.ForeColor = System.Drawing.Color.Red;
                messageLbl.Text = "Quantity Limit Exceeded!" + "<br />" + "You want: " + quantityToBeAdded + " (" + quantityInBasket + " already in basket)" + "<br />" + "Available: " + availableQty;
            }
        }
        else
        {
            if (quantityToBeAdded > availableQty)
            {
                messageLbl.ForeColor = System.Drawing.Color.Red;
                messageLbl.Text = "Quantity Limit Exceeded!" + "<br />" + "You want: " + quantityToBeAdded + "<br />" + "Available: " + availableQty;
            }
            else
            {
                //adding items to basket
                string insertQuery;

                //query for inserting item into the basket.
                insertQuery = "insert into Basket (quantity, totalPrice, productID, customerID) values(" + quantity + "," + totalPrice + ",'" + productID + "'," + customerID + ")";
                basketDataSource.SelectCommand = insertQuery;
                basketDataList.DataBind();      //binding the data to save the changes made to the data list.
                Response.Redirect("basket.aspx");
            }
        }
    }

    protected void submitBtn_Click(object sender, EventArgs e)
    {
        string comment = commentTxt.Text;
        string dateTime = DateTime.Now.ToLocalTime().ToString();
        string customerID = "";

        //getting the customerID session variable of a logged in customer
        if (Session["customerID"] != null)
        {
            customerID = Session["customerID"].ToString();
        }

        string insertCommentQuery;
        //sql query for inserting comments into a BooksComments table. 
        insertCommentQuery = "insert into BooksComments (comment, productID, customerID, dateTime) values('" + comment + "','" + productID + "'," + customerID + ",'" + dateTime + "')";
        commentsDataSource.SelectCommand = insertCommentQuery;
        commentsDataList.DataBind();

        messageLbl.ForeColor = System.Drawing.Color.Green;
        //displaying the message to thank customer for leaving the comments on the page.
        messageLbl.Text = "Thank you for your feedback " + Session["username"].ToString() + "<br />" + "HIGHLY APPRECIATED!";
        Response.AddHeader("REFRESH", "4"); //refreshes the page after 4 seconds.
    }

    //the item command event is to be raised when any button is clicked in the DataList control.
    protected void Datalist2_ItemCommand(object source, DataListCommandEventArgs e)
    {
        string cusID = "";
        string commentID = "";

        //if the command name of the control(button) is deleteComment, then do the following operations..
        if (e.CommandName == "deleteComment")
        {
            //get the customer ID of a customer that posted the comment. 
            Label cusIDLbl = (Label)e.Item.FindControl("customerIDLbl");
            cusID = cusIDLbl.Text;

            //get the commentID for the selected comment from the comment data list.
            Label commentIDLbl = (Label)e.Item.FindControl("selectedCommentIDLbl");
            commentID = commentIDLbl.Text;

            if (customerID != cusID)
            {
                //if the logged in customer is not the one who posted he selected commment, then the customer cannot delete this comment.
                messageLbl.ForeColor = System.Drawing.Color.Red;
                messageLbl.Text = "This comment cannot be deleted!" + "<br />" + "It was posted by other user.";
            }
            else
            {
                //if the customer matches...
                string deleteCommentQuery;

                //sql query for deleting comment from BooksComments table when specified the customer that posted the comment and on which book he posted on.
                deleteCommentQuery = "delete from BooksComments where commentID = " + commentID + " and customerID = " + cusID;
                commentsDataSource.SelectCommand = deleteCommentQuery;
                commentsDataList.DataBind();
                Response.AddHeader("REFRESH", "1");
            }
        }
    }
}