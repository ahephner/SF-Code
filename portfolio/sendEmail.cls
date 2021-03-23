//not great but this runs on the flow and will send an autoresponse with a copy of my resume to the website user
public class sendEmail {
	id docId = '0691U00000IOMHPQA5';
    @invocableMethod
    public static void getUserEmail(list<string> mailAddress){
        system.debug(mailAddress);
        sendEmail(mailAddress);
    }
    public static string sendEmail(list<string> emailAdd){
        string isSuccess = '';
        string address = emailadd[0];
        system.debug('sendEmail '+address);
        ContentVersion wkshtDta = [SELECT Id, Title, FileType, VersionData, isLatest, ContentDocumentId 
                           		   FROM ContentVersion WHERE isLatest = true and Id = '0681U00000JlYGVQA3'];
        string filename = wkshtDta.Title +'.pdf';
        //string template = '00X1U000000v2FJUAY';
        Messaging.EmailFileAttachment attch = new Messaging.EmailFileAttachment();
        		attch.setBody(wkshtDta.VersionData);
        		attch.setFileName(filename);
        		attch.setContentType('application/pdf');
        		attch.setInline(false); 
       
        list<string> toAddress = new list<string>();
        		toAddress.add(address);
        //list<string> bccAddress = new list<string>();
        		//bccAddress.add('ajhephner178@gmail.com');
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        		//email.setTemplateId(template); 
        		email.setToAddresses(toAddress);
        		email.setSubject('Thank you for visiting!');
                email.setPlainTextBody('Thanks for visiting my site. I will be in touch shortly. In the meantime my resume is attached to this email. FYI this is an automated response'); 
        		//email.setBccAddresses(bccAddress);
        		//email.getHtmlBody();
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{attch});
        
        try{
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
            isSuccess = 'GOOD';
            return isSuccess; 
        }catch(exception e){
            system.debug(e.getMessage());
            isSuccess = e.getMessage() + '\n'+ e.getCause();
            return isSuccess; 
        }
        
    }
}