/*
  Force.com Cookbook Sample Code
  Chapter 6: Improving Data Quality
  "Preventing Duplicate Records from Saving"

  This Apex trigger prevents leads from being saved if they have a 
  matching Email field.

  Sample code provided by salesforce.com. All rights reserved.
 */
trigger leadDuplicatePreventer on Lead (before insert, before update) {

    Map<String, Lead> leadMap = new Map<String, Lead>();

    for (Lead lead : System.Trigger.new) {
    
        /* Make sure we don't treat an email address that
           isn't changing during an update as a duplicate. */
        if ((lead.Mobile__c != null) && (System.Trigger.isInsert || (lead.Mobile__c != System.Trigger.oldMap.get(lead.Id).Mobile__c))) {
    
            // Make sure another new lead isn't also a duplicate
            if (leadMap.containsKey(lead.Mobile__c)) {
                lead.Mobile__c.addError('Another new lead has the same Mobile__c.');
            } else {
                leadMap.put(lead.Mobile__c, lead);
            }
        }
    }
    
    /* Using a single database query, find all the leads in
       the database that have the same email address as any
       of the leads being inserted or updated. */
    for (Lead lead : [SELECT Mobile__c FROM Lead WHERE Mobile__c IN :leadMap.KeySet()]) {
        Lead newLead = leadMap.get(lead.Mobile__c);
        newLead.Mobile__c.addError('A lead with this Mobile__c already exists.');
    } 
}