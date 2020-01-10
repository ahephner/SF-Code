public class programPDF {
   	//public string id = 'a0J2h000000T4vEEAS';
    private ApexPages.StandardController ctl {get; set;}
    public program__c pro {get;set;}
    public program__c info {get;set;}
    public list<application_product__c> appProd {get; set;}
    public string title {get;set;}
    public list<products> sumProd {get;set;}
    public products totals {get;set;}
//class for application products makes it easier to put on vfp 
public class products{
    public string id {get;set;}
    public decimal units {get; set;}
    public decimal price {get;set;}
    public boolean head{get;set;}
    public string name{get;set;}
}
    
    public programPDF(ApexPages.StandardController ctl){
        this.ctl = ctl;
        
        pro = (program__c)ctl.getRecord();
        
        info = [select name, Prepared_For__c,Prepared_For_Typed__c, CreatedBy.Name, createdby.MobilePhone, createdby.email from program__c where id = :pro.Id]; 
        //system.debug('id -> '+ pro.Id);
		AggregateResult[] appProd = [select Product__c pc, sum(Units_Required__c) units, sum(Total_Price__c) price
       									    FROM application_product__c
       									    WHERE program_id__c = :pro.id
       								        GROUP BY ROLLUP(Product__c)
       									    ORDER BY Product__c]; 
         totals = new products();
         sumProd = new list<products>();
		set<id> pID = new set<id>();
        for(aggregateResult ap: appProd){
			products wrapper = new products();
    		wrapper.id = (String) ap.get('pc');
    
    		if(ap.get('pc') != null){
        		wrapper.head= true;
    		}
    		wrapper.units = ap.get('units') != null?((decimal)ap.get('units')):null;
    		wrapper.price = ap.get('price') != null ?((decimal)ap.get('price')):null;
    		
            if(wrapper.head == true){
    			sumProd.add(wrapper);
        		pId.add(wrapper.id); 
            }Else{
                totals.units = wrapper.units;
                totals.price = wrapper.price; 
            }
		}
        for(product__c names : [select id, product_name__c from product__c where id in :pId]){
    		for(products z: sumProd){
        		if(z.id == names.id){
            		z.name = names.product_name__c; 
        		}
    		}
		}
}
    
    
    public pageReference prodSummary(){
		PageReference pdf = Page.programAllProductsPDF;
        pdf.getParameters().put('id',pro.Id);
        
        //Build File
        String sPdfName = title;
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
        contentDocLink.LinkedEntityId = pro.Id;
        contentDocLink.ShareType = 'V';
        insert contentDocLink;
        //After creating the file, take user back to the record file was generated from
        PageReference clientCopyPage = new PageReference('/' + pro.Id);
        clientCopyPage.setRedirect(true);
        return clientCopyPage;    
    }
    
}