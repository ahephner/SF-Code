trigger FollowWO on AssignedResource (after insert, after update) {
    id srid;
    id relatedRecord;
    user u;  
    //work order here
    id said; 
    workorder wo; 
    entitysubscription sub = new entitysubscription();
    for(AssignedResource ar: Trigger.new){
       //user info
        srid = ar.ServiceResourceId;
        u = [select id from user where id =:srid]; 
        //workorder
        said = ar.ServiceAppointmentId; 
       wo =[select id from workorder where id in (select parentrecordid from serviceappointment where id = :said) ]; 
       sub.ParentId = wo[0].id;
        sub.SubscriberId = u[0].id; 
    }
	  

}

//query thoughts
//here is the way to get workorder id followers 
select parentid from EntitySubscription
select workordernumber from workorder where id = '0WOn00000000UxqGAE'
//these two get subscriber and userid
select subscriberid from EntitySubscription
select name from user where id = '005n0000003WyRdAAK'

//service resource
//user lookup => RelatedRecordId