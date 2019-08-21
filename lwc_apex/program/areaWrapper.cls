public class areaWrapper {

     @AuraEnabled
    public string label {get; set;}
    @AuraEnabled
    public string value{get; set; }
  
    public areaWrapper(string label, string value){
        this.label = label; 
        this.value = value; 
    }
}