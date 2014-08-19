public with sharing class OpportunityProductExtension 
{
	private final OpportunityLineItem oli;
	private string opptyId;
	public OpportunityProductExtension(ApexPages.StandardController stdController) {
        this.oli = (OpportunityLineItem)stdController.getRecord();
    }
    
    public pageReference doInsert()
    {
    	PageReference pRef;
    	opptyId = String.valueOf(ApexPages.currentPage().getParameters().get('retURL'));
    	opptyId = opptyId.substring(1, 16);
    	pref = new PageReference('/' + opptyId);
    	    	
    	OpportunityLineItem opptyLineItem = new OpportunityLineItem();
    	opptyLineItem.OpportunityId = opptyId;
    	opptyLineItem.PricebookEntryId = '01u80000002WyxhAAC';
    	opptyLineItem.Quantity = 1;
    	opptyLineItem.TotalPrice = 150;
    	database.insert(opptyLineItem);
    	return pref;
    }
}