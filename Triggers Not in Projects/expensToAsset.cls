trigger expenseToAsset on Expense__c (before insert, before update, before delete) {
    if(Trigger.isDelete){
        Set<Id> aD = new Set<id>();
        for(expense__c i : trigger.old){
            ad.add(i.ATS_Asset__c);
        }
        
        List<ATS_Asset__c> asset = [Select id, Tires__c, Repair__c, P_M__c from ATS_Asset__c where id in :aD ];
        
        List<ATS_Asset__c> subLine = new List<Ats_Asset__c>();
        
        for(Expense__c d : trigger.old){
            for(ATS_Asset__c up: asset){
                if(d.Expense_Type__c == 'Tires'){
                    up.Tires__c -= d.Amount__c; 
                    subLine.add(up);
                }
                Else if(d.Expense_Type__c == 'PM'){
                    up.P_M__c -= d.Amount__c;
                    subLine.add(up);
                }
                Else if(d.Expense_Type__c == 'Repair'){
                    up.Repair__c -= d.Amount__c; 
                    subLine.add(up);
                } Else{
                    d.addError('something is wrong');
                }
              }
            } update subLine; 
        } else {
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
}