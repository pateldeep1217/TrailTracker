public with sharing class SuperSetController {
   
    public static void getSuperSet()
    {
       
        
        
        List<String> developerSuperSet = new List<String>();
        List<String> adminSuperSet = new List<String>();
        List<String> appBuilderSuperSet = new List<String>();
        List<String> billingSpecialistSuperSet = new List<String>();
        List<String> CRMAnalyticsSuperSet = new List<String>();

       // List<Datetime> dateSet = new List<Datetime>();
        Datetime firstDate;
        Datetime secondDate;
        Datetime thirdDate;


        List<Resources__c> resourceRecs = [SELECT Id, User__c, User__r.name from Resources__c];



      

        Set<Id> userIds = new Set<Id>();


        for(Resources__c resRec: resourceRecs){
            userIds.add(resRec.User__c);
          
        }

        List<trailheadapp__User_Badge__c> listBadge=[SELECT trailheadapp__User__r.Id, trailheadapp__Status__c,trailheadapp__Badge__c,trailheadapp__Badge__r.trailheadapp__Type__c,trailheadapp__Badge__r.Name,trailheadapp__Finished_Date__c
        FROM trailheadapp__User_Badge__c 
        WHERE trailheadapp__Status__c  = 'Completed' AND trailheadapp__Badge__r.trailheadapp__Type__c = 'Superbadge'
        AND trailheadapp__User__r.Id IN:userIds
        ];


        for(Id userId: userIds){
            System.debug(userId);
            for(trailheadapp__User_Badge__c badge: listBadge){
                 if(badge.trailheadapp__User__r.Id == userId){
                    
                    System.debug(badge);
                    if(badge.trailheadapp__Badge__r.Name == 'Apex Specialist'){
                       
                        developerSuperSet.add(badge.trailheadapp__Badge__r.Name);
                        // firstDate = badge.trailheadapp__Finished_Date__c;
                    }else if(badge.trailheadapp__Badge__r.Name == 'Process Automation Specialist'){
                       
                        developerSuperSet.add(badge.trailheadapp__Badge__r.Name);
                        // SecondDate = badge.trailheadapp__Finished_Date__c;

                    }

                    if(developerSuperSet.size() == 2){
                        system.debug(developerSuperSet);
                    }
                }
           
    
               
                
               
    
            }
           
        }
     
        
        
        // System.debug(listBadge);
        

                    // for(trailheadapp__User_Badge__c badge: listBadge){
                    //     for(Resources__c res: resourceRecs){
                            
                    //         if(badge.trailheadapp__User__r.Id == res.user__c ){

                                  
                                // if(badge.trailheadapp__Badge__r.Name == 'Apex Specialist'){
                                //     System.debug(badge.trailheadapp__Badge__r.Name);
                                //     developerSuperSet.add(badge.trailheadapp__Badge__r.Name);
                                //     firstDate = badge.trailheadapp__Finished_Date__c;
                                // }else if(badge.trailheadapp__Badge__r.Name == 'Process Automation Specialist'){
                                //     System.debug(badge.trailheadapp__Badge__r.Name);
                                //     developerSuperSet.add(badge.trailheadapp__Badge__r.Name);
                                    
                                //     SecondDate = badge.trailheadapp__Finished_Date__c;

                                // }

                    //             if(developerSuperSet.size() == 2){

                    //                 System.debug('Developer Super Set = Compeleted');
                    //                 Super_Set__c recs = new Super_Set__c();
                    //                 recs.Name = 'Developer Super Set';
                    //                 recs.Resource__c = res.Id;
                    //                 recs.Status__c = 'Compeleted';
                    //                 if(firstDate>secondDate){
                    //                     recs.Finished_Date__c = firstDate;
                    //                 }else{
                    //                     recs.Finished_Date__c = secondDate;
                    //                 }
                                    
                    //                 newSupersetRecs.add(recs);
                    //             }else {
                    //                 System.debug('Devloper Super Set = Not Completed');
                    //             }
                    //             developerSuperSet.clear();

                    //         }
                    //         }
                    //     }
    
                    //     System.debug(developerSuperSet);
                            
                        
                        
                    
                    //     system.debug(newSupersetRecs);

    

                    //     if(badge.trailheadapp__Badge__r.Name == 'Business Administration Specialist'){
                    //         adminSuperSet.add(badge.trailheadapp__Badge__r.Name);
                    //      }else if(badge.trailheadapp__Badge__r.Name == 'Lightning Experience Reports & Dashboards Specialist'){
                    //          adminSuperSet.add(badge.trailheadapp__Badge__r.Name);
                    //      }else if(badge.trailheadapp__Badge__r.Name == 'Security Specialist'){
                    //         adminSuperSet.add(badge.trailheadapp__Badge__r.Name);
                    //      }



                    //      if(badge.trailheadapp__Badge__r.Name == 'App Customization Specialist'){
                    //         appBuilderSuperSet.add(badge.trailheadapp__Badge__r.Name);
                    //      }else if(badge.trailheadapp__Badge__r.Name == 'Process Automation Specialist'){
                    //         appBuilderSuperSet.add(badge.trailheadapp__Badge__r.Name);
                    //      }else if(badge.trailheadapp__Badge__r.Name == 'Security Specialist'){
                    //         appBuilderSuperSet.add(badge.trailheadapp__Badge__r.Name);
                    //      }


                    //      if(badge.trailheadapp__Badge__r.Name == 'Billing Specialist'){
                    //         billingSpecialistSuperSet.add(badge.trailheadapp__Badge__r.Name);
                    //      }else if(badge.trailheadapp__Badge__r.Name == 'Advanced Billing Specialist'){
                    //         billingSpecialistSuperSet.add(badge.trailheadapp__Badge__r.Name);
                    //      }


                    //      if(badge.trailheadapp__Badge__r.Name == 'CRM Analytics Data Preparation Specialist'){
                    //         billingSpecialistSuperSet.add(badge.trailheadapp__Badge__r.Name);
                    //      }else if(badge.trailheadapp__Badge__r.Name == 'CRM Analytics and Einstein Discovery Insights Specialist'){
                    //         billingSpecialistSuperSet.add(badge.trailheadapp__Badge__r.Name);
                    //      }
                    // }


                    // if(superSetValue =='Developer Super Set' && developerSuperSet.size() == 2){
                    //     System.debug('Developer Super Set = Compeleted');
                    //     for(String superBage: developerSuperSet){
                    //         System.debug(superBage);
                    //     }
                    //     if(firstDate>secondDate){
                    //         System.debug('Obtain Date = ' + firstDate);
                    //     }else{
                    //         System.debug('Obtain Date = '+ secondDate);
                    //     }
                        
                    // }else {
                    //     System.debug('Devloper Super Set = Not Completed');
                    // }
                  

                  
                    // System.debug(developerSuperSet.size());
                    // System.debug(adminSuperSet.size());
                    // System.debug(appBuilderSuperSet.size());
                    // System.debug(billingSpecialistSuperSet.size());
                    // System.debug(CRMAnalyticsSuperSet.size());

                   
        
    
}
}