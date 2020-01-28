select package_desc, date_delivered, delivery_service.DELIVERY_SERVICE_NAME, delivery_service.DELIVERY_SERVICE_ID 
from package join delivery_service 
on package.fk_delivery_service_id = delivery_service.DELIVERY_SERVICE_ID;


select delivery_service_name, package_desc, date_delivered
from delivery_service left outer join package
on delivery_service.DELIVERY_SERVICE_ID = package.FK_DELIVERY_SERVICE_ID;


select package_desc, date_delivered, delivery_service_name
from package left outer join delivery_service
on package.FK_DELIVERY_SERVICE_ID = delivery_service.DELIVERY_SERVICE_ID
order by delivery_service.DELIVERY_SERVICE_NAME;


select package_desc, date_delivered, delivery_service_name
from package full outer join delivery_service
on package.FK_DELIVERY_SERVICE_ID = delivery_service.DELIVERY_SERVICE_ID
order by package_desc desc;
