public class ATSAssetMileageCheck {
    public static void emailAssets(){
        Date lateDate = System.today() - 30; 
        EmailTemplate et = [select id from EmailTemplate where name = 'ATS Asset: Mileage Over Due' limit 1]; 
        list<Id> repIds = new list<Id>();
        
        List<ATS_Asset__c> overDue = [Select Id, Name, Last_Fuel_Entry_Date__c, Sales_Rep__r.OwnerId from ATS_Asset__c where Last_Fuel_Entry_Date__c <= :lateDate
                                     and Asset_Type__c ='Sales Rep Pickup (SRPU)' and sold__c = false];
        if(overdue.size()>1){
          for(Ats_Asset__c rep:overDue){
            	repIds.add(rep.Sales_Rep__r.OwnerId);
        	}
        
        	Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
        	mail.setTargetObjectIds(repIds);
        	mail.setSenderDisplayName('System Admin');
        	mail.setTemplateId(et.id);
        
        	Messaging.sendEmail(new Messaging.MassEmailMessage[]{mail}); 
    } 
        
    }

	
}