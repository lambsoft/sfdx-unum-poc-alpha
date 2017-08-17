/**
*
*@Author : Aruna Rapolu
*@Created :6/10/2014
@log #1 Suresh Raghuram Change the Stage name and commented the old one
*Log #2 - 11/18/2014 - Nate Wallace - Removed reference to Opportunity.Sub_Type__c field.
*Log #3 - 12/05/2014 - Suresh Raghuram added Broker field to the Quote Object 
*Log #4 - 10/18/2016 - Karthik Polasi removed references to Custom Quote object
*
*
**/


@isTest
private class CustomerAndProspectAcctOpptCntTest{
    
    private static testMethod void CustomerAndProspectAcctOpptTest(){
    
        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User usr = new User(Alias = 'sft', Email = 'standarduser@testuser.com', EmailEncodingKey = 'UTF-8', LastName = 
                            'testPrimarySalesOffcie', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US', ProfileId = p.Id, TimeZoneSidKey =
                            'America/Los_Angeles', UserName = 'primarysales@test.com');
        insert usr;
        
        final string BrokerRecType='Broker';
        schema.describesobjectresult r=account.sobjecttype.getdescribe();
        map<string,schema.recordtypeinfo> m=r.getrecordtypeinfosbyname();
        id brkerRecType= m.get(BrokerRecType).getrecordtypeid();  
            
        Account customerAcct=new Account(Name='testAcctName');
        insert customerAcct;
        
        Account brokerAccount=new Account(Name='brokerAccountName',RecordTypeId=brkerRecType);
        insert brokerAccount;
        
        
        
        list<Opportunity> oppList=new list<Opportunity>();
        
        for(Integer i=0;i<=3;i++){
            Opportunity oppt=new Opportunity(Name='testOpt'
                                             ,AccountId=customerAcct.id
                                             ,PRIM_SALE_REP_ID__c=usr.id
                                             ,Broker__c=brokerAccount.id
                                             ,Type='New'
                                             ,/*StageName ='Sold'*/ StageName ='Sold/Impl/Enroll'
                                             ,CloseDate=date.today());
            oppList.add(oppt);
        }
        insert oppList;
        
     
        test.startTest();
        
            ApexPages.StandardController stdController=new ApexPages.StandardController(customerAcct);
            CustomerAndProspectAcctOpptCnt stdCnt=new CustomerAndProspectAcctOpptCnt(stdController);
            CustomerAndProspectAcctOpptCnt controller=new CustomerAndProspectAcctOpptCnt();
        
            controller.accountId=(string.valueOf(customerAcct.id));
            Apexpages.currentPage().getParameters().put('accId',controller.accountId);
            
            controller.accountName=customerAcct.Name;
            controller.accountName='testAccountName';
            
            controller.oppList=oppList;
            controller.oppList=controller.oppList;
            
            
            
        test.stopTest();
       
        
    }
}