global class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful{
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(
        'Select Id, LeadSource from lead');
    }
    global void execute(Database.BatchableContext bc, List<Lead> leads){
        list<lead> up = new list<lead>(); 
        for(lead x : leads){
            x.leadsource = 'Dreamforce';
            up.add(x);
        }
        update up; 
    }
    global void finish(Database.BatchableContext bc){
        
    }
}