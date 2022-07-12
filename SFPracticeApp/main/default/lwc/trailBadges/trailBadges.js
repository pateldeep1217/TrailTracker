import { LightningElement, wire,api,track } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';

import ID from '@salesforce/schema/Resources__c.User__c';
import userBadges from '@salesforce/apex/UserBadgesController.getUserBadge';
export default class TrailBadges extends LightningElement 
{
    //ID
    //@api recordId
    @track users;
    @track user;

    @wire(userBadges)
    wiredUserBadges({error, data})
    {
        if(data)
        {
            this.users = data;

            for (const key in this.users)
            {
                //const maybestring = JSON.stringify(this.users[key].ID);
                
                if(this.users[key].ID == "0058Z000007y6sDQAQ")
                {
                    //this.user = this.users[key];
                    //console.log(this.users[key]);
                    console.log('This makes no fucking sense');
                    
                }
                console.log('This makes no fucking sense INTENSIFIES');

                
                console.log(this.users[key].Id);
                console.log(this.users[key].Badges);
            }

            //console.log(this.users[0].Id);
        }

        else if (error)
        {
            console.log(error);
        }
    }
}

/*
    @wire(getRecord, {recordId:'$recordId', fields:[ID]})
    resourceHandler({data}){
        if(data){
        //    console.log(data.fields.User__c.value);
           this.Id = data.fields.User__c.value
      
        }
    }
    
    @wire(userBadges)
    badges(data){
        if(data){
                console.log('data =  ' + JSON.stringify(data.data)); 
                console.log('data without stringify =  ' + data.data);
        }   
    }
    */
// for(let i in this.result){
//     console.log('result loop = ' + this.result[i]);
//     for(let j in this.result){
//         console.log('result loop 2x = ' +  JSON.stringify(this.result[i][j]))
//     }
// }