public with sharing class SuperSetTest {
    @testSetup
    static void setupData()
    {
        List<trailheadapp__Badge__c> badges = new List<trailheadapp__Badge__c>();
        
        badges.add(createBadgeRecord('Business Administration Specialist'));
        badges.add(createBadgeRecord('Security Specialist'));
        badges.add(createBadgeRecord('Lightning Experience Reports & Dashboards Specialist'));
        badges.add(createBadgeRecord('App Customization Specialist'));
        badges.add(createBadgeRecord('Process Automation Specialist'));
        badges.add(createBadgeRecord('Billing Specialist'));
        badges.add(createBadgeRecord('Advanced Billing Specialist'));
        badges.add(createBadgeRecord('Apex Specialist'));
        badges.add(createBadgeRecord('CRM Analytics Data Preparation Specialist'));
        badges.add(createBadgeRecord('CRM Analytics and Einstein Discovery Insights Specialist'));
        insert badges;
        
        User newuser = new User();
        newuser.FirstName = 'Test';
        newuser.LastName = 'User';
        newuser.Email = 'newuser@gmail.com';
        newuser.Username = 'Test.User4tt@gmail.com';
        newuser.Alias = 'TestUser';
        newuser.TimeZoneSidKey = 'America/Los_Angeles';
        newuser.LocaleSidKey = 'en_US';
        newuser.EmailEncodingKey = 'UTF-8';
        newuser.ProfileId =[SELECT Id FROM Profile limit 1].Id;
        newuser.LanguageLocaleKey = 'en_US';
        insert newuser;
        
        List<trailheadapp__User_Badge__c> userbadges = new List<trailheadapp__User_Badge__c>();
        
        for(integer i = 0; i < badges.size(); i++)
        {
            trailheadapp__User_Badge__c userbadge = new trailheadapp__User_Badge__c();
            userbadge.trailheadapp__Badge__c = badges[i].Id;
            userbadge.trailheadapp__User__c = newuser.Id;
                userbadge.trailheadapp__Status__c = 'Completed';
            
            userbadges.add(userbadge);
        }
        
        insert userbadges;
        
        System.debug('Badges found: ' + badges);
        System.debug('User Badges List: ' + userbadges);
        System.debug('User info: ' + newuser);
    }


    public static trailheadapp__Badge__c createBadgeRecord(String superBadgeName){
        trailheadapp__Badge__c badge = new trailheadapp__Badge__c();
        badge.Name = superBadgeName;
        badge.trailheadapp__Description__c = 'This is a test badge.';
        badge.trailheadapp__URL__c = 'https://www.youtube.com/';
        badge.trailheadapp__Icon__c = 'https://uxwing.com/exam-test-icon/';
        badge.trailheadapp__API_Name__c = 'this-is-a-test-badge-';
        badge.trailheadapp__Namespace__c = 'Test Namespace';

        return badge;
    }


    
}
