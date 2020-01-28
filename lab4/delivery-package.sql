drop table delivery_service cascade constraints;
drop table package cascade constraints;

create table delivery_service
(delivery_service_id    number  Primary key,
delivery_service_name   varchar2(50) not null);

create table package
(package_id           number  PRIMARY KEY,
package_desc        varchar2(25) not null,
date_delivered      date not null,
fk_delivery_service_id      number);

alter table package 
add constraint fk_delivery_service
foreign key (fk_delivery_service_id)
references delivery_service (delivery_service_id);

insert into delivery_service (delivery_service_id, delivery_service_name)
values (12345, 'Untied Parcel Service');

insert into delivery_service (delivery_service_id, delivery_service_name)
values (23456,'Federal Excess');

insert into delivery_service (delivery_service_id, delivery_service_name)
values (34567,'USPS');

insert into package 
(package_id, package_desc, date_delivered, fk_delivery_service_id)
values (987,'Perfect Diamonds','14-Jun-2019',23456);

insert into package 
(package_id, package_desc, date_delivered, fk_delivery_service_id)
values (765, 'Care Package','29-Apr-2019',12345);

insert into package 
(package_id, package_desc, date_delivered, fk_delivery_service_id)
values (876, 'French Winos','19-Jul-2019',NULL);
