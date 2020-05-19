set serveroutput on;

--Week 7: Working with collections
--Mon inClass assignment

-- Using product table:
-- Product_ID, Product_Name, Product_Price, Product_Cost

declare
  type list_of_products_c is table of product.product_name%type
    index by pls_integer;
    
  v_my_products list_of_products_c;
  l_row pls_integer;
begin
  v_my_products (1) := 'Yo-yo';
  v_my_products (20) := 'Matchbox car';
  v_my_products (33) := 'Slinky';
  v_my_products (45) := 'Rocks';
  v_my_products (57) := 'Sticks';
  v_my_products (69) := 'Yarn';
  
  l_row := v_my_products.FIRST;
  
  while (l_row is not null) -- while there are records to read
  loop
    dbms_output.put_line('MyProductsCo offers: '|| v_my_products(l_row));
    l_row := v_my_products.NEXT(l_row); --skips over gaps
  end loop;
  
end;