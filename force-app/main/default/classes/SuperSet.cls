public with sharing class SuperSet implements Schedulable {

    // Sets for each of the superset. 
    static Set<trailheadapp__User_Badge__c> developerSuperSet = new Set<trailheadapp__User_Badge__c>();
    static Set<trailheadapp__User_Badge__c> adminSuperSet = new Set<trailheadapp__User_Badge__c>();
    static Set<trailheadapp__User_Badge__c> appBuilderSuperSet = new Set<trailheadapp__User_Badge__c>();
    static Set<trailheadapp__User_Badge__c> billingSpecialistSuperSet = new Set<trailheadapp__User_Badge__c>();
    static Set<trailheadapp__User_Badge__c> CRMAnalyticsSuperSet = new Set<trailheadapp__User_Badge__c>();

    //set for creating superset records
    static List<SuperSet__c> supersetrecords = new List<SuperSet__c>();

   public void execute(SchedulableContext sc){

   DELETE [SELECT Id FROM SuperSet__c];

    List<Resources__c> resourceRecs = [SELECT Id, User__c from Resources__c];

    List<trailheadapp__User_Badge__c> userBadgeList=[SELECT trailheadapp__User__c,trailheadapp__Badge__r.Name,trailheadapp__Finished_Date__c
    FROM trailheadapp__User_Badge__c 
    WHERE trailheadapp__Status__c  = 'Completed' AND trailheadapp__Badge__r.trailheadapp__Type__c = 'Superbadge'
    ];

    for(Resources__c resourceRec: resourceRecs){

        adminsuperset.clear();
        appbuildersuperset.clear();
        billingspecialistsuperset.clear();
        developersuperset.clear();
        crmanalyticssuperset.clear();
        for(trailheadapp__User_Badge__c badge: userBadgeList){
            if(resourceRec.User__c == badge.trailheadapp__User__c){
                addingSuperBadgesToList(badge);
                

                if(adminSuperSet.size() == 3)
                {   
                 
                    supersetrecords.add(createSuperSetRecord('Admin Super Set', resourceRec.Id, adminSuperSet));
                }
                
                else if(appBuilderSuperSet.size() == 3)
                {
                   


                    supersetrecords.add(createSuperSetRecord('App Builder Super Set', resourceRec.Id, appBuilderSuperSet));
                }
                
                else if(billingSpecialistSuperSet.size() == 2)
                {
                  

                    supersetrecords.add(createSuperSetRecord('Billing Specialist Super Set', resourceRec.Id, billingSpecialistSuperSet));
                }
                
                else if(developerSuperSet.size() == 2)
                {
                   

                    supersetrecords.add(createSuperSetRecord('Developer Super Set', resourceRec.Id, developerSuperSet));
                }
                
                else if(CRMAnalyticsSuperSet.size() == 2)
                {
                  
                    supersetrecords.add(createSuperSetRecord('CRM Analytics Super Set', resourceRec.Id, CRMAnalyticsSuperSet));
                }

            }
        }
    }   
    
  

    // for(SuperSet__c superrec: supersetrecords){
    //     System.debug(superrec);
    // }


    
    insert supersetrecords;
    
    
   }



   private static SuperSet__c createSuperSetRecord(String supersetname, Id resourceid, Set<trailheadapp__User_Badge__c> usersupersets)
   {
       SuperSet__c supersetrecord = new SuperSet__c();
       supersetrecord.Name = supersetname;
       supersetrecord.Resource__c = resourceid;
       
       Datetime soonestdate;
       
       for(trailheadapp__User_Badge__c superbadge : usersupersets)
       {
           if (soonestdate == null)
           {
               soonestdate = superbadge.trailheadapp__Finished_Date__c;
           }
           
           else if(soonestdate < superbadge.trailheadapp__Finished_Date__c)
           {
               soonestdate = superbadge.trailheadapp__Finished_Date__c;
           }
           
           supersetrecord.Finished_Date__c = soonestdate;
       }
       
       usersupersets.clear();
       
       return supersetrecord;
   }


   public static void addingSuperBadgesToList(trailheadapp__User_Badge__c badge){
       
       switch on badge.trailheadapp__Badge__r.Name{
               when 'Business Administration Specialist' , 'Lightning Experience Reports & Dashboards Specialist'
               {
                   adminSuperSet.add(badge);
               }
                       
               when 'Security Specialist'
               {
                   adminsuperset.add(badge);
                   appBuilderSuperSet.add(badge);
               }
                       
               when 'App Customization Specialist'
               {
               appBuilderSuperSet.add(badge);
               }
                       
               when 'Process Automation Specialist'
               {
               appBuilderSuperSet.add(badge);
               developersuperset.add(badge);
               }
                       
               when 'Billing Specialist', 'Advanced Billing Specialist'
               {
               billingSpecialistSuperSet.add(badge);
               }
                       
               when 'Apex Specialist'
               {
               developersuperset.add(badge);
               }
                       
               when 'CRM Analytics Data Preparation Specialist', 'CRM Analytics and Einstein Discovery Insights Specialist'
               {
               CRMAnalyticsSuperSet.add(badge);
               }
       }
   }

    
}