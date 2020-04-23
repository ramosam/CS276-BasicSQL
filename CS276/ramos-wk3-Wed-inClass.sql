--Using a select statement to make sure that the collection is what we intend to use
select product.product_id as prod_id,
product.product_name as prod_name,
(product.product_cost * sum(line_item.line_item_quantity)) as prod_cost,
(product.product_price * sum(line_item.line_item_quantity)) as prod_price,
sum(line_item.line_item_quantity) as purchased
from purchase
join line_item on line_item.fk_purchase_id = purchase.purchase_id
join product on product.product_id = line_item.fk_product_id
group by product.product_id, product.product_name, product.product_cost, product.product_price;

declare
  --variables to hold the accrued amounts
  total_cost number(8) := 0;
  total_sales number(8) := 0;

  cursor product_cur is
    select product.product_id as prod_id,
    product.product_name as prod_name,
    (product.product_cost * sum(line_item.line_item_quantity)) as prod_cost,
    (product.product_price * sum(line_item.line_item_quantity)) as prod_price,
    sum(line_item.line_item_quantity) as purchased
    from purchase
    join line_item on line_item.fk_purchase_id = purchase.purchase_id
    join product on product.product_id = line_item.fk_product_id
    group by product.product_id, product.product_name, product.product_cost, product.product_price;

begin
  for product_rec in product_cur
  loop
    dbms_output.put_line('Today''s cost of sales in item: '|| product_rec.prod_name ||' was $'|| product_rec.prod_cost ||'. They sold for a total of: $'|| product_rec.prod_price);
    total_cost := total_cost + product_rec.prod_cost;
    total_sales := total_sales + product_rec.prod_price;

    update inventory
      set quantity_on_hand = quantity_on_hand - product_rec.purchased
      where fk_prod_id = product_rec.prod_id;

  end loop;
  dbms_output.put_line('===========================');
  dbms_output.put_line('The total cost was %'|| total_cost ||' but the sales amount was: $'|| total_sales);
end;
