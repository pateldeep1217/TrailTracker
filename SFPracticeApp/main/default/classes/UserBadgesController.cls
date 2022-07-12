public with sharing class UserBadgesController 
{
    // @AuraEnabled (Cacheable = true)
    // public static Map<String, Integer> getUserBadge(){        

    //     Map<String, Integer> UserBadgeMap = new Map<String, Integer>();

    //     for(AggregateResult ar: [SELECT trailheadapp__User__r.name, count(trailheadapp__Badge__c), trailheadapp__Status__c FROM trailheadapp__User_Badge__c WHERE trailheadapp__Status__c  = 'Completed' GROUP BY trailheadapp__User__r.name, trailheadapp__Status__c]){
        
    //         String name = String.valueOf(ar.get('Name'));
    //         Integer count = Integer.valueOf(ar.get('expr0'));
    //         UserBadgeMap.put(name, count);
    //     }

    //    return UserBadgeMap;
    // }



    /*
    @AuraEnabled (Cacheable = true)
    public static Map<String, Integer> getUserBadge(){        

        Map<String, Integer> UserBadgeMap = new Map<String, Integer>();

        for(AggregateResult ar: [SELECT trailheadapp__User__r.Id, count(trailheadapp__Badge__c), trailheadapp__Status__c FROM trailheadapp__User_Badge__c WHERE trailheadapp__Status__c  = 'Completed' GROUP BY trailheadapp__User__r.Id, trailheadapp__Status__c]){
        
            String name = String.valueOf(ar.get('Id'));
            Integer count = Integer.valueOf(ar.get('expr0'));
            UserBadgeMap.put(name, count);
        }

        return UserBadgeMap;
    }

    @AuraEnabled(Cacheable = true)
    public static List<Resources__c> getUserIdFromResource(){
        return [SELECT User__r.Id FROM Resources__c];
    }

    */

    @AuraEnabled (Cacheable = true)
    public static List<AggregateResult> getUserBadge()
    {
        return [SELECT trailheadapp__User__r.Id, count(trailheadapp__Badge__c) Badges, trailheadapp__Status__c 
                FROM trailheadapp__User_Badge__c 
                WHERE trailheadapp__Status__c  = 'Completed' 
                GROUP BY trailheadapp__User__r.Id, trailheadapp__Status__c];
    }
}
