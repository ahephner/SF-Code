trigger serviceAppointmentDateToWO on ServiceAppointment (after insert, after update) {
		id woID;
    	workorder wo; 
    	list<serviceappointment> allsa; 
    for(ServiceAppointment sa: Trigger.new){
        woID = sa.ParentRecordId;
        allsa = [select SchedStartTime from serviceappointment where parentrecordid = :sa.ParentRecordId ];
        system.debug(allsa);
    }
    wo = [select StartDate, enddate from workorder where id = :woID]; 
    system.debug('wo before ' + wo);
    for(serviceappointment s: allsa){
        if(s.SchedStartTime < wo.StartDate){
            wo.StartDate = s.SchedStartTime;
            
        }else if (s.SchedStartTime>wo.EndDate){
            wo.EndDate = s.SchedStartTime;
        }
    }system.debug('wo after ' + wo);
    upsert wo; 
        
}