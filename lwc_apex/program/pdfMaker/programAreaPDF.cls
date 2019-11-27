public class programAreaPDF {
    private ApexPages.StandardController ctl {get; set;}
    public program__c pro {get;set;}
    public list<application__c> apps {get;set;}
    public string name {get;set;}
    //public list<area__c> areas {get;set;}
    public list<wrapArea> wrapAreaList {get;Set;}
    
    public programAreaPDF(ApexPages.StandardController ctl){
        this.ctl = ctl; 
        pro = (program__c)ctl.getRecord();
        
        wrapAreaList = new List<wrapArea>();
        
        for(area__c i: [select name, Area_Sq_Feet__c,Total_Price__c from area__c where program__c =: pro.id]){
            wrapAreaList.add(new wrapArea(i));
        }
        	
        
        System.debug('3.Number of Queries used in this apex code so far: ' + Limits.getQueries());
		System.debug('3A.Total Number of SOQL Queries allowed in this apex code context: ' + Limits.getLimitQueries());
		System.debug('4.Number of CPU Time: ' + Limits.getCpuTime());
		System.debug('4A.Number of CPU Time: ' + Limits.getLimitCpuTime());
    }
    public pageReference createPDF(){
        return null; 
    }
    public class wrapArea{
        public area__c area{get;set;}
        public boolean selected{get;set;}
        
        public wrapArea(area__c x){
            area = x;
            selected = false; 
        }
        
    }
}