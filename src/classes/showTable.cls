public class showTable {

    public String oppId {get; set;}
    List<Opportunity> opps;
    
    public List<Opportunity> getOpps() {
        if(opps == null){
            opps = [select Id, Name, Account.Name from Opportunity limit 10];
        
        }
        return opps;
    }
}