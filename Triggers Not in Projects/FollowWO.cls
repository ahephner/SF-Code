trigger FollowWO on AssignedResource (after insert) {
    
    

}

//query thoughts
//here is the way to get workorder id followers 
select parentid from EntitySubscription
select workordernumber from workorder where id = '0WOn00000000UxqGAE'
//these two get subscriber and userid
select subscriberid from EntitySubscription
select name from user where id = '005n0000003WyRdAAK'