public class rewardsListView {
    public ApexPages.StandardSetController setCon;
public List<Sales_Document__c> LstSelectedDocs {
        get;
        private set;
    }
    public string accountId {
        get;
        set; 
    }
     //List View Controller
    public  rewardsListView(ApexPages.StandardSetController listcontroller){
        //setCon = listcontroller; 
        Set <Id> selectedDocs = new set <Id>();
        LstSelectedDocs = new List<Sales_Document__c>();
         
        for(Sales_Document__c x :(Sales_Document__c[]) listcontroller.getSelected()){
            selectedDocs.add(x.id);
        }
        LstSelectedDocs = [select id, name, Product_Sub_Total__c from sales_document__c where id in:selectedDocs]; 
        accountID = [Select customer__c from sales_document__c where id in:selectedDocs limit 1].customer__c; 
    }
}