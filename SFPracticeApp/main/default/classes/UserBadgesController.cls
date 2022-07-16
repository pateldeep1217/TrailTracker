public with sharing class UserBadgesController 
{   
    @AuraEnabled (Cacheable = true)
    public static List<AggregateResult> getUserBadge()
    {
        return [SELECT trailheadapp__User__r.Id, count(trailheadapp__Badge__c) Badges, trailheadapp__Status__c 
                FROM trailheadapp__User_Badge__c 
                WHERE trailheadapp__Status__c  = 'Completed' 
                GROUP BY trailheadapp__User__r.Id, trailheadapp__Status__c];
    }


    @AuraEnabled (Cacheable = true)
    public static List<trailheadapp__User_Badge__c> getUserBadgesInfo(String userId)
    {

        String key = '%' + userId + '%';
        return [SELECT trailheadapp__User__r.Id, trailheadapp__Badge_Icon__c, trailheadapp__Status__c,trailheadapp__Badge__c,
                trailheadapp__Badge__r.Name,trailheadapp__Finished_Date__c  
                FROM trailheadapp__User_Badge__c 
                WHERE trailheadapp__Status__c  = 'Completed' 
                AND trailheadapp__User__r.Id =: userId ORDER BY trailheadapp__Badge__r.Name ASC];
    }
}
