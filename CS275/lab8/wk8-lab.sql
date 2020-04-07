





CREATE OR REPLACE PROCEDURE ADD_CUSTOMER_HARRY
IS
BEGIN
INSERT INTO CUSTOMER
(customer_id,customer_first,customer_last,customer_total)
VALUES(8, 'Harry', 'Joker', 0);
END;
/

BEGIN
  ADD_CUSTOMER_HARRY;
END;
/


SELECT * FROM CUSTOMER;


CREATE OR REPLACE PROCEDURE ADD_CUSTOMER( -- Create a new customer
  cus_id_arg IN DECIMAL, -- The new customer ID, must be unused
  first_name_arg IN VARCHAR, -- The new customer’s first name
  last_name_arg IN VARCHAR) -- The new customer’s last name
IS -- Required by the syntax, but it doesn’t do anything in particular
BEGIN
INSERT INTO CUSTOMER
  (customer_id,customer_first,customer_last,customer_total)
VALUES(cus_id_arg,first_name_arg,last_name_arg,0);
-- We start the customer with zero balance.
END;
/

BEGIN
ADD_CUSTOMER(9, 'Mary', 'Smith');
END;
/

--11

CREATE OR REPLACE PROCEDURE ADD_CUSTOMER( -- Create a new customer
  cus_id_arg IN DECIMAL, -- The new customer ID, must be unused
  first_name_arg IN VARCHAR, -- The new customer’s first name
  last_name_arg IN VARCHAR, -- The new customer's last name
  cust_balance in NUMBER) -- The new customer’s balance
IS -- Required by the syntax, but it doesn’t do anything in particular
BEGIN
INSERT INTO CUSTOMER
  (customer_id,customer_first,customer_last,customer_total)
VALUES(cus_id_arg,first_name_arg,last_name_arg,cust_balance);
-- We update the balance based upon provided argument.
END;
/

BEGIN
ADD_CUSTOMER(10, 'Gabriela', 'Jury', 10.99);
END;
/

select * from customer;


CREATE OR REPLACE PROCEDURE REMOVE_CUSTOMER(
  cus_id_arg IN DECIMAL 
) 
IS
BEGIN
delete from (select * 
from line_item
join Customer_order on line_item.order_id = customer_order.order_id
where customer_order.customer_id = cus_id_arg);
delete from customer_order
where customer_order.customer_id = cus_id_arg;
delete from customer
where customer_id = cus_id_arg;
END;
/

select customer_id from customer where customer_first = 'John' and customer_last ='Smith';

begin
REMOVE_CUSTOMER(1);
end;
/

select * from customer;


commit;



