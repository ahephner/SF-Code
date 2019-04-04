//no test case is written at this time due to it appears pre-installed managed package handling event
//this is assigning them to the follow though proven in soql 
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
        sub.SubscriberId = srid; 
        u = [select id from user where id in (select RelatedRecordId from ServiceResource where id =:srid)];
        //system.debug('here is u '+ u);
		//wo
        said = ar.ServiceAppointmentId; 
        wo = [select id from workorder where id in (select parentrecordid from serviceappointment where id = :said)];  
        system.debug('here is wo '+ wo);
        sub.ParentId = wo[0].id;
        system.debug('here is ParentID '+ sub.ParentID);
		sub.SubscriberId = u[0].id; 
        system.debug('here is subscriber '+ sub.subscriberid);
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