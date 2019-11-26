//without this we couldn't add to document
//here is how we find the record type and set to var
ID recordType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer').getRecordTypeId();
system.debug(recordType);

Account comp = new Account();
comp.name = '509-New Company';
comp.Customer_Name__c = 'New Company';
comp.Customer__c = '1056';
//add it to new account record
comp.RecordTypeId = recordType; 
insert comp;



Sales_Document__c n = new Sales_Document__c();

n.name = 'test from sf';
n.Sales_Doc_Num__c = '90909';
n.Customer__c = comp.id; 
n.Doc_Type__c = 'Invoice';
insert n;


system.debug('new account');
system.debug(comp.id);
system.debug('new sales doc');
system.debug(n);


