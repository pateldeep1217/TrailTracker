public with sharing class SuperSetController {
     
    static List<String> developerSuperSet = new List<String>();
    static List<String> adminSuperSet = new List<String>();
    static List<String> appBuilderSuperSet = new List<String>();
    static List<String> billingSpecialistSuperSet = new List<String>();
    static List<String> CRMAnalyticsSuperSet = new List<String>();

          // List<Datetime> dateSet = new List<Datetime>();
         static Datetime firstDate;
         static Datetime secondDate;
         static Datetime thirdDate;
  
   
    public static void getSuperSet(){
       
        


        
        Set<SuperSet__c> superSetRecs = new Set<SuperSet__c>();
        Map<Id,List<Resources__c>> userAndResId = new Map<Id,List<Resources__c>>();

 
        List<Resources__c> resourceRecs = [SELECT Id, Name , User__c from Resources__c];

        for(Resources__c resRec: resourceRecs){
            userAndResId.put(resRec.User__c, new List<Resources__c>());
            userAndResId.get(resRec.user__c).add(resRec);
            
        }

        // System.debug(userBadgeMap);


        List<trailheadapp__User_Badge__c> listBadge=[SELECT trailheadapp__User__r.Id,trailheadapp__User__r.Name, trailheadapp__Status__c,trailheadapp__Badge__c,trailheadapp__Badge__r.trailheadapp__Type__c,trailheadapp__Badge__r.Name,trailheadapp__Finished_Date__c
        FROM trailheadapp__User_Badge__c 
        WHERE trailheadapp__Status__c  = 'Completed' AND trailheadapp__Badge__r.trailheadapp__Type__c = 'Superbadge'
        AND trailheadapp__User__r.Id IN: userAndResId.keySet()
        ];

        // System.debug(userBadgeMap);

        // for(trailheadapp__User_Badge__c userBadge: listBadge){
            
        //     userBadgeMap.get(userBadge.trailheadapp__User__r.Id).add(userBadge);
        
        // }

        for(Id userId: userAndResId.keySet()){
                System.debug(userId);

            for(trailheadapp__User_Badge__c badge: listBadge){
                if(userId== badge.trailheadapp__User__r.Id){


                    //System.debug(badge);

                    addingSuperBadgesToList(badge);

                    // if(badge.trailheadapp__Badge__r.Name == 'Apex Specialist'){
                    //     System.debug(badge.trailheadapp__Badge__r.Name);
                        
                    //     developerSuperSet.add(badge.trailheadapp__Badge__r.Name);
                    //     firstDate = badge.trailheadapp__Finished_Date__c;
                    // }else if(badge.trailheadapp__Badge__r.Name == 'Process Automation Specialist'){
                    //     System.debug(badge.trailheadapp__Badge__r.Name);
                        
                    //     developerSuperSet.add(badge.trailheadapp__Badge__r.Name);
                    //     SecondDate = badge.trailheadapp__Finished_Date__c;
                    // }


                    if(developerSuperSet.size() == 2){
                       
                        SuperSet__c supersetRec = new SuperSet__c();
                        supersetRec.Name = 'Developer Super Set';

                        System.debug(userAndResId.get(userId));
                        for(Resources__c resId: userAndResId.get(userId) ){
                            supersetRec.Resource__c = resId.Id;
                        }
                    
                        if(firstDate>secondDate){
                            supersetRec.Finished_Date__c = firstDate;

                        }else{
                            supersetRec.Finished_Date__c = secondDate;
                        }
                            superSetRecs.add(supersetRec);
                                                    
                            developerSuperSet.clear();
                        }

                    }
            }
        }

        for(SuperSet__c superSet: superSetRecs){
            System.debug(superSet);
        }    
    }  

    public static void addingSuperBadgesToList(trailheadapp__User_Badge__c badge){
        switch on badge.trailheadapp__Badge__r.Name
            {
                when 'Business Administration Specialist', 'Lightning Experience Reports & Dashboards Specialist'
                {
                    adminSuperSet.add(badge.trailheadapp__Badge__r.Name);
                }
                        
                when 'Security Specialist'
                    {
                        adminsuperset.add(badge.trailheadapp__Badge__r.Name);
                        appBuilderSuperSet.add(badge.trailheadapp__Badge__r.Name);
                    }
                        
                    when 'App Customization Specialist'
                    {
                        appBuilderSuperSet.add(badge.trailheadapp__Badge__r.Name);
                    }
                        
                    when 'Process Automation Specialist'
                    {
                        appBuilderSuperSet.add(badge.trailheadapp__Badge__r.Name);
                        developersuperset.add(badge.trailheadapp__Badge__r.Name);
                    }
                        
                    when 'Billing Specialist', 'Advanced Billing Specialist'
                    {
                        billingSpecialistSuperSet.add(badge.trailheadapp__Badge__r.Name);
                    }
                        
                    when 'Apex Specialist'
                    {
                        developersuperset.add(badge.trailheadapp__Badge__r.Name);
                    }
                        
                    when 'CRM Analytics Data Preparation Specialist', 'CRM Analytics and Einstein Discovery Insights Specialist'
                        {
                             CRMAnalyticsSuperSet.add(badge.trailheadapp__Badge__r.Name);
                        }
                    }
       
    }   
       
}

   
        // for(Id userId: userBadgeMap.keySet()){
  

        //     System.debug(developerSuperSet);
        // }




        // for(Id userId: userIds){
        //     System.debug(userId);
           

        //     for(trailheadapp__User_Badge__c badge: listBadge){
                
        //          if(badge.trailheadapp__User__r.Id == userId){
                    
               
        //             if(badge.trailheadapp__Badge__r.Name == 'Apex Specialist'){
                       
        //                 developerSuperSet.add(badge.trailheadapp__Badge__r.Name);
        //                  firstDate = badge.trailheadapp__Finished_Date__c;
        //             }else if(badge.trailheadapp__Badge__r.Name == 'Process Automation Specialist'){
                       
        //                 developerSuperSet.add(badge.trailheadapp__Badge__r.Name);
        //                 SecondDate = badge.trailheadapp__Finished_Date__c;

        //             }


        //             if(badge.trailheadapp__Badge__r.Name == 'Billing Specialist'){
                       
        //                 billingSpecialistSuperSet.add(badge.trailheadapp__Badge__r.Name) ;
        //                 firstDate = badge.trailheadapp__Finished_Date__c;
        //             }else if(badge.trailheadapp__Badge__r.Name == 'Advanced Billing Specialist'){
                       
        //                 billingSpecialistSuperSet.add(badge.trailheadapp__Badge__r.Name);
        //                 SecondDate = badge.trailheadapp__Finished_Date__c;

        //             }

                   

        //             if(developerSuperSet.size() == 2){
        //                 system.debug(developerSuperSet);
                    
        //                     SuperSet__c supersetRec = new SuperSet__c();
        //                     supersetRec.Name = 'Developer Super Set';
        //                     supersetRec.Resource__c = userId;
        //                     if(firstDate>secondDate){
        //                         supersetRec.Finished_Date__c = firstDate;

        //                     }else{
                               
        //                        supersetRec.Finished_Date__c = secondDate;
        //                     }

        //                     superSetRecs.add(supersetRec);
                                                
        //                 developerSuperSet.clear();
        //             }

        //             if(billingSpecialistSuperSet.size() == 2){
        //                 system.debug(billingSpecialistSuperSet);
                       
        //                     SuperSet__c supersetRec = new SuperSet__c();
        //                     supersetRec.Name = 'Billing Super Set';
        //                     supersetRec.Resource__c = userId;
        //                     if(firstDate>secondDate){
        //                         supersetRec.Finished_Date__c = firstDate;

        //                     }else{
                               
        //                        supersetRec.Finished_Date__c = secondDate;
        //                     }

        //                     superSetRecs.add(supersetRec);
                    
                        

        //                 billingSpecialistSuperSet.clear();
                       
        //             }



        //         }
        //     }
        // }



     
        
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

                   
        
    


