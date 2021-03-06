//This extension causes the vf page salesgoallistview to decide which page to show to allow mass editing of budgets
//to add another mass edit page add another else if !!be sure to use the break or it will keep evaluating through the for loop and you will get else everytime!
public class salesGoalListViewExt {
	public ApexPages.StandardSetController ctl {get; set;}
    public string lvn {get; set;}  
    public string render {get;set;} 
    public list<sales_goal__c> sgList {get; set;}
    public salesGoalListViewExt( ApexPages.StandardSetController controller ) {
         this.ctl = controller; 
         //lvn = ctl.getListViewOptions();
	    lvn = ctl.getFilterId();
        list<selectoption> so = ctl.getListViewOptions(); 
        for(selectoption x : so){
           // system.debug(so);
            if(lvn == x.getValue() && x.getLabel() == 'My November Forecast - By Customer' ){
                render = 'account';
                orderByCustomerName();
                break; 
            }else if(lvn == x.getValue() && x.getLabel() == 'My Product Forecast'){
                render = 'product'; 
                orderByProduct(); 
                break; 
            }else if(lvn == x.getValue() && x.getLabel() == 'My Annual Account Forecast'){
                render = 'annualaccount';
                orderByCustomerName();
                break; 
            }else{
                render = 'none'; 
            }
            }
        }
    public  list<sales_goal__c> orderByCustomerName(){
       list<id> selectedIds = new list<Id>(); 
        sgList = new list<sales_goal__c>(); 
        for(Sales_Goal__c sg: (List<Sales_Goal__c>) ctl.getSelected()){
           selectedIds.add(sg.Id); 
        } 
        sgList = [select id, customer__r.id, customer_name__c, Prev_Month_Rep_Forecast__c,Open_Order_T_M__c,
                 Current_Month_Prev_Year__c, Forecast_Amount__c,Updates__c, Product_Name__c,
                 Product__r.ID, Actual_Amount__c, Prev_Qty__c,Qty_Forecast__c, Date__c, End_Date__c, Prev_Forecast__c from
                 sales_goal__c where id IN :selectedIds ORDER BY customer_name__c nulls last]; 
        return sgList;
    }
    
    public list<sales_goal__c> orderByProduct(){
        list<id> selectedIds = new list<id>(); 
        sgList = new list<sales_goal__c>(); 
        
        for(Sales_Goal__c sg: (List<Sales_Goal__c>) ctl.getSelected()){
           selectedIds.add(sg.Id); 
        } 
        
        sgList = [select id, customer__r.id, customer_name__c, Prev_Month_Rep_Forecast__c,Open_Order_T_M__c,
                 Current_Month_Prev_Year__c, Forecast_Amount__c,Updates__c, Product_Name__c,
                 Product__r.ID, Actual_Amount__c, Prev_Qty__c,Qty_Forecast__c, Date__c, End_Date__c from
                 sales_goal__c where id IN :selectedIds ORDER BY Prev_Qty__c DESC nulls last]; 
        return sgList; 
    }
    
    public pagereference updateRecord(){
        update sgList; 
        return new pageReference('https://advancedturf.lightning.force.com/lightning/o/Sales_Goal__c/list?filterName='+lvn); 
    }
        
     

}