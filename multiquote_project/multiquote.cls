public class multiquote {
    private ApexPages.StandardController controller {get; set;}
    private quote q;
    public list<quote> quotes;
    //here is how we get the correct way to pass the additional fields
    //quote[] id = [select opportunityid from quote where id= :apexpages.currentpage().getparameters().get('id')];
   	
   String id = '006n0000008K07EAAS';
   public multiquote(ApexPages.StandardController controller) {
        this.q = (Quote)controller.getRecord();
    }
    public list<Quote> getquotes(){
        system.debug('here is the id ' + id);
        system.debug('here is opp id ' );
        //select info to store on the screen 
        quotes = [select id, name,TotalPrice, description, opportunityID from quote
				 where AccountId in (select accountid from opportunity where id =:id)];//[0].opportunityid)]; 
        system.debug('here is the array ' +quotes);
        return quotes; 
    }

}