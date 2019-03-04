UseCase 1:
Pre Deployment Steps:
1. Enable Translation workbench in your org.
2. Add German as the Supported Languages.

Components to be deployed:-
1. Visualforce Email Template -  
   . Survey_Email
2. Custom Fields -
   . Contact.Language__c
   . Contact.Survey_Date__c 
3. Custom Label -
   .Message1
   .Email_BodyMessage1
4. Translations
5. Apex Class - 
   . Batch_SendEmailToContact 
   . EmailToContactScheduler
   
UseCase 2:   

Components to be deployed:-
 
 1. Custom Object-
    . Product_Information__c
 2. Layout -
    . Product Information Layout
 3. Tab -
    . Product Information	 
 4. Custom Fields -
    . Contact.Home_Country__c
    . Contact.Product__c
  5. Flexi Page - 
     . Case.Case_Record_Page1
  6. Apex Class - 
     . DisplayProductInformation
  7. Lightning Component -
     . DisplayContactProductInformation
     
  Post Deployment Steps -
  1. Load Data in Product2 object (Product.csv).
  2. Open Product Information.csv,Map Product Id from above. Load data in Product Information object.
  
   
   
