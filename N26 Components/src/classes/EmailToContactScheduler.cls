/*****************************************************************
Name: EmailToContactScheduler
Purpose: Scheduler class to schedule batch class Batch_SendEmailToContact 
*****************************************************************/
global class EmailToContactScheduler implements Schedulable
{
   global void execute(SchedulableContext sc) 
   {  

        try{
            Batch_SendEmailToContact bt = new Batch_SendEmailToContact();
            Database.executeBatch(bt,100);
        }catch(Exception ex){
            system.debug('Exception:::'+ex);
        }    

   }
}