
# TOPIC : LIBRARY MANAGEMENT SYSTEM

# Create a database named library and the following tables in the database Branch,Employee,Books,Customer, IssueStatus,ReturnStatus

-- Create Database
CREATE DATABASE Library;

-- Use Database
USE Library;


-- Create Tables

CREATE TABLE Branch (
  Branch_no INT PRIMARY KEY,
  Manager_Id INT,
  Branch_address VARCHAR(255),
  Contact_no VARCHAR(20)
);

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
(1, 101, '123 Main St', '555-1234'),
(2, 102, '456 Elm St', '555-5678'),
(3, 103, '789 Oak St', '555-9012');

SELECT* FROM Branch;


CREATE TABLE Employee (
  Emp_Id INT PRIMARY KEY,
  Emp_name VARCHAR(100),
  Position VARCHAR(50),
  Salary DECIMAL(10, 2),
  Branch_no INT,
  FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES
(101, 'John Doe', 'Manager', 52000, 1),
(102, 'Jane Smith', 'Assistant', 40000, 2),
(103, 'Bob Johnson', 'Librarian', 55000, 3),
(104, 'Alice Brown', 'Clerk', 35000, 1),
(105, 'Mike Davis', 'Security', 30000, 2);

SELECT * FROM Employee;


CREATE TABLE Books (
  ISBN VARCHAR(20) PRIMARY KEY,
  Book_title VARCHAR(100),
  Category VARCHAR(50),
  Rental_Price DECIMAL(10, 2),
  Status VARCHAR(5) CHECK ( Status IN ('Yes','No')),
  Author VARCHAR(100),
  Publisher VARCHAR(100)
);

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
('97834567890', 'The Great Gatsby', 'Fiction', 10.99, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
('97876543210', 'To Kill a Mockingbird', 'Fiction', 28, 'yes', 'Harper Lee', 'J.B. Lippincott'),
('97855555555', 'The Catcher in the Rye', 'Fiction', 9, 'no', 'J.D. Salinger', 'Little, Brown'),
('97866666666', 'Pride and Prejudice', 'History', 11.99, 'yes', 'Jane Austen', 'T. Egerton');

SELECT * FROM Books;




CREATE TABLE Customer (
  Customer_Id INT PRIMARY KEY,
  Customer_name VARCHAR(100),
  Customer_address VARCHAR(255),
  Reg_date DATE
);

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
(1, 'Emily Chen', '123 Maple St', '2022-01-01'),
(2, 'David Lee', '456 Pine St', '2021-12-30'),
(3, 'Sarah Taylor', '789 Oak St', '2022-06-01'),
(4, 'Kevin White', '123 Elm St', '2022-04-01'),
(5, 'Olivia Brown', '456 Main St', '2021-12-29');

SELECT * FROM Customer;



CREATE TABLE IssueStatus (
  Issue_Id INT PRIMARY KEY,
  Issued_cust INT,
  Issued_book_name VARCHAR(100),
  Issue_date DATE,
  Isbn_book VARCHAR(20),
  FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
(1, 1, 'The Great Gatsby', '2022-01-05', '97834567890'),
(2, 2, 'To Kill a Mockingbird', '2023-06-10', '97876543210'),
(3, 3, 'Pride and Prejudice', '2021-12-15', '97855555555'),
(4, 4, 'The Hunger Games', '2022-04-20', '97866666666');

SELECT * FROM IssueStatus;



CREATE TABLE ReturnStatus (
  Return_Id INT PRIMARY KEY,
  Return_cust INT,
  Return_book_name VARCHAR(100),
  Return_date DATE,
  Isbn_book2 VARCHAR(20), 
  FOREIGN KEY(Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
(1, 1, 'The Great Gatsby', '2022-01-15', '97834567890'),
(2, 2, 'To Kill a Mockingbird', '2022-02-25', '97876543210'),
(3, 3, 'Pride and Prejudice', '2022-04-01', '97855555555'),
(4, 4, 'The Hunger Games', '2022-05-10', '97866666666');

SELECT * FROM ReturnStatus;


# Retrieve the book title ,category,and rental price of all available books
SELECT Category , Rental_Price FROM Books WHERE Status = 'Yes';


#List the employee names and their respective salaries in descending order of salary
SELECT Emp_name , Salary FROM Employee ORDER BY Salary DESC;





# Retrieve the book titles and the corresponding customers who have issued those books
SELECT Book_title , Customer_name FROM Books JOIN IssueStatus ON ISBN =Isbn_book JOIN Customer ON Issued_cust = Customer_Id;




# Display the total count of books in each category
SELECT Category , COUNT(*) AS Total_Books FROM Books GROUP BY Category;





# Retrieve the employee names and their positions for the employees whose salaries are above Rs.50.000
SELECT Emp_name , Position FROM Employee WHERE Salary > 50000;




# List the customer names who registered before 2022-01-01 and have not issued any books yet
SELECT Customer_name FROM Customer WHERE Reg_date < '2022-01-01' AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);


# Display the branch numbers and the total count of employees in each branch
SELECT Branch_no ,COUNT(*) AS Total_employees FROM Branch GROUP BY Branch_no;

# Display the names of customers who have issued books in the month of june 2023
SELECT Customer_name FROM Customer JOIN IssueStatus ON Customer_Id = Issued_cust WHERE Month(Issue_date)=6 AND Year(Issue_date)=2023;


# Retrieve book title from book table containing history
SELECT Book_title FROM Books WHERE Category = 'History';


# Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
SELECT Branch.Branch_no , COUNT(*) AS Total_employees FROM Branch 
 JOIN 
Employee ON Branch.Branch_no = Employee.Branch_no GROUP BY Branch.Branch_no HAVING COUNT(*) > 5 ;


# Retrieve the names of employees who manage branches and thier respective branch adresses
SELECT Emp_name,Branch_address FROM Employee JOIN Branch ON Emp_Id = Manager_Id;




# Display the names of customers who have issued books with a rental price higher than Rs.25
SELECT Customer_name FROM Customer JOIN IssueStatus ON Customer_Id = Issued_cust JOIN Books ON Isbn_book = ISBN WHERE Rental_Price > 25; 



