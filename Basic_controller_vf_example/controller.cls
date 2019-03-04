public class manContact {
	
    //these are getting the values from the vf page
    //you get set here
    Public String fName {get;set;}
    Public String lName {get;set;}
    Public string dept {get;set;}
    //this list will store our contacts returned in get method below
    list<contact> cons; 
    //this save method is called in the button action on vf page
    //note that void does not return a value
    
    public void save(){
        contact c = new contact(
        lastname = lName,
        firstname = fName,
        Department = dept
        );
        insert c; 
        lName = '';
        fName='';
        dept = ''; 
            
    }
    //initalize our list from above and return it
    //now it is avaliable in for display in vf page
    public list<contact> getcons(){
        return cons = [select name from contact]; 
    }
}