public class TaskTriggerHandler {
    public static void followUpTask(List<Task> followUp){
        //due date
        Date due = Date.today();
        due = due.addDays(7);
        DateTime remind = System.now()+5; 
        
        List<Task> newTasks = new List<Task>();
        
        for(task x: followUp){
            system.debug(x);
            //limit here instead
            if( x.Subject.startsWith('Email:') && x.Subject != null && x.Description !=null&&
               (x.Subject.contains('Quote') || x.Subject.contains('quote')||x.Description.contains('quote')||x.Description.contains('Quote'))){
                Task nt = new Task(
                    Subject = 'Follow up '+ x.subject,
                    IsReminderSet = True,
                    ReminderDateTime = remind, 
                    OwnerID = x.OwnerId,
                    Priority = 'Normal',
                    ActivityDate = due,
                    Status = 'Open',
                    WhoId = x.WhoId,
                    Description = x.Description
				);
            
                newTasks.add(nt);
               }     
        }
        try{
            insert newTasks;
        }catch(exception e){
            system.debug('error -> '+e.getMessage());
            
        }
    }
}