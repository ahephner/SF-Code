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
            }else if(lvn == x.getValue() && x.getLabel() == 'My May Monthly Goals'){
                render = 'product'; 
            }
            }
        }
        
     

}