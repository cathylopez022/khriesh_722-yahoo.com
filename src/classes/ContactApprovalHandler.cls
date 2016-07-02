public without sharing class ContactApprovalHandler 
{
      private static final String strMessage = 'Comments field is required';
      public static void processContactApprovals(List<Contact> contacts)
      {
            Set<Id> setContactIds = new Set<Id>();
            Map<Id, String> mapContactIdCommentValidationResult = new Map<Id, String>();
            List<ProcessInstance> processes = new List<ProcessInstance>();
            for(Contact contact:contacts)
            {
                  setContactIds.add(contact.Id); 
            }   
            if(setContactIds.size()>0)
            {         
                  processes = [select TargetObjectId, 
                                      (select IsPending, StepStatus, Comments, IsDeleted from StepsAndWorkitems
                                      order by SystemModstamp desc), 
                                      (select Id, Comments, ProcessInstanceId, StepStatus from Steps 
                                      where StepStatus = 'Approved' or StepStatus = 'Rejected'
                                      order by SystemModstamp desc limit 1),
                                      (select Id, ProcessInstanceId, OriginalActorId, ActorId, IsDeleted, CreatedDate, 
                                      CreatedById, SystemModstamp from Workitems
                                      order by SystemModstamp desc)
                                from ProcessInstance 
                                where TargetObjectId in :setContactIds
                                and Status != 'Pending'];
                  Map<Id, ProcessInstanceWorkItem> mapWorkItems = new Map<Id,ProcessInstanceWorkItem>();  
                  Map<Id, ProcessInstanceStep> mapSteps = new Map<Id,ProcessInstanceStep>();            
                  for(ProcessInstance processInstance:processes)
                  {  
                        if(processInstance.Workitems != null && processInstance.Workitems.size()>0)
                        {
                              for(ProcessInstanceWorkItem workItem:processInstance.Workitems)
                              {
                                    mapWorkItems.put(workItem.ProcessInstanceId, workItem);
                              }
                        }
                        if(processInstance.Steps != null && processInstance.Steps.size()>0)
                        {
                              for(ProcessInstanceStep step:processInstance.Steps)
                              {
                                    mapSteps.put(step.ProcessInstanceId, step);
                              }
                        }                                               
                  }     
                  for(ProcessInstance processInstance:processes)
                  {  
                        if(mapWorkItems.size()> 0 && mapSteps.size()>0
                        && mapWorkItems.containsKey(processInstance.Id)
                        && mapSteps.containsKey(processInstance.Id))
                        {
                              if(mapWorkItems.get(processInstance.Id).ProcessInstanceId == mapSteps.get(processInstance.Id).ProcessInstanceId 
                                    && mapSteps.get(processInstance.Id).Comments == null)
                              {
                                    mapContactIdCommentValidationResult.put(processInstance.targetObjectId, strMessage);
                              }
                        }
                  }                                             
              if(mapContactIdCommentValidationResult.size()>0)
              {
                  for(Contact contact:contacts)
                  {
                        if(mapContactIdCommentValidationResult.containsKey(contact.Id))
                        {
                              contact.addError(mapContactIdCommentValidationResult.get(contact.Id));
                        }
                  }
              }
            }
      }
}