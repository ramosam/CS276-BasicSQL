Drop table BACustomer_Address_Type cascade constraints;
Drop table BACustomer cascade constraints;
Drop table BACustomer_Address cascade constraints;
Drop table BASale_Transaction cascade constraints;
Drop table BAReservation cascade constraints;
Drop table BASchedule cascade constraints;
Drop table BAEmployee_Type cascade constraints;
Drop table BAEmployee cascade constraints;
Drop table BAShift cascade constraints;
Drop table BAGuestHouse cascade constraints;
Drop table BAGuestHouse_Room cascade constraints;
Drop table BAGuestHouse_Reservation cascade constraints;
Drop table BAStore_Business_Type cascade constraints;
Drop table BAStore_Entity cascade constraints;
Drop table BAPayroll cascade constraints;
Drop table BAPaycheck cascade constraints;
Drop table BARestaurant_Reservation cascade constraints;
Drop table BAStoreInventory cascade constraints;
Drop table BAProduct_Type cascade constraints;
Drop table BAProduct cascade constraints;
Drop table BAVendor cascade constraints;
Drop table BAStoreInventory_LineItem cascade constraints;
Drop table BATransaction_Line_Item cascade constraints;


/*
  Create the tables
*/


CREATE TABLE BACustomer_Address_Type (
  Address_Type_ID number(10) not null,
  Address_Type_Description varchar2(100) not null,
  PRIMARY KEY (Address_Type_ID)
);

CREATE TABLE BACustomer (
  Customer_ID varchar2(15) not null,
  First_Name varchar2(100) not null,
  Last_Name varchar2(100) not null,
  PRIMARY KEY (Customer_ID)
);

CREATE TABLE BACustomer_Address (
  Customer_Address_ID number(10) not null,
  Street_Address varchar2(100) not null,
  City varchar2(50) not null,
  State varchar2(6) not null,
  Zipcode varchar2(20) not null,
  FK_Customer_ID varchar2(15) not null,
  FK_Customer_Address_Type_ID number(10) not null,
  PRIMARY KEY (Customer_Address_ID),
  FOREIGN KEY (FK_Customer_ID) REFERENCES BACustomer (Customer_ID),
  FOREIGN KEY (FK_Customer_Address_Type_ID) REFERENCES BACustomer_Address_Type (Address_Type_ID)
);

CREATE TABLE BASale_Transaction (
  Sale_Transaction_ID number(10)  not null,
  FK_Customer_ID varchar2(15) not null,
  TransactionDate Date not null,
  Transaction_Amount number(8,2) not null,
  PRIMARY KEY (Sale_Transaction_ID),
  FOREIGN KEY (FK_Customer_ID) REFERENCES BACustomer (Customer_ID)
);

CREATE TABLE BAReservation (
  Reservation_ID number(10) not null,
  FK_Customer_ID varchar2(15)  not null,
  DateStart Date not null,
  DateEnd Date not null,
  Reservation_Price number(8,2) not null,
  PRIMARY KEY (Reservation_ID),
  FOREIGN KEY (FK_Customer_ID) REFERENCES BACustomer (Customer_ID)
);

CREATE TABLE BASchedule (
  Schedule_ID number(10) not null,
  StartDate Date not null,
  EndDate Date not null,
  PRIMARY KEY (Schedule_ID)
);

CREATE TABLE BAEmployee_Type (
  Employee_Type_ID number(10),
  Employee_Type_Name varchar2(100),
  Employee_Type_Description varchar2(200),
  PRIMARY KEY (Employee_Type_ID)
);

CREATE TABLE BAEmployee (
  Employee_ID varchar2(15) not null,
  FK_Employee_Type_ID  not null,
  PRIMARY KEY (Employee_ID),
  FOREIGN KEY (FK_Employee_Type_ID) REFERENCES BAEmployee_Type (Employee_Type_ID)
);

CREATE TABLE BAShift (
  Shift_ID number(10) not null,
  FK_Employee_ID varchar2(15) not null,
  FK_Schedule_ID number(10) not null,
  End_Time Date not null,
  Shift_Date Date not null,
  Start_Time Date not null,
  PRIMARY KEY (Shift_ID),
  FOREIGN KEY (FK_Employee_ID) REFERENCES BAEmployee (Employee_ID), 
  FOREIGN KEY (FK_Schedule_ID) REFERENCES BASchedule (Schedule_ID)
);

CREATE TABLE BAGuestHouse (
  GuestHouse_ID varchar(15) not null,
  Num_of_Room number(3) not null,
  Max_Occupancy number(3) not null,
  FK_Schedule_ID number(10) not null,
  GuestHouse_Name varchar2(100) not null,
  PRIMARY KEY (GuestHouse_ID), 
  FOREIGN KEY (FK_Schedule_ID) REFERENCES BASchedule (Schedule_ID)
);

CREATE TABLE BAGuestHouse_Room (
  GuestHouse_Room_ID varchar2(15) not null,
  FK_GuestHouse_ID varchar2(15) not null,
  Room_Name varchar2(50) not null,
  Room_Occupancy number(2) not null,
  Room_Price number(8,2) not null,
  PRIMARY KEY (GuestHouse_Room_ID),
  FOREIGN KEY (FK_GuestHouse_ID) REFERENCES BAGuestHouse (GuestHouse_ID)
);

CREATE TABLE BAGuestHouse_Reservation (
  GuestHouse_Reservation_ID varchar2(15) not null,
  FK_GuestHouse_Room_ID varchar2(15) not null,
  FK_Reservation_ID number(10) not null,
  Guest_Count number(2) not null,
  PRIMARY KEY (GuestHouse_Reservation_ID),
  FOREIGN KEY (FK_GuestHouse_Room_ID) REFERENCES BAGuestHouse_Room (GuestHouse_Room_ID),
  FOREIGN KEY (FK_Reservation_ID) REFERENCES BAReservation (Reservation_ID)
);

CREATE TABLE BAStore_Business_Type (
  Store_Business_Type_ID number(4) not null,
  Store_Business_Type_Name varchar2(100) not null,
  Store_Business_Type_Descript varchar2(200) not null,
  PRIMARY KEY (Store_Business_Type_ID)
);

CREATE TABLE BAStore_Entity (
  Store_ID varchar2(15) not null,
  FK_Schedule_ID number(10) not null,
  Store_Name varchar2(100) not null,
  FK_Store_Business_Type_ID number(4) not null,
  PRIMARY KEY (Store_ID),
  FOREIGN KEY (FK_Schedule_ID) REFERENCES BASchedule (Schedule_ID),
  FOREIGN KEY (FK_Store_Business_Type_ID) REFERENCES BAStore_Business_Type (Store_Business_Type_ID)
);

CREATE TABLE BAPayroll (
  Payroll_ID number(10) not null,
  FK_Store_ID varchar2(15) not null,
  PayPeriodStartDate Date not null,
  PayPeriodEndDate Date not null,
  PRIMARY KEY (Payroll_ID),
  FOREIGN KEY (FK_Store_ID) REFERENCES BAStore_Entity (Store_ID)
);

CREATE TABLE BAPaycheck (
  Paycheck_ID number(10) not null,
  FK_Employee_ID varchar2(15) not null,
  FK_Payroll_ID number(10) not null,
  Hours_Worked number(6,2) not null,
  Pay_Rate number(6,2) not null,
  PRIMARY KEY (Paycheck_ID),
  FOREIGN KEY (FK_Employee_ID) REFERENCES BAEmployee (Employee_ID),
  FOREIGN KEY (FK_Payroll_ID) REFERENCES BAPayroll (Payroll_ID)
);

CREATE TABLE BARestaurant_Reservation (
  Restaurant_Reservation_ID varchar(15) not null,
  FK_Store_ID varchar2(15) not null,
  FK_Reservation_ID number(10) not null,
  Num_of_Guests number(3) not null,
  PRIMARY KEY (Restaurant_Reservation_ID),
  FOREIGN KEY (FK_Store_ID) REFERENCES BAStore_Entity (Store_ID),
  FOREIGN KEY (FK_Reservation_ID) REFERENCES BAReservation (Reservation_ID)
);

CREATE TABLE BAStoreInventory (
  StoreInventory_ID varchar(15) not null,
  FK_Store_ID varchar(15) not null,
  DateReceived Date  not null,
  Shipment_Order varchar(20) not null,
  PRIMARY KEY (StoreInventory_ID),
  FOREIGN KEY (FK_Store_ID) REFERENCES BAStore_Entity (Store_ID)
);

CREATE TABLE BAProduct_Type (
  Product_Type_ID varchar2(15) not null,
  Product_Type_Name varchar2(100) not null,
  Product_Type_Description varchar2(300),
  PRIMARY KEY (Product_Type_ID)
);

CREATE TABLE BAProduct (
  Product_ID varchar2(15) not null,
  FK_Product_Type_ID varchar2(15) not null,
  Product_Name varchar2(100) not null,
  Product_Description varchar2(300),
  Product_Price number(8,2) not null,
  Product_Cost number(8,2) not null,
  PRIMARY KEY (Product_ID)
);

CREATE TABLE BAVendor (
  Vendor_ID varchar2(15) not null,
  VendorName varchar2(100) not null,
  PRIMARY KEY (Vendor_ID)
);

CREATE TABLE BAStoreInventory_LineItem (
  StoreInventory_LineItem_ID number(10) not null,
  FK_ProductID varchar2(15) not null,
  FK_StoreInventory_ID varchar2(15) not null,
  FK_Vendor_ID varchar2(15) not null,
  Quantity number(4) not null,
  PRIMARY KEY (StoreInventory_LineItem_ID),
  FOREIGN KEY (FK_ProductID) REFERENCES BAProduct (Product_ID),
  FOREIGN KEY (FK_StoreInventory_ID) REFERENCES BAStoreInventory (StoreInventory_ID),
  FOREIGN KEY (FK_Vendor_ID) REFERENCES BAVendor (Vendor_ID)
);

CREATE TABLE BATransaction_Line_Item (
  Transaction_Line_Item_ID number(10) not null,
  FK_Product_ID varchar2(15),
  FK_Sale_Transaction_ID number(10),
  Quantity number(4),
  Price number(8,2),
  PRIMARY KEY (Transaction_Line_Item_ID),
  FOREIGN KEY (FK_Product_ID) REFERENCES BAProduct (Product_ID),
  FOREIGN KEY (FK_Sale_Transaction_ID) REFERENCES BASale_Transaction (Sale_Transaction_ID)
);




