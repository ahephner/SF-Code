public class firstofmonth{

    list<Sales_Rep__c> reps; = [select id, Sales_Rep_Num__c from Sales_Rep__c where Active__c = True];

    Sales_Document__c doc = new Sales_Document__c(); 
    Sales_Doc_Detail__c detail = new Sales_Doc_Detail__c();

    list<Sales_Doc_Detail__c> listDetails = new list<Sales_Doc_Detail__c>();
    list<Sales_Document__c> listDocument = new list<Sales_Document__c>();

    public list<Sales_Rep__c> getreps(){
        reps = [select id, Sales_Rep_Num__c from Sales_Rep__c where Active__c = True];

        for(Sales_Rep__c x :reps){
            Sales_Document__c doc = new Sales_Document__c(); 
            //add requirements here make doc # = '1000000'+x.sales_rep_num__c;
            //assign to account we made to hold test data
        }
    }

}