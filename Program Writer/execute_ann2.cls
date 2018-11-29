//testing adding products to applications using outside foreign keys
Date dt = Date.today();
dt = dt.addDays(7);
Application_Product__c newProduct = new Application_Product__c(
Product__c ='a0A3C000001MlC3UAK', 
application__c='a0H3C00000425h1UAA');
// Create the parent reference.
// Used only for foreign key reference
// and doesn't contain any other fields.
Application__c app = new Application__c(
App_ExernalId__c='SAP111111');
//newProduct.Application__c = app;
// Create the Account object to insert.
// Same as above but has Name field.
// Used for the insert.
Application__c parentApp = new Application__c(
Name='Join',
Area__c = 'a0I3C000000bPYOUA2',
App_ExernalId__c='SAP111111');
// Create the account and the opportunity.
Database.SaveResult[] results = Database.insert(new SObject[] {
parentApp, newProduct });
// Check results.
for (Integer i = 0; i < results.size(); i++) {
if (results[i].isSuccess()) {
System.debug('Successfully created ID: '
+ results[i].getId());
} else {
System.debug('Error: could not create sobject '
+ 'for array element ' + i + '.');
System.debug(' The error reported was: '
+ results[i].getErrors()[0].getMessage() + '\n');
}
}


