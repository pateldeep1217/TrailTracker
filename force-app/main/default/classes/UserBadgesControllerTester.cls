@isTest
public class UserBadgesControllerTester 
{
	@testSetup
    static void setup()
    {
        List<trailheadapp__Badge__c> badges = new List<trailheadapp__Badge__c>();
        
        for(integer i = 0; i < 10; i++)
        {
            trailheadapp__Badge__c badge = new trailheadapp__Badge__c();
            badge.Name = 'Test Badge ' + i;
            badge.trailheadapp__Description__c = 'This is a test badge.';
            badge.trailheadapp__URL__c = 'https://www.youtube.com/';
            badge.trailheadapp__Icon__c = 'https://uxwing.com/exam-test-icon/';
            badge.trailheadapp__API_Name__c = 'this-is-a-test-badge-' + i;
            badge.trailheadapp__Namespace__c = 'Test Namespace';
            
            if(Math.mod(i, 2) == 0)
            {
                badge.trailheadapp__Type__c = 'Superbadge';
            }
            
            badges.add(badge);
        }
        
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
            
            if(Math.mod(i, 2) == 0)
            {
                userbadge.trailheadapp__Status__c = 'Completed';
            }
            
            else
            {
                userbadge.trailheadapp__Status__c = 'In-Progress';
            }
            
            userbadges.add(userbadge);
        }
        
        insert userbadges;
        
        System.debug('Badges found: ' + badges);
        System.debug('User Badges List: ' + userbadges);
        System.debug('User info: ' + newuser);
    }
    
    @isTest
    static void testGetUserBadgeCount()
    {
        Test.startTest();
        
        System.assertEquals(1, UserBadgesController.getUserBadgeCount().size());
        
        Test.stopTest();
    }
    
    @isTest
    static void testGetUserBadgeInProgress()
    {
        Test.startTest();
        
        System.assertEquals(1, UserBadgesController.getUserBadgeInProgress().size());
        
        Test.stopTest();
    }
    
    @isTest
    static void testGetUserBadgeInfo()
    {
        
        Test.startTest();
        
        Id userId = [SELECT Alias FROM User WHERE Alias = 'TestUser'].Id;
        String buttonCategory = 'Superbadge';
        
        System.debug('Retrieved ID: ' + userId);
        System.debug([SELECT Id FROM User]);
        System.debug([SELECT trailheadapp__User__r.Id, trailheadapp__Badge_Icon__c, trailheadapp__Status__c,trailheadapp__Badge__c,
                trailheadapp__Badge__r.Name,trailheadapp__Finished_Date__c  
                FROM trailheadapp__User_Badge__c 
                WHERE trailheadapp__Status__c  = 'Completed' 
                AND trailheadapp__User__r.Id =: userId]);
		
        System.assertEquals(5, UserBadgesController.getUserBadgeInfo(userId, buttonCategory).size());
        
        Test.stopTest();
    }
    
    @isTest
    static void testGetUserBadgeInfoNegative()
    {
        
        Test.startTest();
        
        Id userId = [SELECT Alias FROM User WHERE Alias = 'TestUser'].Id;
        String buttonCategory = '';
        
        System.assertEquals(5, UserBadgesController.getUserBadgeInfo(userId, buttonCategory).size());
        
        Test.stopTest();
    }

}