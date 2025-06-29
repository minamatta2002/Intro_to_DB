-- Create the alx_book_store database
CREATE DATABASE IF NOT EXISTS alx_book_store;
USE alx_book_store;

-- Create Authors table
CREATE TABLE IF NOT EXISTS Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(215) NOT NULL,
    bio TEXT,
    birth_date DATE,
    nationality VARCHAR(100)
);

-- Create Books table
CREATE TABLE IF NOT EXISTS Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(130) NOT NULL,
    author_id INT NOT NULL,
    isbn VARCHAR(13) UNIQUE,
    price DECIMAL(8, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    publication_date DATE,
    genre VARCHAR(50),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
);

-- Create Customers table
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(215) NOT NULL,
    email VARCHAR(215) UNIQUE NOT NULL,
    address TEXT,
    phone VARCHAR(20),
    registration_date DATE DEFAULT (CURRENT_DATE)
);

-- Create Orders table
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE DEFAULT (CURRENT_DATE),
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);

-- Create Order_Details table
CREATE TABLE IF NOT EXISTS Order_Details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity DOUBLE NOT NULL,
    unit_price DECIMAL(8, 2) NOT NULL,
    total_price DECIMAL(8, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

-- Add indexes for better performance
CREATE INDEX idx_Books_author ON Books(author_id);
CREATE INDEX idx_Books_isbn ON Books(isbn);
CREATE INDEX idx_Orders_customer ON Orders(customer_id);
CREATE INDEX idx_Order_Details_order ON Order_Details(order_id);
CREATE INDEX idx_Order_Details_book ON Order_Details(book_id);
