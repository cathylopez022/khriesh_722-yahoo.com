public with sharing class leadExtension 
{
	private final Lead lead;
	
	public leadExtension(ApexPages.StandardController stdController) {
        this.lead = (Lead)stdController.getRecord();
        
        //List<Opportunity> listOppty = [Select Id, Name from Opportunity where Id = :lead.ConvertedOpportunityId];
        
        //if(listOppty.size()>0)
        //{
        	
        //}
    }
    
    public PageReference redirectToOppty()
    {
    	PageReference pRef = null;
    	
    	if(lead.ConvertedOpportunityId != null)
    		pRef = new pageReference('/' + lead.ConvertedOpportunityId);
    	
    	return pRef;
    }
}