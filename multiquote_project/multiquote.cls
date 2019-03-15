public class multiquoteController {
    //get set declared in the methods
    public List<wrapQuote> wrapQuoteList {get; set;} 
    public list<quote>  selectedQuotes{get;set;} 
   
    //here is how we get the correct way to pass the additional fields
    //quote[] id = [select opportunityid from quote where id= :apexpages.currentpage().getparameters().get('id')];
    
   String id = '006n0000008K07EAAS';

    public multiquoteController(){
			wrapQuoteList = new List<wrapQuote>();
        //select info to store on the screen 
        for(quote i: [select id, name,TotalPrice, description,Start_Date__c, opportunityID, multi_qutoe__c,
                      createddate, ExpirationDate from quote
				     where AccountId in (select accountid from opportunity where id =:id)])//[0].opportunityid)]; 
        		     wrapQuoteList.add(new wrapQuote(i)); 
                  
    }
    //method to get checked values 
    public void getSelected(){
        selectedQuotes = new List<quote>(); 
       
        for(wrapQuote wrapQuoteObj: wrapQuoteList){
            if(wrapQuoteObj.selected == true){
                selectedQuotes.add(wrapQuoteobj.qu);
                }        
          }
    }

   
    //wrapper 
    public class wrapQuote{
        public quote qu{get; set;}
        public boolean selected{get; set;}
        //set wrapper inputs
        public wrapQuote(quote x){
            qu = x;
            selected = false;  
        }
    }
    

           // pagereference redirect = new PageReference('/lightning/r/Account/001n000000TyHouAAF/view'); 
        //redirect.setRedirect(true);
}