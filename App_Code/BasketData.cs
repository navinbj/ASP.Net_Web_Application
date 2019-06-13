using System;
using System.Data;

/// The BasketData class has been created for storing the basket details and then for checking the records 
/// specified by a user against the existing records in the database.
public class BasketData
{
    //field for the basket table adapter
    basketDataSetTableAdapters.BasketTableAdapter basketData;

    //field representing the basket data set from where the basket data can be obtained using getData() method.
    basketDataSet.BasketDataTable basketTable;

    //constructor for the objects of class BasketData.
    public BasketData()
    {
        basketData = new basketDataSetTableAdapters.BasketTableAdapter();
        basketTable = basketData.GetData();
    }

    //method for checking whether the book that user wants to add to the basket already exists in the database.
    public bool checkBookInBasket(String bookID, int customerID)
    {
        foreach (DataRow row in basketTable.Rows)
        {
            if (bookID == System.Convert.ToString(row["productID"]).TrimEnd() && customerID == System.Convert.ToInt32(row["customerID"]))
                return true;
        }
        return false;
    }

    //method for checking the quantity before adding items to the basket. This method is applied when a user adds the same item more than once.
    //if the available quantity is less than the quantity user already has in his basket plus the quantity he wants to add again, it will return false.
    public bool checkQuantityInBasket(String bookID, int customerID, int quantityToBeAdded, int availableQuantity)
    {
        foreach (DataRow row in basketTable.Rows)
        {
            if (bookID == System.Convert.ToString(row["productID"]).TrimEnd() &&
                customerID == System.Convert.ToInt32(row["customerID"]) &&
                availableQuantity >= System.Convert.ToInt32(row["quantity"]) + quantityToBeAdded)
                return true;
        }
        return false;
    }

    //method for getting the quantity of the product from the basket when specified the productID and customerID held in the basket.
    public int getProductQuantity(string productID, int customerID)
    {
        int quantityInBasket = 0;

        foreach (DataRow row in basketTable.Rows)
        {
            if (productID == System.Convert.ToString(row["productID"]).TrimEnd() && customerID == System.Convert.ToInt32(row["customerID"]))
                quantityInBasket = System.Convert.ToInt32(row["quantity"]);
        }
        return quantityInBasket;
    }
}