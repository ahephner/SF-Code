public class focusProductGoals {
    
    public class wrapperClass{
        public decimal cost;
        public decimal amt;
    }
	@AuraEnabled
    public static list<sales_goal__c> getGoals(){
        list<sales_goal__c> toUpdate = new list<sales_goal__c>();
		//get sales
        list<AggregateResult> golfFP = [select Sales_Document__r.sales_rep__c salesRep, SUM(Extended_Cost__c)cost, 
                                               Sum(Extended_Price__c)amt from Sales_Doc_Detail__c where Product_Focus_Golf__c = true 
                                        	  and Golf_Focus_Product_Category__c = 'Foliar-Pak + PB1'
                                              group by Sales_Document__r.sales_rep__c]; 
 			       
		map<string, wrapperclass> fpMap = new map<string, wrapperclass>();
        for(AggregateResult fp:golfFP){
            wrapperclass x = new wrapperclass();
            x.cost = (Decimal)fp.get('cost');
            x.amt = (Decimal)fp.get('amt');
            fpMap.put((string)fp.get('salesRep'), x); 
        }
        
        list<sales_goal__c> sgfp = [select id,name, progress_amount__c, sales_rep__c, product_cost__c from 
                                    sales_goal__c where focus_product_Category__c = 'Foliar-Pak' and sales_rep__c in :fpMap.keySet()];
        
        if(sgfp!=null || sgFP.size() >0){
            for(sales_goal__c sg:sgfp){
                wrapperclass x = fpMap.get(sg.Sales_Rep__c);
                sg.Progress_Amount__c += x.amt;
                sg.product_cost__c += x.cost; 
                toUpdate.add(sg);
            }
        }
		
        try{
        
          database.update(toUpdate, false);
        }catch(exception e){
            system.debug(e);
        }
        return null; 
    }

    	@AuraEnabled
    public static list<Sales_Doc_Detail__c> getSales(){

		list<Sales_Doc_Detail__c> sd = [select id, sales_document__r.sales_rep__c, extended_cost__c, extended_price__c, Golf_Focus_Product_Category__c, 
                                        LTO_Focus_Product_Category__c from Sales_Doc_Detail__c where Product_Focus_Sports__c = true or Product_Focus_Group__c = true];
        return sd; 
    }
    
    public static Integer updateGolf(){
        //get goals
        list<sales_goal__c> fpGoals = [select id, progress_amount__c,Product_Cost__c, sales_rep__c from Sales_Goal__c where  inactive__c = false and (Focus_Product_Category__c = 'Foliar-Pak' or 
                                      Focus_Product_Category__c = 'Bentgrass' or Focus_Product_Category__c = '28/44/Gold (Golf)' or Focus_Product_Category__c = 'TMI/ZOXY/Rotator (Golf)')];
        system.debug(fpGoals);
        return null;
    }
}

