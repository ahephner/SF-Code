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