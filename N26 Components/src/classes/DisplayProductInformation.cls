/*****************************************************************
Name: DisplayProductInformation
Purpose: To get the Product and Home Country of the related Contact on Case and display the related Product Information.

*****************************************************************/

public class DisplayProductInformation{

    @AuraEnabled
    public static List<Product_Information__c> getContactProductInfo(String caseId){
        //List to store the Product Information of the related Contact
        List<Product_Information__c> productInfoList = new List<Product_Information__c>();
        //Query to get the ContactId of the Case
        List<Case> caseList = [SELECT Id,ContactId FROM Case WHERE Id = :caseId];
        
        if(caseList[0].ContactId != null){
            //Query to get the Product and Home Country of the related Contact on Case
            List<Contact> conRec = [SELECT Id,Product__c,Home_Country__c FROM Contact WHERE Id = :caseList[0].ContactId];
            
            if(!conRec.isEmpty()){
                //Query to get all the Product Information related to the Product and Home Country combinaiton
                productInfoList = [SELECT Product_Attribute__c,Product__c,Product__r.Name,Home_Country__c,Cost__c
                                   FROM Product_Information__c WHERE Product__c = :conRec[0].Product__c AND Home_Country__c = :conRec[0].Home_Country__c];
                                                                
            }
        }
        
        return productInfoList;
        
    } 
}