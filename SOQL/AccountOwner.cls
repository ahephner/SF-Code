//normal everyday job to see accounts not owned by salesrep on the account. 
//this shows who is th owner and who ils the rep
SELECT Id, name, OwnerId, Owner.username,  Sales_Rep__r.name, Sales_Rep__c FROM Account 
WHERE Sales_Rep__r.Salesforce_User__c != null AND Owner_Not_Rep__c = true and ownerid != '00541000006o7BzAAI' 


//like above less detail used for dataloader. to id's are traci and I 
SELECT Id, OwnerId, Sales_Rep__r.Salesforce_User__c  FROM Account 
WHERE Sales_Rep__r.Salesforce_User__c != null 
AND Owner_Not_Rep__c = true and ownerid != '00541000006o7BzAAI' and ownerid != '00541000001kAQpAAM'