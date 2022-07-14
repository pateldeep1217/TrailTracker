import { LightningElement, wire,api,track } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';

import ID from '@salesforce/schema/Resources__c.User__c';
import userBadges from '@salesforce/apex/UserBadgesController.getUserBadge';
import userBadgesInfo from '@salesforce/apex/UserBadgesController.getUserBadgesInfo';
export default class TrailBadges extends LightningElement 
{
    ID
    @api recordId
    @track users;
  
    userId
    @track badgesInfo
  

    
    @wire(getRecord, {recordId:'$recordId', fields:[ID]})
    resourceHandler({data}){
        if(data){
        //    console.log(data.fields.User__c.value);
           this.ID = data.fields.User__c.value
           console.log( "id = " + this.ID);
      
        }
    }

    @wire(userBadges)
    wiredUserBadges({error, data})
    {
        if(data)
        {
            this.users = data;
            console.log(this.users);
            console.log(data);
            console.log("ID inside wire =  " + this.ID);
            for (const key in this.users)
            {
               
                console.log(this.users[key].Id);
                
                if(this.users[key].Id == this.ID)
                {
                  
                    console.log('inside If');
                    this.userId = this.users[key].Id;
                    console.log(this.users[key].Badges);
                }    
  
            }

      
        }

        else if (error)
        {
            console.log(error);
        }
    }



    @wire(userBadgesInfo, { userId: '$userId' })
    userBadgeList(data,error){
        if(data){
            console.log("data = " + data);
        


            const userBadgeArray = Object.entries(data);
            this.badgesInfo = userBadgeArray;
            console.log(this.badgesInfo);
            console.log(userBadgeArray);
          
                        
            

          
        }else if(error){
            console.log(error);
        }

    }


    @wire(userBadgesInfo, { userId: '$userId' })
    badgeList


}

