Global class MassSalesGoalEdit implements Database.Batchable<sObject>, Database.Stateful{
    global Integer recordsProcessed = 0;
    string query;
    
    global MassSalesGoalEdit(string setWhere){
        query = 'Select Id, Inactive__c from Sales_Goal__c where '+setWhere;
        system.debug(query);
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Sales_Goal__c> goals){
        list<Sales_Goal__c> up = new list<Sales_Goal__c>();
        if(goals.size()>0){
            for(Sales_Goal__c sg: goals){
                sg.inactive__c = true; 
                up.add(sg); 
                recordsProcessed = recordsProcessed + 1;
            }
        }
        try{
            system.debug('processed '+recordsProcessed);
        	update up;     
        }catch(exception e){
            system.debug(e +' something happened');
        }
        
    }
    
    global void finish(Database.BatchableContext bc){
       	system.debug('finished '+ recordsProcessed);
         AsyncApexJob a = [Select Id, Status,ExtendedStatus,NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email    from AsyncApexJob where Id =:BC.getJobId()];
      
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        system.debug(a.createdby.email);
        String[] toAddresses = new String[] {a.CreatedBy.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Match Merge Batch ' + a.Status);
        mail.setPlainTextBody('records processed ' + recordsProcessed +   ' with '+ a.NumberOfErrors + ' failures.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
       
    }
}