//class adds conga licence to a user
public class addCongaPermSet {
    //expose method to flow
	@InvocableMethod 
    public static void addCongaPermSet(List<string> userList){
        system.debug('invoc user id ' + userList);
        addPermSet(userList); 
    }
    //because we are using mixed sOjects we need a future method
    //makes it async
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

        }catch(dmlexception e){
    		system.debug(e.getMessage());
        }
    }
}