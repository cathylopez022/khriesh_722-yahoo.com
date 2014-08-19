public class updateIsActive
{

public Boolean IsActive {get; set;}

public String getBoolValue() {
return 'BoolValue';
}

public void updateUser()
{
 User u = new User(Id='00580000001jX5R', IsActive = false); 
 
 update u;
}

}