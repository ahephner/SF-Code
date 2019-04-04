trigger FollowWO on AssignedResource (before insert, before update) {
    id srid;
    id relatedRecord;
    list<user> u;  
    //work order here
    id said; 
    list<WorkOrder> wo; 
    id woID; 
    id userID; 
    entitysubscription sub = new entitysubscription();
    for(AssignedResource ar: Trigger.new){
		//user
		srid = ar.ServiceResourceId;
        u = [select id from user where id =:srid];
		//wo
        said = ar.ServiceAppointmentId; 
        wo = [select id from workorder where id in (select parentrecordid from serviceappointment where id = :said)];  
        sub.ParentId = wo[0].id;
        sub.SubscriberId = u[0].id; 
    }
	  insert(sub); 

}
//BELOW IS HOW TO GET TO ID's THE TRIGGER DIRECTLY ABOVE IS WORKING 
//query thoughts
//here is the way to get workorder id followers 
select parentid from EntitySubscription
select workordernumber from workorder where id = '0WOn00000000UxqGAE'
//these two get subscriber and userid
select subscriberid from EntitySubscription
select name from user where id = '005n0000003WyRdAAK'

//service resource
//user lookup => RelatedRecordId