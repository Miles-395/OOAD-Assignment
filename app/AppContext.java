package app;

import controller.AccountController;
import controller.CustomerController;
import controller.InterestController;
import controller.LoginController;
import controller.SessionManager;
import controller.TransactionController;
import database.DatabaseInitializer;
import model.BankingException;

import java.sql.SQLException;

/**
 * Creates the controllers once and shares them with all the screens.
 * All controllers share one SessionManager, so they all know who is logged in.
 */
public class AppContext {
    private final LoginController loginController;
    private final CustomerController customerController;
    private final AccountController accountController;
    private final TransactionController transactionController;
    private final InterestController interestController;

    public AppContext() throws SQLException, BankingException {
        // Create the tables and sample data if they are not there yet
        new DatabaseInitializer().setUp();

        SessionManager session = new SessionManager();
        loginController = new LoginController(session);
        customerController = new CustomerController();
        accountController = new AccountController(session);
        transactionController = new TransactionController(session);
        interestController = new InterestController(session);
    }

    public LoginController getLoginController() {
        return loginController;
    }

    public CustomerController getCustomerController() {
        return customerController;
    }

    public AccountController getAccountController() {
        return accountController;
    }

    public TransactionController getTransactionController() {
        return transactionController;
    }

    public InterestController getInterestController() {
        return interestController;
    }
}

