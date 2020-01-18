Create table BICYCLE
	(Bicycle_id	varchar2(12),
	Brand_name	varchar2(125),
	Date_manufactured	date,
	Length		decimal(8,2),
	Height		decimal(8,2));
  
  describe BICYCLE;
  
  Insert into BICYCLE 
  (bicycle_id, brand_name, date_manufactured, length, height)
		Values ('12345','Schwinn',CAST('10-DEC-2017' AS DATE), 45.67, 18.90);
    
select * from bicycle;

update bicycle set brand_name = 'Yamaha';

select * from bicycle;

Delete from bicycle;

Drop table bicycle;

commit;
