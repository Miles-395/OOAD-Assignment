-- =============================================================
-- Banking System database schema
-- Mirrors the class diagram:
--   Customer (abstract)  -> customers + individual_customers / company_customers
--   Account (abstract)   -> accounts (account_type tells Savings / Investment / Cheque)
--   Transaction          -> transactions
--   BankTeller           -> bank_tellers
-- =============================================================

CREATE TABLE IF NOT EXISTS bank_tellers (
    staff_id       VARCHAR(20)  NOT NULL PRIMARY KEY,
    full_name      VARCHAR(100) NOT NULL,
    password_hash  VARCHAR(255) NOT NULL
    );

CREATE TABLE IF NOT EXISTS customers (
    customer_id    VARCHAR(20)  NOT NULL PRIMARY KEY,
    customer_type  VARCHAR(20)  NOT NULL,
    contact_info   VARCHAR(150) NOT NULL,
    date_joined    DATE         NOT NULL
    );

CREATE TABLE IF NOT EXISTS individual_customers (
    customer_id    VARCHAR(20)  NOT NULL PRIMARY KEY,
    id_number      VARCHAR(30)  NOT NULL UNIQUE,
    first_name     VARCHAR(60)  NOT NULL,
    last_name      VARCHAR(60)  NOT NULL,
    date_of_birth  DATE         NOT NULL,
    address        VARCHAR(200) NOT NULL,
    next_of_kin    VARCHAR(100),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS company_customers (
                                                 customer_id          VARCHAR(20)   NOT NULL PRIMARY KEY,
    registration_number  VARCHAR(30)   NOT NULL UNIQUE,
    company_name         VARCHAR(120)  NOT NULL,
    line_of_business     VARCHAR(100)  NOT NULL,
    turnover             DECIMAL(15,2) NOT NULL,
    shareholder_info     VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS accounts (
                                        account_number    VARCHAR(20)   NOT NULL PRIMARY KEY,
    customer_id       VARCHAR(20)   NOT NULL,
    account_type      VARCHAR(20)   NOT NULL,
    balance           DECIMAL(15,2) NOT NULL,
    branch_name       VARCHAR(60)   NOT NULL,
    status            VARCHAR(30)   NOT NULL,
    date_opened       DATE          NOT NULL,
    employer_name     VARCHAR(120),
    employer_address  VARCHAR(200),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS transactions (
                                            transaction_id    VARCHAR(30)   NOT NULL PRIMARY KEY,
    account_number    VARCHAR(20)   NOT NULL,
    transaction_type  VARCHAR(20)   NOT NULL,
    amount            DECIMAL(15,2) NOT NULL,
    balance_after     DECIMAL(15,2) NOT NULL,
    transaction_date  TIMESTAMP     NOT NULL,
    description       VARCHAR(200),
    FOREIGN KEY (account_number) REFERENCES accounts(account_number) ON DELETE CASCADE
    );

-- One row per month in which interest was paid, so interest cannot be paid twice.
CREATE TABLE IF NOT EXISTS interest_runs (
                                             period      VARCHAR(7)    NOT NULL PRIMARY KEY,
    run_date    TIMESTAMP     NOT NULL,
    staff_id    VARCHAR(20)   NOT NULL,
    total_paid  DECIMAL(15,2) NOT NULL
    );
