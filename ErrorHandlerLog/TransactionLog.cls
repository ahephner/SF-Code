/*
You can crete a custom object called Error Log then use then create fields on that object to place things like error messages shown below
Example is from my developer org
Then you can call this error method in try catch block so you have longer lasting records of errors. 

This will throw and error in annyomous console and create a record

try{
    integer = 10/0;
}catch(exception){
    TransactionLogHandler.handleException(exception, 'DeveloperHub'); 
}

*/
public class TransactionLogHandler {
    public static void handleException(System.Exception ex, String processName){
        //use the error log object to make an entry of the error
        Error_Log__c transactionLog = new Error_Log__c(
        	Log_Details__C = ex.getStackTraceString() + '<br/> <strong> Message: </strong>'+ ex.getMessage()+
            				 '<br/>' + ex.getCause() + '<br/>' + ex.getTypeName() + '<br/>'
            				 + ex.getLineNumber(),
            Lod_DateTime__c = System.now(),
            Process_Name__c = processName 
            					
        );
        
        
            insert transactionLog; 
        
    }

}