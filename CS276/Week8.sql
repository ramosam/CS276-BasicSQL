drop table purchaser cascade constraints;
drop table tax_codes cascade constraints;

create table purchaser
(purchaser_id       number  PRIMARY KEY,
purchaser_first_name	varchar2(30),
purchaser_last_name	varchar2(30),
address_line1       varchar2(30),
address_line2       varchar2(30),
city                varchar2(30),
state_code          varchar2(2),
zip_code            varchar2(9));

insert into purchaser values
(10,'Pamela','Farr','123 Main Street',NULL,'Lake Oswego','OR','974012346');
insert into purchaser values
(20,'Constance','Connors','222 Blossom Street',NULL,'Fitchburg','MA','012402203');
insert into purchaser values
(30,'Andrew','Wolfe','805 Olive Avenue',NULL,'Phoenix','AZ','873458034');
insert into purchaser values
(40,'Warren','Mansur','8015 28th Avenue',NULL,'Seattle','WA','981153456');
insert into purchaser values
(50,'Russell','Murphy','4046 E. 94th Street',NULL,'Tulsa','OK','733474046');

drop table product cascade constraints;

create table product
(product_id         number  PRIMARY KEY,
product_name        varchar2(30),
product_price       number(8,2),
product_cost        number(8,2),
product_amount		number,
fk_inventory_id     number);

insert into product values
(100,'History of Buckfast Abbey',15.00,10.00,25,1);
insert into product values
(200,'Cinnamon Candle',5.00,3.00,35,1);
insert into product values
(300,'Bible',10.00,5.00,45,1);
insert into product values
(400,'Strawberry Jam',5.00,3.00,15,2);
insert into product values
(500,'Decorative Cross',12.00,6.00,10,2);
insert into product values
(600,'Buckfast Abbey Tote Bag',10.00,5.00,45,2);
insert into product values
(700,'Rosary',4.00,2.00,50,3);
insert into product values
(800,'T-Shirt',15.00,8.00,60,3);
insert into product values
(900,'Hoodie',20.00,10.00,25,3);
insert into product values
(110,'Place Mats Set of 4',20.00,10.00,20,1);
insert into product values
(120,'A Monks Life',15.00,10.00,20,2);
insert into product values
(130,'Apple Butter',5.00,3.00,25,2);

drop table inventory cascade constraints;

create table inventory
(inventory_id       number  PRIMARY KEY,
inventory_name      varchar2(30));

insert into inventory values
(1,'Gift Shop');
insert into inventory values
(2,'Religious Shop');
insert into inventory values
(3,'Book Store');

alter table product add constraint fk_inventory
FOREIGN KEY (fk_inventory_id)
references inventory (inventory_id);

drop table purchase cascade constraints;

create table purchase
(purchase_id        number,
fk_purchaser_id        number,
purchase_date       date,
total_purchase      number(8,2));

alter table purchase add constraint fk_purchaser
FOREIGN KEY (fk_purchaser_id)
references purchaser(purchaser_id);

insert into purchase values
(1000,10,SYSDATE,NULL);
insert into purchase values
(2000,10,SYSDATE,NULL);
insert into purchase values
(3000,20,SYSDATE,NULL);
insert into purchase values
(4000,20,SYSDATE,NULL);
insert into purchase values
(5000,30,SYSDATE,NULL);
insert into purchase values
(6000,40,SYSDATE,NULL);
insert into purchase values
(7000,50,SYSDATE,NULL);
insert into purchase values
(8000,50,SYSDATE,NULL);
insert into purchase values
(9000,30,SYSDATE,NULL);
insert into purchase values
(1010,30,SYSDATE,NULL);

drop table line_item cascade constraints;

create table line_item
(line_item_id       number,
fk_purchase_id      number,
fk_product_id       number,
number_purchased    number);

insert into line_item values
(1,1000,100,1);
insert into line_item values
(2,1000,200,2);
insert into line_item values
(3,1000,300,1);

insert into line_item values
(1,2000,400,3);
insert into line_item values
(2,2000,500,2);
insert into line_item values
(3,2000,600,1);
insert into line_item values
(4,2000,700,2);

insert into line_item values (1,3000,800,1);
insert into line_item values
(2,3000,900,1);


insert into line_item values(1,4000,110,1);
insert into line_item values
(2,4000,120,1);
insert into line_item values
(3,4000,130,1);
insert into line_item values
(4,4000,100,1);

insert into line_item values (1,5000,200,2);
insert into line_item values
(1,6000,300,1);
insert into line_item values
(2,6000,400,1);
insert into line_item values
(1,7000,500,1);
insert into line_item values
(2,7000,600,2);
insert into line_item values
(3,7000,700,2);
insert into line_item values
(1,8000,800,1);
insert into line_item values
(2,8000,900,1);
insert into line_item values
(3,8000,110,1);
insert into line_item values
(4,8000,120,1);
insert into line_item values
(5,8000,130,1);
insert into line_item values
(1,9000,100,1);
insert into line_item values
(2,9000,200,2);
insert into line_item values
(1,1010,300,2);
insert into line_item values
(2,1010,400,2);
insert into line_item values
(3,1010,500,2);

create table tax_codes
(state_code	varchar2(2),
tax_rate	float);

insert into tax_codes values
('WA',.11);
insert into tax_codes values
('OR',.15);
insert into tax_codes values
('MA',.12);
insert into tax_codes values
('AZ',.09);
insert into tax_codes values
('OK',.05);