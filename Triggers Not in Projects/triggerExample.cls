trigger AccountTrigger on Account (before update){
    //get accounts of the new records
    Set<Id> accountIds = new Set<Id>();
    for(Account temp: trigger.new){
        accountIds.add(temp.id);
    }

    //query outside the for loop: this will avoid hitting govenor limit of 100 soql query
    List<Contact> contacts = [select Id, FirstName, LastName, description from contact where accountId in :accountIds];

    //Initiate a list to builkify the records to process: perform single DML call
    List<Contact> contactsToUpdate = new List<Contact>();
    for(account account: trigger.new){
        for(contact c: contacts){
            c.description = c.FirstName + ' ' + c.LastName;
            contactsToUpdate.add(c);
        }
    }
    //single dml call outside of the loop
    update contactsToUpdate; 
}
