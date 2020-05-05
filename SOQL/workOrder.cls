//get serviceappointments that are closed and don't have an assigned service resource
SELECT Id,status,Area_Manager__c,DueDate, Hidden_Work_Order_ID__r.Opp_Name__c,Hidden_Work_Order_ID__r.Status, Hidden_Work_Order_ID__r.ServiceAppointmentCount 
FROM ServiceAppointment where id not in ( select ServiceAppointmentId from  AssignedResource) and status = 'Completed'	


//product2 query from opportunitylineitem
select product2id, product2.name from opportunitylineitem where opportunityid = YOUR OPPORTUNITYID