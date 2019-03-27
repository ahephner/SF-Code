public  with sharing class multiquoteController {
    public List<wrapQuote> wrapQuoteList {get; set;} 
    public list<quote>  selectedQuotes{get;set;} 
    //public list<quote>  selected {get;set;}
    public decimal Total {get;set;}
    public quote qt {get;set;}
    private ApexPages.StandardController ctl {get; set;}
   // private Quote opp {get; set;}
    String sId; 
      
    public multiquoteController(ApexPages.StandardController controller ) {
    	
        this.ctl = controller;
        qt = (Quote)ctl.getRecord(); 
        quote[] id = [select opportunityid from quote where id =: qt.Id]; 
        
			
		wrapQuoteList = new List<wrapQuote>();
        //system.debug('here is qt' + opid);
        
        //select info to store on the screen 
		for(quote i: [select id, name,TotalPrice, description,Start_Date__c, opportunityID, 
                      createddate, ExpirationDate,billingstreet,billingstate, shippingstreet, shippingstate,
                      CreatedBy.Name,CreatedBy.Email, QuoteNumber, BillingName, ShippingName from quote
				      where AccountId in (select accountid from opportunity where id =:id[0].opportunityid)]) 
        		     wrapQuoteList.add(new wrapQuote(i)); 
                      }




    public void getSelected(){
        selectedQuotes = new List<quote>();
        Total =0;
        system.debug('in getSelected'); 
       system.debug('id params ' +apexPages.currentPage().getParameters().get('id'));
        for(wrapQuote wrapQuoteObj: wrapQuoteList){
            if(wrapQuoteObj.selected == true){
                selectedQuotes.add(wrapQuoteobj.qu);
                Total += wrapQuoteobj.qu.totalprice; 
                }        
          }
    }

    //wrapper 
    public class wrapQuote{
        public quote qu{get; set;}
        public boolean selected{get; set;}

        public wrapQuote(quote x){
            qu = x;
            selected = false;  
        }
    }
    

    public PageReference savePDF_File() {
    	system.debug('in pdf maker');
        //Retrieve Id
        String sId = apexPages.currentPage().getParameters().get('id');
        
        //Add URL to page
        PageReference pdf = Page.multiquotepdf;
        pdf.getParameters().put('id',sId);
        
        //Build File
        String sPdfName = 'QuoteCopy' + '.pdf';
        ContentVersion oContentVersion = new ContentVersion();
        Blob oBody;
        try {
            oBody = pdf.getContent();
            system.debug('oBody ' + oBody);
        } catch (VisualforceException e) {
            oBody = Blob.valueOf('Error!');
        }
        
        oContentVersion.VersionData = oBody;
        oContentVersion.Title = sPdfName;
        oContentVersion.PathOnClient = sPdfName + '.pdf';
        insert oContentVersion;
        
        //Set Content Version of File
        Id contentDocId = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = : oContentVersion.Id LIMIT 1].ContentDocumentId;
        
        //SetContentDocumentLink
        ContentDocumentLink contentDocLink = new ContentDocumentLink();
        contentDocLink.ContentDocumentId = contentDocId;
        contentDocLink.LinkedEntityId = sId;
        contentDocLink.ShareType = 'V';
        insert contentDocLink;
        
        //After creating the file, take user back to the record file was generated from
        PageReference clientCopyPage = new PageReference('/' + sId);
        clientCopyPage.setRedirect(true);
        return clientCopyPage;
        
    }

       // pagereference redirect = new PageReference('/lightning/r/Account/001n000000TyHouAAF/view'); 
        //redirect.setRedirect(true);
}