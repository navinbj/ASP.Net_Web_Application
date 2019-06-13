using System;
using System.Data;

/// <summary>
/// The class Login is created for storing all the login functionalities which will be
/// used to authenticate and authorise user to the certain website contents. 
/// </summary>
public class Login
{
    customersTableAdapters.CustomersTableAdapter customersData;
    customers.CustomersDataTable usersTable;

    /**
     * Constructor for the objects of class Login
     **/

    public Login()
    {
        customersData = new customersTableAdapters.CustomersTableAdapter();
        usersTable = customersData.GetData();
    }

    //method for authenticating the user to the website by checking the login details against the records in the database.
    public bool authenticateUsersViaDatabase(String username, String password)
    {
        foreach (DataRow row in usersTable.Rows)
        {
            if (username == System.Convert.ToString(row["email"]).TrimEnd() && password == System.Convert.ToString(row["password"]).TrimEnd())
                return true;
        }
        return false;
    }

    //method for checking whether the email the user wants to register with already exists in the database or not.
    public bool checkEmail(String email)
    {
        foreach (DataRow row in usersTable.Rows)
        {
            if (email == System.Convert.ToString(row["email"]).TrimEnd())
                return true;
        }
        return false;
    }

    //method for returning the id of a customer when specified the email address of a customer.
    public int getCustomerID(String email)
    {
        int customerID = 0;

        foreach (DataRow row in usersTable.Rows)
        {
            if(email == System.Convert.ToString(row["email"]).TrimEnd())
            {
                customerID = System.Convert.ToInt32(row["customerID"]);
            }
        }
        return customerID;
    }

    //method for checking where the password that the user has enetered matches with the one in database, for a reset purpose.
    public bool checkPassword(string password, int customerID)
    {
        foreach (DataRow row in usersTable.Rows)
        {
            if (customerID == System.Convert.ToInt32(row["customerID"]) && password == System.Convert.ToString(row["password"]).TrimEnd())
                return true;
        }
        return false;
    }
}