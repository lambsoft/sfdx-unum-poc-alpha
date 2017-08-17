/**
*
*@ Author     : Aruna Rapolu
*@ Created    : 6/9/2014
*
*Class will display customer and prospect account opportunities on CustomerAndProspectOpportunities vf pages
*
* Log #1 - 11/18/2014 - Nate Wallace - Removed reference to Opportunity.Sub_Type__c field.
* Log #2 - 10/12/2016 - Karthik Polasi - After checking the VF page, removed unwanted fields in the query that are not being used on this page.
* Log #3 - 10/18/2016 - Karthik Polasi - Removed Quote references as a part of Opp/Quote project and added the new field Quote Stage Being date
**/

public  class CustomerAndProspectAcctOpptCnt{

    public CustomerAndProspectAcctOpptCnt(ApexPages.StandardController controller) {

    }
    public CustomerAndProspectAcctOpptCnt() {

    }

   /**
   *
   *@Author : Auna Rapolu
   *@created : 6/9/2014
   *Method will get account id from the vf page url
   *
   **/ 
   public string accountId{
       get{
           return accountId= Apexpages.currentPage().getParameters().get('accId');
       }set;
   }
   /**
   *
   *@Author : Auna Rapolu
   *@created : 6/9/2014
   *Method is used on vf page to display account name
   *
   **/ 
   public string accountName{
       get{
           Account accObj=[select id,Name from Account where Id=:accountId];
          return  accountName=accObj.Name;
       }set;
   } 
   /**
   *
   *@Author : Auna Rapolu
   *@created : 6/9/2014
   *Method  get all the opportunities and quotes of realted to account 
   *
   **/ 
   public list<Opportunity> oppList{
      
        get{
            return oppList=[select id,Name
                                     ,PRIM_FIELD_OFC_NM__c
                                     ,PRIM_SALE_REP_ID__r.Name
                                     ,PRIM_SALE_REP_ID__c
                                     ,Broker__c
                                     ,Broker__r.Name
                                     ,Type
                                     ,StageName 
                                     ,QUOTE_STAGE_BEGIN_DT__c
                                     ,CloseDate
                                     
                                 from Opportunity
                                       
                                       where AccountId=:accountId ORDER BY CloseDate DESC];
        
        }set;
   }
   
}