import { LightningElement, wire,api,track } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';
import ID from '@salesforce/schema/Resources__c.User__c';

//aggregated list for Total badges
import userBadgeCount from '@salesforce/apex/UserBadgesController.getUserBadgeCount';
import userBadgeInfo from '@salesforce/apex/UserBadgesController.getUserBadgeInfo';
//aggregated List for in progress badges
import userBadgeInProgress from '@salesforce/apex/UserBadgesController.getUserBadgeInProgress';

export default class TrailBadges extends LightningElement 
{
    @api recordId;
    @api badgesInfo;
    @track userTotalBadges;   
    @track userInProgressBadges;   
    @track badge
    ID;
    userId;
    @api count;
    @api progress
    buttonCategory = ''


    // Getting Id from record page 
    @wire(getRecord, {recordId:'$recordId', fields:[ID]})
    resourceHandler({data})
    {
        if(data)
        {
           this.ID = data.fields.User__c.value
           console.log( "id = " + this.ID);
        }
    }

    //getting Total Badges which are Completed 
    @wire(userBadgeCount)
    wiredUserBadges({error, data})
    {
        if(data)
        {
            this.userTotalBadges = data;
            this.getBadges(this.userTotalBadges);
        }

        else if (error)
        {
            console.log(error);
        }
    }

    //getting Total badges which are In progress
    @wire(userBadgeInProgress)
    wiredUserBadgesInProgress({error, data})
    {
        if(data)
        {
            this.userInProgressBadges = data;    
            this.getBadges(this.userInProgressBadges);

        }

        else if (error)
        {
            console.log(error);
        }
    }
    //matches the user Id from record page to the data user Id and will get total badges 
    getBadges(data){
        console.log(data);
        for (const key in data)
            {              
                console.log(data[key].Id);
                //matching user id
                if(data[key].Id == this.ID)
                {
                    this.userId = data[key].Id;
                    // checking wheather status is compeleted or in progress
                    if(data[key].trailheadapp__Status__c == 'Completed'){
                        this.count = data[key].Badges;
                    }else if(data[key].trailheadapp__Status__c == 'In-Progress'){
                        this.progress = data[key].Badges;
                    }
                }    
            }
    }


    //click handler to get the button value 
    clickHandler(event){
        this.buttonCategory = event.target.value;
        console.log(this.buttonCategory);
    }


    //passing the button value to get the list. 
    @wire(userBadgeInfo, { userId: '$userId', buttonCategory: '$buttonCategory' })
    badgeList

 

}