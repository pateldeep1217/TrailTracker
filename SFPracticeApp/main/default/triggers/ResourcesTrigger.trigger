trigger ResourcesTrigger on Resources__c (after update) {

    if(trigger.isAfter && trigger.isUpdate){
    
        set<string> resEmailSet = new set<string>();

        for(resources__c resF:trigger.new){
            if(resF.Webassessor_Email__c != trigger.oldMap.get(resF.id).Webassessor_Email__c){
                resEmailSet.add(resF.Webassessor_Email__c);
            }//close if
        
        }//close for

        if(resEmailSet.size()>0){

            map<id, certification__c> certMap = new map<id,certification__c>([select name, email__c, id from certification__c where email__c in :resEmailSet]);

            BatchLinkCertToRes myBatch = new BatchLinkCertToRes(certMap);
            database.executeBatch(myBatch);
        }

    }//close if
}//close trigger