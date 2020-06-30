trigger quoteTask on Task (after insert) {
    	system.debug('running trigger');
    	TaskTriggerHandler.followUpTask(trigger.new);     
   
}