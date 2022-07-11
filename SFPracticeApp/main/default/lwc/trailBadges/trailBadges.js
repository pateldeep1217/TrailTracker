import { LightningElement, wire,api,track } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';

import ID from '@salesforce/schema/Resources__c.User__c';
import userBadges from '@salesforce/apex/UserBadgesController.getUserBadge';
export default class TrailBadges extends LightningElement {
    
    Id
    @api recordId

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

    

}






    
// for(let i in this.result){
//     console.log('result loop = ' + this.result[i]);
//     for(let j in this.result){
//         console.log('result loop 2x = ' +  JSON.stringify(this.result[i][j]))

      
//     }
// }