import { LightningElement, wire,api,track } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';
import ID from '@salesforce/schema/Resources__c.User__c';
import userBadgeCount from '@salesforce/apex/UserBadgesController.getUserBadgeCount';
import userBadgeInfo from '@salesforce/apex/UserBadgesController.getUserBadgeInfo';
import userBadgeInProgress from '@salesforce/apex/UserBadgesController.getUserBadgeInProgress';

export default class TrailBadges extends LightningElement 
{
    @api recordId;
    @api badgesInfo;
    @track users;   
    @track badge
    ID;
    userId;
    count;
    progress
    buttonCategory = ''

    @wire(getRecord, {recordId:'$recordId', fields:[ID]})
    resourceHandler({data})
    {
        if(data)
        {
        //    console.log(data.fields.User__c.value);
           this.ID = data.fields.User__c.value
           console.log( "id = " + this.ID);
        }
    }

    @wire(userBadgeCount)
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
                    this.count = this.users[key].Badges;
                }    
            }
        }

        else if (error)
        {
            console.log(error);
        }
    }


    @wire(userBadgeInProgress)
    wiredUserBadgesInProgress({error, data})
    {
        if(data)
        {
            this.users = data;
            console.log(this.users);
            console.log("data inprogress" + data);
            console.log("ID inside wire progress =  " + this.ID);
            for (const key in this.users)
            {
                console.log(this.users[key].Id);
                if(this.users[key].Id == this.ID)
                {
                  
                    console.log("progress badge = "+this.users[key].Badges);
                    this.progress = this.users[key].Badges;
                }    
            }
        }

        else if (error)
        {
            console.log(error);
        }
    }

    @wire(userBadgeInfo, { userId: '$userId', buttonCategory: '$buttonCategory' })
    badgeList


    clickHandler(event){
        this.buttonCategory = event.target.value;
        console.log(this.buttonCategory);
    }
    
}

