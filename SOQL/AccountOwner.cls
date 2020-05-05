//normal everyday job to see accounts not owned by salesrep on the account. 
//this shows who is th owner and who ils the rep
SELECT Id, OwnerId, Sales_Rep__r.Salesforce_User__c, name, owner.username, Sales_Rep__r.Name  
FROM Account WHERE Sales_Rep__r.Salesforce_User__c != null AND Owner_Not_Rep__c = true  and OwnerId != '00541000006o7BzAAI'

//like above less detail used for dataloader. to id's are traci and I 
SELECT Id, OwnerId, Sales_Rep__r.Salesforce_User__c  FROM Account 
WHERE Sales_Rep__r.Salesforce_User__c != null 
AND Owner_Not_Rep__c = true and ownerid != '00541000006o7BzAAI' and ownerid != '00541000001kAQpAAM'

//accounts with no contacts
select id, name from accounts where id not in (select accountid from contact)

//get sum and group by rep...cant run in dataloader
SELECT SUM(Extended_Price__c), Sales_Rep__c FROM Sales_Doc_Detail__c 
WHERE Doc_Date__c >= 2018-10-01 AND Golf_Focus_Product_Category__c LIKE '%Bentgrass%' Group by Sales_Rep__c

//cross reference to quote using accountid from opportunity
select id, name,TotalPrice, description from quote
where AccountId in (select accountid from opportunity where id =:id);

/