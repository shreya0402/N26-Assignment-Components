/*****************************************************************
Name: Batch_SendEmailToContact 
Purpose: Daily Batch to send surveys to Contact that has survey date before now

*****************************************************************/
global class Batch_SendEmailToContact implements Database.Batchable<sObject>,Database.Stateful
{
   //List to store the contacts to whom mail has already been sent and survey date will be set to null
   global List<Contact> contactList;
   
   global Batch_SendEmailToContact(){
       contactList = new List<Contact>();
   }
   global Database.QueryLocator start(Database.BatchableContext BC)
   {
      DateTime nowDt = System.Now();
      
      //Record_Limit custom Label is uesed to set query limit so that daily single email limit is not exceeded
      //Currently Record_Limit is set to 15 as in developer edition,single email limit is 15. For Unlimited Edition,it is 5000.Set the Custom Label value accordingly
      String query = 'SELECT Id,Name,Email,Language__c,Survey_Date__c FROM Contact WHERE Survey_Date__c < :nowDt LIMIT '+ System.Label.Record_Limit ;
      system.debug(query);
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<Contact> scope)
   {
      system.debug(scope);
      //List to store array of single email messages
      Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage>();
      
      //Querying visualforce email template 
      Id emailTemplateId = [SELECT Id FROM EmailTemplate WHERE Name = 'Survey Email'].Id;
      
      if(!scope.isEmpty()){ 
          for(Contact con : scope){
              
              
              Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
              message.setTargetObjectId(con.Id);
              message.setTemplateId(emailTemplateId);
              
              messages.add(message);
          }
           
           try{
               Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
               
               system.debug(results);
               
               if (results[0].success) {
                  contactList.addAll(scope); 
               }else{
                   system.debug('Error::'+results[0].getErrors()); 
               }
           }catch(exception ex){
               system.debug('Exception:::'+ex.getMessage());
           }    
           
           
      }    

   }
   
   global void finish(Database.BatchableContext BC)
   {
       if(!contactList.isEmpty()){
           for(Contact con : contactList){
               //once the email is sent to the contact,survey date is set to null
               con.Survey_Date__c = null;
           }
           try{
               Database.Update(contactList,false);
           }catch(Exception ex){
               system.debug('Exception:::'+ex.getMessage());
           }    
       }
   }

}