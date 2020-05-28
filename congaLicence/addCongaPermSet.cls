public class addCongaPermSet {
	@InvocableMethod 
    public static void addCongaPermSet(List<string> userList){
        system.debug('invoc user id ' + userList);
        addPermSet(userList); 
    }
    @future
    public static void addPermSet(List<string> userList){
        //get package info
        PackageLicense pl = [SELECT Id, NamespacePrefix, AllowedLicenses, UsedLicenses, 
        					 ExpirationDate,Status FROM PackageLicense WHERE 
        					 NamespacePrefix = 'APXTConga4'];
        List<UserPackageLicense> UPL = new List<UserPackageLicense>();
        for(string u : userlist){
            system.debug('for loop ' + u);
            UserPackageLicense x = new UserPackageLicense();
            x.PackageLicenseId = pl.Id; 
            x.UserId = u; 
            UPL.add(x);
        } 
        try{
            upsert UPL; 
        }catch(exception e){
    		for (Integer i = 0; i < e.getNumDml(); i++) {
             // process exception here 
               System.debug(e.getDmlMessage(i)); 
               String status = e.getDmlStatusCode(i);
               System.debug(status + ' ' + e.getDmlMessage(i));
               if(status.equals('LICENSE_LIMIT_EXCEEDED')){
                string exceptionText = 'You tried to assign more licenses than available. ' 
                +' You tried to create '+ UPL.size()+' licenses but only have '
                + (pl.AllowedLicenses - pl.UsedLicenses) + ' licenses free.';
                System.debug(exceptionText);
               }
            }
        }
    }
}



//execute ann to delete during testing
// List<UserPackageLicense> before = [select  id, userID, packageLicenseId 
//                                    from UserPackageLicense where PackageLicenseId ='0502C00000002TPQAY'];

// system.debug('before '+before);

// List<UserPackageLicense> td = [select id, userID, packageLicenseId 
//              from UserPackageLicense 
//              where PackageLicenseId ='0502C00000002TPQAY' and userId='00541000006o7BzAAI'];
// delete(td);

// List<UserPackageLicense> after = [select  id, userID, packageLicenseId from UserPackageLicense where PackageLicenseId ='0502C00000002TPQAY'];

// system.debug('after '+ after); 