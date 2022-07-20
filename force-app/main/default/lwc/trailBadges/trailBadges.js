import { LightningElement, wire,api,track } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';
import ID from '@salesforce/schema/Resources__c.User__c';

//aggregated list for Total badges
import userBadgeCount from '@salesforce/apex/UserBadgesController.getUserBadgeCount';

//aggregated List for in progress badges
import userBadgeInProgress from '@salesforce/apex/UserBadgesController.getUserBadgeInProgress';

// list of all user badges 
import userBadgeInfo from '@salesforce/apex/UserBadgesController.getUserBadgeInfo';

export default class TrailBadges extends LightningElement 
{
    //passing parameter for get record wire adapter 
    @api recordId;

    //getting total badge data from apex class with help of wire adapter
    @track userTotalBadgesData;   

    //getting in progress data from apex class with help of wire adapter 
    @track userInProgressBadgesData;   

    // user id getting from get record wire adapter 
    ID;

    //user id getting form apex class badge info 
    userId;

    // variable for total badges
    @api count;
    //varaible for in progress badges
    @api progress

    //getting value from user when they click on button
    buttonCategory = ''


    // get record wire adapter 
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
            this.userTotalBadgesData = data;
            //passing data to get badges function to get number of compeleted badges
            this.getBadges(this.userTotalBadgesData);
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
            this.userInProgressBadgesData = data;  
            //passing data to get badges function  to get nunber of in progress badges
            this.getBadges(this.userInProgressBadgesData);

        }

        else if (error)
        {
            console.log(error);
        }
    }
    //function which is being used in userBadgeCount and userBadgeInProgress wire adapter to get number of compeleted and in progress badges
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
  
      

    //passing the user id and button value to get the badges info. 
    @wire(userBadgeInfo, { userId: '$userId', buttonCategory: '$buttonCategory' })
    badgeList

  
 

}