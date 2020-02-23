CREATE TABLE "GuestHouse_Reservation" (
  "GuestHouse_Reservation_ID" <type>,
  "GuestHouse_Room_ID" <type>,
  "Reservation_ID" <type>,
  "Guest_Count" <type>,
  PRIMARY KEY ("GuestHouse_Reservation_ID")
);

CREATE INDEX "FK" ON  "GuestHouse_Reservation" ("GuestHouse_Room_ID", "Reservation_ID");

CREATE TABLE "StoreInventory" (
  "StoreInventory_ID" <type>,
  "Store_ID" <type>,
  "DateReceived" <type>,
  "Shipment_Order" <type>,
  PRIMARY KEY ("StoreInventory_ID")
);

CREATE INDEX "FK" ON  "StoreInventory" ("Store_ID");

CREATE TABLE "Store_Business_Type" (
  "Store_Business_Type_ID" <type>,
  "Store_Business_Type_Name" <type>,
  "Store_Business_Type_Descript" <type>,
  PRIMARY KEY ("Store_Business_Type_ID")
);

CREATE TABLE "GuestHouse_Room" (
  "GuestHouse_Room_ID" <type>,
  "GuestHouse_ID" <type>,
  "Room_Name" <type>,
  "Room_Occupancy" <type>,
  "Room_Price" <type>,
  PRIMARY KEY ("GuestHouse_Room_ID")
);

CREATE INDEX "FK" ON  "GuestHouse_Room" ("GuestHouse_ID");

CREATE TABLE "Vendor" (
  "Vendor_ID" <type>,
  "VendorName" <type>,
  PRIMARY KEY ("Vendor_ID")
);

CREATE TABLE "Customer_Address_Type" (
  "Address_Type_ID" <type>,
  "Address_Type_Description" <type>,
  PRIMARY KEY ("Address_Type_ID")
);

CREATE TABLE "Employee_Type" (
  "Employee_Type_ID" <type>,
  "Employee_Type_Name" <type>,
  "Employee_Type_Description" <type>,
  PRIMARY KEY ("Employee_Type_ID")
);

CREATE TABLE "Sale_Transaction" (
  "Sale_Transaction_ID" <type>,
  "Customer_ID" <type>,
  "TransactionDate" <type>,
  "Transaction_Amount" <type>,
  "" <type>,
  PRIMARY KEY ("Sale_Transaction_ID")
);

CREATE INDEX "FK" ON  "Sale_Transaction" ("Customer_ID");

CREATE TABLE "Payroll" (
  "Payroll_ID" <type>,
  "Store_ID" <type>,
  "PayPeriodStartDate" <type>,
  "PayPeriodEndDate" <type>,
  PRIMARY KEY ("Payroll_ID")
);

CREATE INDEX "FK" ON  "Payroll" ("Store_ID");

CREATE TABLE "Product" (
  "Product_ID" <type>,
  "Product_Type_ID" <type>,
  "Product_Name" <type>,
  "Product_Description" <type>,
  "Product_Price" <type>,
  "Product_Cost" <type>,
  PRIMARY KEY ("Product_ID")
);

CREATE INDEX "FK" ON  "Product" ("Product_Type_ID");

CREATE TABLE "Customer_Address" (
  "Customer_Address_ID" <type>,
  "Street_Address" <type>,
  "City" <type>,
  "State" <type>,
  "Zipcode" <type>,
  "Customer_ID" <type>,
  "Address_Type_ID" <type>,
  PRIMARY KEY ("Customer_Address_ID")
);

CREATE INDEX "FK" ON  "Customer_Address" ("Customer_ID", "Address_Type_ID");

CREATE TABLE "Customer" (
  "Customer_ID" <type>,
  "First_Name" <type>,
  "Last_Name" <type>,
  "" <type>,
  PRIMARY KEY ("Customer_ID")
);

CREATE TABLE "Schedule" (
  "Schedule_ID" <type>,
  "StartDate" <type>,
  "EndDate" <type>,
  PRIMARY KEY ("Schedule_ID")
);

CREATE TABLE "GuestHouse" (
  "GuestHouse_ID" <type>,
  "Num_of_Room" <type>,
  "Max_Occupancy" <type>,
  "Schedule_ID" <type>,
  "GuestHouse_Name" <type>,
  PRIMARY KEY ("GuestHouse_ID")
);

CREATE INDEX "FK" ON  "GuestHouse" ("Schedule_ID");

CREATE TABLE "Transaction_Line_Item" (
  "Transaction_Line_Item_ID" <type>,
  "Product_ID" <type>,
  "Sales_Transaction_ID" <type>,
  "Quantity" <type>,
  "Price" <type>,
  PRIMARY KEY ("Transaction_Line_Item_ID")
);

CREATE INDEX "FK" ON  "Transaction_Line_Item" ("Product_ID", "Sales_Transaction_ID");

CREATE TABLE "Paycheck" (
  "Paycheck_ID" <type>,
  "Employee_ID" <type>,
  "Payroll_ID" <type>,
  "Hours_Worked" <type>,
  "Pay_Rate" <type>,
  PRIMARY KEY ("Paycheck_ID")
);

CREATE INDEX "FK" ON  "Paycheck" ("Employee_ID", "Payroll_ID");

CREATE TABLE "Shift" (
  "Shift_ID" <type>,
  "Employee_ID" <type>,
  "Schedule_ID" <type>,
  "End_Time" <type>,
  "Shift_Date" <type>,
  "Start_Time" <type>,
  PRIMARY KEY ("Shift_ID")
);

CREATE INDEX "FK" ON  "Shift" ("Employee_ID", "Schedule_ID");

CREATE TABLE "Reservation" (
  "Reservation_ID" <type>,
  "Customer_ID" <type>,
  "DateStart" <type>,
  "DateEnd" <type>,
  "Reservation_Price" <type>,
  PRIMARY KEY ("Reservation_ID")
);

CREATE INDEX "FK" ON  "Reservation" ("Customer_ID");

CREATE TABLE "Store_Entity" (
  "Store_ID" <type>,
  "Schedule_ID" <type>,
  "Store_Name" <type>,
  "Store_Business_Type_ID" <type>,
  PRIMARY KEY ("Store_ID")
);

CREATE INDEX "FK" ON  "Store_Entity" ("Schedule_ID", "Store_Business_Type_ID");

CREATE TABLE "Restaurant_Reservation" (
  "Restaurant_Reservation_ID" <type>,
  "Store_ID" <type>,
  "Reservation_ID" <type>,
  "Num_of_Guests" <type>,
  "" <type>,
  PRIMARY KEY ("Restaurant_Reservation_ID")
);

CREATE INDEX "FK" ON  "Restaurant_Reservation" ("Store_ID", "Reservation_ID");

CREATE TABLE "Employee" (
  "Employee_ID" <type>,
  "Employee_Type_ID" <type>,
  PRIMARY KEY ("Employee_ID")
);

CREATE INDEX "FK" ON  "Employee" ("Employee_Type_ID");

CREATE TABLE "StoreInventory_LineItem" (
  "StoreInventory_LineItem_ID" <type>,
  "ProductID" <type>,
  "StoreInventory_ID" <type>,
  "Quantity" <type>,
  "Vendor_ID" <type>,
  PRIMARY KEY ("StoreInventory_LineItem_ID")
);

CREATE INDEX "FK" ON  "StoreInventory_LineItem" ("ProductID", "StoreInventory_ID", "Vendor_ID");

CREATE TABLE "Product_Type" (
  "Product_Type_ID" <type>,
  "Product_Type_Name" <type>,
  "Product_Type_Description" <type>,
  PRIMARY KEY ("Product_Type_ID")
);

