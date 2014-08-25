public class MyController {
User usr;

String strErrMsg;
 
public PageReference save() {

    Database.update(usr);
    
    
    //Database.SaveResult[] sr = Database.update(usr);

    //for (Integer i = 0; i< sr.size(); i++)
    //{
    //    ApexPages.addMessages(sr[i].errors[0].message);
    //}
    
return null;
}

public User getUser() 
{

if(usr == null)
    usr = [select id, FirstName, LastName, isActive, name from User
    where id = :ApexPages.currentPage().getParameters().get('uid')];
    return usr;

}

public List <User> getUsers()
{
    return [select id, FirstName, LastName, isActive, name from User];
}

}