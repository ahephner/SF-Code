//This extension causes the vf page salesgoallistview to decide which page to show to allow mass editing of budgets
//to add another mass edit page add another else if !!be sure to use the break or it will keep evaluating through the for loop and you will get else everytime!
public class salesGoalListViewExt {
	public ApexPages.StandardSetController ctl {get; set;}
    //public list<selectoption> lvn {get; set;}  
    public string render {get;set;} 
    
    public salesGoalListViewExt( ApexPages.StandardSetController controller ) {
         this.ctl = controller; 
         //lvn = ctl.getListViewOptions();
		string lvn = ctl.getFilterId();
        system.debug('id ' +lvn);
        list<selectoption> so = ctl.getListViewOptions(); 
        for(selectoption x : so){
            if(lvn == x.getValue() && x.getLabel() == 'My Active Goals - By Customer' ){
                render = 'account';
                break; 
            }else if(lvn == x.getValue() && x.getLabel() == 'My Product Forecast'){
                render = 'product'; 
                break; 
            }else{
                render = 'none'; 
            }
            }
        }
        
}

//Start to order by customer name then save. 
// public class salesGoalListViewExt {
// 	public ApexPages.StandardSetController ctl {get; set;}
//     public string lvn {get; set;}  
//     public string render {get;set;} 
//     public list<sales_goal__c> sgList {get; set;}
//     public salesGoalListViewExt( ApexPages.StandardSetController controller ) {
//          this.ctl = controller; 
//          //lvn = ctl.getListViewOptions();
// 	    lvn = ctl.getFilterId();
//         system.debug('id ' +lvn);
//         list<selectoption> so = ctl.getListViewOptions(); 
//         for(selectoption x : so){
//             if(lvn == x.getValue() && x.getLabel() == 'My Active Goals - By Customer' ){
//                 render = 'account';
//                 order();
//                 break; 
//             }else if(lvn == x.getValue() && x.getLabel() == 'My Product Forecast'){
//                 render = 'product'; 
//                 order(); 
//                 break; 
//             }else{
//                 render = 'none'; 
//             }
//             }
//         }
//     public  list<sales_goal__c> order(){
//        list<id> selectedIds = new list<Id>(); 
//         sgList = new list<sales_goal__c>(); 
//         for(Sales_Goal__c sg: (List<Sales_Goal__c>) ctl.getSelected()){
//            selectedIds.add(sg.Id); 
//         } 
//         sgList = [select id, customer__r.id, customer_name__c, Prev_Month_Rep_Forecast__c,
//                  Current_Month_Prev_Year__c, Forecast_Amount__c,Updates__c, Product_Name__c,
//                  Product__r.ID, Actual_Amount__c, Prev_Qty__c,Qty_Forecast__c from
//                  sales_goal__c where id IN :selectedIds ORDER BY customer_name__c nulls last]; 
//         return sgList;
//     }
//     public pagereference updateRecord(){
//         update sgList; 
//         return new pageReference('https://advancedturf--ppchange.lightning.force.com/lightning/o/Sales_Goal__c/list?filterName='+lvn); 
//     }
        
     

// }