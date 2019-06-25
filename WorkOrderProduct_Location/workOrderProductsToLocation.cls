public class workOrderProductsToLocation {
//need an extension
    private ApexPages.StandardController controller{get;set;}
    private workorder wo {get;set;}
    public workOrderProductsToLocation(ApexPages.StandardController controller){
        this.controller = controller; 
        
        wo = (WorkOrder)controller.getRecord();
    }
    
    public PageReference send(){
        return null;
    }
}