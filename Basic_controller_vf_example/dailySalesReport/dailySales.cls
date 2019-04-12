public class dailySales {
     list<Sales_Rep__c> reps;    
   
    public list<Sales_Rep__c> getreps(){
        return reps = [select name, Prev_YTD_Sales__c, YTD_Sales__c,YTD_Margin__c, JDT_Service_YTD_Sales__c,
                       TM_Sales__c, TM_JDT_Sales__c, Open_Orders__c,TM_Margin__c
                       from sales_rep__c where Active__c = True]; 
    }
    
}