//This assumes that you have a platform event created called Order_Event__e !!Note platform events end in __e
//Also, you can only call triggers on events on after insert


trigger OrderEventTrigger on Order_Event__e (after insert) {
	List<Task> tl = new List<Task>(); 
    // Iterate through each notification.
    for (Order_Event__e event : Trigger.New) {
        if (event.Has_Shipped__c == true) {
            // Create Case to dispatch new team.
            Task t = new Task();
            t.Priority = 'Medium';
            t.Subject = 'Follow up on shipped order ' +
                event.Order_Number__c;
            t.OwnerId = event.CreatedById; 
            tl.add(t);
        }
   }
    insert tl; 
}


///test class example
@isTest
public class PlatformEventTest {
    @isTest static void test1() {
        // Create test event instance
        Order_Event__e orderEvent = new Order_Event__e(
            Has_Shipped__c=True,
            Order_Number__c='134',
            );
        Test.startTest();
        // Call method to publish events
        //this is how you publish using APEX
        Database.SaveResult sr = EventBus.publish(orderEvent);
        Test.stopTest();
        // Perform validation here
        // Verify that the publish was successful
        System.assertEquals(true, sr.isSuccess());
        // Check that the task that the trigger created is present.
        List<Task> tasks = [SELECT Id FROM Task];
        // Validate that this task was found.
        // There is only one test task in test context.
        System.assertEquals(1, tasks.size());
    }
}