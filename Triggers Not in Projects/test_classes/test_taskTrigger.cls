@isTest
private class test_taskTrigger {
	    static testMethod void createEmailTask() {
        Contact smith = new Contact (LastName='Smith');
        insert smith;
        
        Task newEmail = new Task (Subject = 'Email: Quote', Description='Hey there', WhoId=smith.id);
        //test the class does not save if no description
        Task newEmail2 = new Task (Subject = 'Email: Quote', WhoId=smith.id);
        insert newEmail;
        insert newEmail2; 
       //check that the follow up task exists
       test.startTest();
        List <Task> task_afteremail = [SELECT Subject, WhoId, ActivityDate FROM Task WHERE WhoId = :smith.Id AND Subject = 'Email: Quote'];
        system.assert(task_afteremail.size()==1);
       test.stopTest();  
        //TODO: Other tests to try: cover the situations when we do NOT want a task created, also when many emails at once are created. 
	}
}
