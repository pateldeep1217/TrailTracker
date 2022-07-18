public with sharing class UserBadgesController 
{   
    @AuraEnabled (Cacheable = true)
    public static List<AggregateResult> getUserBadgeCount()
    {
        return [SELECT trailheadapp__User__r.Id, count(trailheadapp__Badge__c) Badges, trailheadapp__Status__c 
                FROM trailheadapp__User_Badge__c 
                WHERE trailheadapp__Status__c  = 'Completed' 
                GROUP BY trailheadapp__User__r.Id, trailheadapp__Status__c];
    }

    @AuraEnabled (Cacheable = true)
    public static List<AggregateResult> getUserBadgeInProgress()
    {
        return [SELECT trailheadapp__User__r.Id, count(trailheadapp__Badge__c) Badges, trailheadapp__Status__c 
                FROM trailheadapp__User_Badge__c 
                WHERE trailheadapp__Status__c  = 'In-Progress' 
                GROUP BY trailheadapp__User__r.Id, trailheadapp__Status__c];
    }

    @AuraEnabled (Cacheable = true)
    public static List<trailheadapp__User_Badge__c> getUserBadgeInfo(String userId, String buttonCategory)
    {
        System.debug(userId);
        System.debug(buttonCategory);
        
        if(buttonCategory.length() >0)
        {
            return [SELECT trailheadapp__User__r.Id, trailheadapp__Badge_Icon__c, trailheadapp__Status__c,trailheadapp__Badge__c,
                    trailheadapp__Badge__r.Name,trailheadapp__Finished_Date__c ,trailheadapp__Badge__r.trailheadapp__Type__c,
                    trailheadapp__URL__c, trailheadapp__Badge__r.trailheadapp__Icon__c 
                    FROM trailheadapp__User_Badge__c 
                    WHERE trailheadapp__Status__c  = 'Completed' 
                    AND trailheadapp__User__r.Id =: userId 
                    AND trailheadapp__Badge__r.trailheadapp__Type__c =: buttonCategory 
                    ORDER BY trailheadapp__Badge__r.Name ASC];
        }
        
        else 
        {
            return [SELECT trailheadapp__User__r.Id, trailheadapp__Badge_Icon__c, trailheadapp__Status__c,trailheadapp__Badge__c,
                    trailheadapp__Badge__r.trailheadapp__Type__c,trailheadapp__Badge__r.Name,trailheadapp__Finished_Date__c,
                    trailheadapp__URL__c,trailheadapp__Badge__r.trailheadapp__Icon__c 
                    FROM trailheadapp__User_Badge__c 
                    WHERE trailheadapp__Status__c  = 'Completed' 
                    AND trailheadapp__User__r.Id =: userId 
                    ORDER BY trailheadapp__Badge__r.Name ASC];
        }
    }
}