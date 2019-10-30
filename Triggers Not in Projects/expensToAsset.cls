trigger expenseToAsset on Expense__c (before insert, before update) {
    //get asset id's of new expense records
    Set<Id> assetID = new Set<Id>();
    for(Expense__c x : trigger.new){
        assetId.add(x.ATS_Asset__c);
    }
    
    //query outside of the loop
    List<ATS_Asset__c> asset = [Select id, Tires__c, Repair__c, P_M__c from ATS_Asset__c where id in :assetID ];
    
    //list to be updated
    List<ATS_Asset__c> assetToUpdate = new List<ATS_Asset__c>(); 
    for(Expense__c exp: trigger.new){
        for(ATS_Asset__c a: asset){
            if(exp.Expense_Type__c == 'Tires'){
                a.Tires__c += exp.Amount__c; 
                assetToUpdate.add(a);
            }
            Else if(exp.Expense_Type__c == 'PM'){
                a.P_M__c += exp.Amount__c;
                assetToUpdate.add(a);
            }
            Else if(exp.Expense_Type__c == 'Repair'){
                a.Repair__c += exp.Amount__c; 
                assetToUpdate.add(a);
            }
        }
    }
    update assetToUpdate; 
}