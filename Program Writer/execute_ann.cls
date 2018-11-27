

//testing application cloning manually
//test apex logic 
Application__c newApp = new Application__c(Name = 'From Apex diff dates', Area__c= 'a0I3C000000ayZvUAI',
                                date__c = date.newInstance(2018, 10, 01), repeat__c = True, Number_of_Apps__c = 2, 
                                           Weeks_Apart__c = 1);

List<Application__c> apps = new List<Application__c>(); 

if(newApp.repeat__c == True){
    
    Integer days = Integer.valueOf(newApp.Weeks_Apart__c) * 7;
    for(Decimal i=0; i<newApp.Number_of_Apps__c; i++){
        //system.debug(days);
        newApp.date__c = newApp.date__c.addDays(days); 
        //newApp.Number_of_Apps__c += -1; 
        application__c cloned = newApp.clone(true);
        apps.add(cloned);
         
    }
    for(application__c j : apps){
        SYSTEM.DEBUG(j.area__c);
    }
    
}
system.debug(apps);
insert apps;  


//UNHIDE TO DESTROY ALL TEST APPLICATIONS!!!
//Application__c[] destroy = [Select name from application__c where CreatedById = '00541000006o7BzAAI'];
//delete destroy; 

//testing new program clone application
if(newPro.id != null){
               List<Application__c> copyApp = new List<Application__c>(); 
                for(Application__c x : [select a.Id, a.Name, a.Area__c, a.Program_ID__c, a.repeat__c, a.Note__c , 
             							a.Date__c,  a.Weeks_Apart__c, a.Number_of_Apps__c
                                        from Application__c a where Program_ID__c = :pro.id ]){
                                          
                                            Application__c app = x.clone(false);
                                            //x.Program__c = newPro.id; 
                                            copyApp.add(app); 
                                           
                                        } insert copyApp; 
                    }else{
                        return null; 
                    }


//inner query relationship between application and application products
Select name, date__c, (select Product_Name__c from Application_Products__r) from application__c limit 30

//testing inner selecting of products from application and sitting them into a list 

Application__c app = [Select a.Id, a.Name, a.Area__c, a.repeat__c, a.Note__c , 
             		  a.Date__c,  a.Weeks_Apart__c, a.Number_of_Apps__c, 
                      (select Application__c,  Area_Square_Feet_M__c,
                      Product_Name__c, Categories__c, K__c, K_Calc__c, 
                      K_Val__c,LBS_ACRE__c, N__c,N_Val__c, Note__c, OZ_M__c, 
                      P__c, P_Calc__c, P_Val__c,Product_Category__c, Product_Size__c, 
                      Product_Sub_Category__c, Rate__c, Total_Used_f__c, Units_Required__c
                      from Application_Products__r)
                      from Application__c a  where a.id = 'a0H3C000004GTGxUAO'];
//system.debug(app);
//notice how to declare list from inner query and set values from that query
List<Application_Product__c> prod = app.application_products__r; 

//loop through list here
for(Application_product__c p : prod){
    system.debug(p); 
}

List<sObject> records = new List<sObject>();
records.add(new Account(AccountExternalId__c='1234555', Name='ABCD Company'));

records.add(new Contact(account=new Account(AccountExternalId__c='1234555'),lastname = 'Testlast', ContactExternalId__c='3525'));

records.add(new AccountContact__c (Contact__r = new Contact(ContactExternalId__c='3525')));

insert records;