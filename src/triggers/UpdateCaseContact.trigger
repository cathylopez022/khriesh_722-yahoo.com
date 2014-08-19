trigger UpdateCaseContact on Case (before insert, before update) {
	Set<Id> idCaseContacts = new Set<Id>();
	List<Case> cases = new List<Case>();
	List<String> lstEmail = new List<String>();
	//List<Contact> lstphone = new List<Contact>();
	
	for(Case cse:trigger.new)
	{
		idCaseContacts.add(cse.Contact_Person__c);
	}
	
	Map<Id,Contact> contacts= new Map<Id,Contact>([Select Email, Phone from Contact where Id in : idCaseContacts]);
	//List <Contact> lstContact = [select Id, email, phone  from Contact where Id in :idCaseContact];
	
	
	for (Case cs: trigger.new)
	{
		cs.Contact_Email__c = contacts.get(cs.Contact_Person__c).Email;
		cs.Contact_Phone__c = contacts.get(cs.Contact_Person__c).phone;
	}
	
	/*for (Case cs: trigger.new)
	{
		for(integer i=0; i < lstEmail.size(); i++)
		{ 
			if (cs.Contact_Person__c !=null)
			{
				cs.Contact_Email__c = lstEmail[i];	
			}
		}
	}
	*/
	//database.update(cases);
	system.debug('-------------------------------------------');
	system.debug(idCaseContacts);

	system.debug('-------------------------------------------');
	system.debug(contacts);
	
	
	
}