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
    }   else if(trigger.isupdate){
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
                if(exp.Amount__c != trigger.oldMap.get(exp.id).amount__c && exp.Amount__c >trigger.oldMap.get(exp.id).amount__c){
                    for(ATS_Asset__c a: asset){
                    decimal newValue = exp.Amount__c - trigger.oldMap.get(exp.id).amount__c; 
                    if(exp.Expense_Type__c == 'Tires'){
                        a.Tires__c += newValue; 
                        assetToUpdate.add(a);
                        system.debug('asset '+ a.Tires__c + ' exp ' + exp.amount__c);
                    }
                    Else if(exp.Expense_Type__c == 'PM'){
                        a.P_M__c += newValue; 
                        assetToUpdate.add(a);
                        system.debug('asset '+ a.P_M__c + ' exp ' + exp.amount__c);
                    }
                    Else if(exp.Expense_Type__c == 'Repair'){
                        a.Repair__c += newValue;  
                        assetToUpdate.add(a);
                        system.debug('asset '+ a.repair__c + ' exp ' + exp.amount__c);
                    }
                }
              }else{
                  for(ATS_Asset__c a: asset){
                    decimal newValue = exp.Amount__c - trigger.oldMap.get(exp.id).amount__c; 
                    if(exp.Expense_Type__c == 'Tires'){
                        a.Tires__c -= newValue; 
                        assetToUpdate.add(a);
                        system.debug('asset '+ a.Tires__c + ' exp ' + exp.amount__c);
                    }
                    Else if(exp.Expense_Type__c == 'PM'){
                        a.P_M__c += newValue; 
                        assetToUpdate.add(a);
                        system.debug('asset '+ a.P_M__c + ' exp ' + exp.amount__c);
                    }
                    Else if(exp.Expense_Type__c == 'Repair'){
                        a.Repair__c += newValue;  
                        assetToUpdate.add(a);
                        system.debug('asset '+ a.repair__c + ' exp ' + exp.amount__c);
                    }
                }
              }
            } update assetToUpdate;}else{
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