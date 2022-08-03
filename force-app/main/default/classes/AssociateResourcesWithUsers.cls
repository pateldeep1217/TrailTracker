public class AssociateResourcesWithUsers 
{
    public static void associate()
    {
        //First let's grab all Resources that don't have a value for the User field.
        List<Resources__c> resourceswithoutusers = [SELECT Name, User__c, Employee_Email_Id__c, Webassessor_Email__c 
                                                    FROM Resources__c 
                                                    WHERE User__c = ''];
        //Next, let's grab the Id of the Chatter Free User Profile. It'll be different for each org!
        Id chatterfreeuserid = [SELECT Name, Id 
                                FROM Profile 
                                WHERE Name = 'Chatter Free User'].Id;
        //After that, let's grab every Chatter Free User that exists in the org.
        List<User> chatterfreeusers = [SELECT Name, Email, ProfileId 
                                       FROM User 
                                       WHERE ProfileId = :chatterfreeuserid];
        //Finally, let's create a new list of Resources that are now associated with a User. We'll be upserting these records.
        List<Resources__c> newlyassociatedresources = new List<Resources__c>();
        
        //Let's loop through all the unassociated Resources and current Chatter Free Users.
        for(Resources__c resource : resourceswithoutusers)
        {
            System.debug('Resources without users: ' + resource);
            
            for(User chatterfreeuser : chatterfreeusers)
            {
                System.debug('Chatter Free Users: ' + chatterfreeuser);
                
                //We now have to check if either one of the email fields on the Resource object matches the Email on the User object.
                //If it does, then we can associate that Resource with that User 
                //and add the newly associated Resource to the empty List we created.
                if(resource.Employee_Email_Id__c == chatterfreeuser.Email || resource.Webassessor_Email__c == chatterfreeuser.Email)
                {
                    System.debug('We have now edited any Resources not previously associated with a User.');
                    resource.User__c = chatterfreeuser.Id;
                    newlyassociatedresources.add(resource);
                }
            }
        }
        
        upsert newlyassociatedresources;
        
        System.debug('Users upserted! Now go check the records!');
    }
}