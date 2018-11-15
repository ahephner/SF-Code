Application__c newApp = new Application__c(Name = 'From Apex', Area__c= 'a0I3C000000ayZvUAI',
                                date__c = date.newInstance(2018, 10, 01), repeat__c = True, Number_of_Apps__c = 2, 
                                           Weeks_Apart__c = 1);
system.debug(newApp);
List<sObject> apps = new List<sObject>(); 

if(newApp.repeat__c == True){
    
    Integer days = Integer.valueOf(newApp.Weeks_Apart__c) * 7;
    for(Decimal i=0; i<newApp.Number_of_Apps__c; i++){
        system.debug(days);
        newApp.date__c = newApp.date__c.addDays(days); 
        //newApp.Number_of_Apps__c += -1; 
        sobject cloned = newApp.clone(true);
        apps.add(cloned);
         
    }
    
    
}
system.debug(apps);
//insert apps; 
//quick clean
//Application__c[] destroy = [Select name from application__c where name like '%Apex%'];
//delete destroy; 