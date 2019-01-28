   ID recordType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer').getRecordTypeId();
        Account acct = new Account(); 
        acct.name = '5-ground';
        acct.Customer_Name__c = 'New Company';
        acct.Customer__c = '89';
        acct.RecordTypeId = recordType;
        insert acct;

        //create product
        Product__c prod = new Product__c(Product_Name__c='shovel', Name='shovel'); 
        insert prod; 

        
        //Create Sales Doc
        Sales_Document__c sd = new Sales_Document__c();
        sd.name = 'shovel sale';
        sd.sales_Doc_num__c = '696971';
        //get new account recordid
        sd.Customer__c = acct.id;
        sd.Doc_Type__c = 'Invoice';
        
        insert sd; 
        
        Sales_Doc_Detail__c testSale = new Sales_Doc_Detail__c();
        testSale.name = 'rabbit';
        testSale.sales_document__c = sd.ID;
        testSale.Product__c = prod.ID;
        //need to insert customer numb here as well 
        
       insert testSale;
List<String> custnum = new List<String>();
        custnum.add('89');  
 for(Sales_doc_Detail__c check: [Select ID, name from Sales_Doc_Detail__c where Customer__c LIKE: custnum]){
            system.debug(check.name);
        }



