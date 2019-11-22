public class programPDF {
   	//public string id = 'a0J2h000000T4vEEAS';
    private ApexPages.StandardController ctl {get; set;}
    public program__c pro {get;set;}
    public list<application_product__c> appProd {get; set;}
    public string title {get;set;}
    
    //below is for all area pdf
    public list<area__c> areas {get;set;}
    public List<Application__c> aApplications {get;set;}
    public List<Application_Product__c> aApplicationProducts {get;set;}
    
    public programPDF(ApexPages.StandardController ctl){
        this.ctl = ctl;
        pro = (program__c)ctl.getRecord();
        system.debug('id -> '+ pro.Id);
                appProd = [select  product_name__c,Units_Required__c,
                  Total_Price__c from application_product__c where program_id__c = :pro.Id ];
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
        return clientCopyPage;    }
    
    public pageReference areaSummary(){
        areas = [select Area_Acres__c, Area_K_Total__c, Area_N_Total__c, Area_P_Total__c, Area_Sq_Feet__c, Date__c, Name, 
                Program__c, Type__c, OwnerId
                from Area__c where program__c =: pro.id];
       
        List<Id> areaIds = new List<Id>(); 
       
        for(Area__c a : areas){
            areaIds.add(a.Id); 
        }
        aApplications = [select Application_K_Total__c, Application_N_Total__c, Application_P_Total__c, Area__c, Month__c, Week__c, Name, Date__c 
                        from Application__c where Area__c in :areaIds order by Date__c Asc ];
                        
        List<Id> appIds = new List<Id>();
                        
        for(Application__c app : aApplications) {
            appIds.add(app.Id);
        }
                        
        aApplicationProducts = [select Area_Square_Feet_M__c, Categories__c, K__c, LBS_ACRE__c, N__c, OZ_M__c, P__c, Product__c, Total_Used_f__c,
                                Product__r.Name, Product_Name__c, Application__c, Note__c, Note_Other__c, 
                                N_Val__c, P_Val__c, K_Val__c 
                                from Application_Product__c where Application__c IN: appIds];
        return null; 
    }
}