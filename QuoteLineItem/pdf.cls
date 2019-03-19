   //reference not part of this project 
   public PageReference savePDF_File() {
    	
        //Retrieve Id
        String sId = apexPages.currentPage().getParameters().get('id');
        
        //Add URL to page
        PageReference pdf = Page.ClientCopy;
        pdf.getParameters().put('id',sId);
        
        //Build File
        String sPdfName = 'ClientCopy' + '.pdf';
        ContentVersion oContentVersion = new ContentVersion();
        Blob oBody;
        try {
            oBody = pdf.getContent();
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