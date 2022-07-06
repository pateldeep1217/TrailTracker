trigger CertificationTrigger on certification__c (after insert) {

    //run trigger after insert cert
    if(trigger.isAfter && trigger.isInsert){
        //if this is a bulk import
        if(trigger.new.size()>=100){
            //clear all certs and make wave for new
            BatchClearCertifications myBatch = new BatchClearCertifications(trigger.newMap);
            database.executeBatch(myBatch);
        }
        //if this is a one off
        else{
            //copy the single cert and move on
            BatchCopyToHistorical myBatch = new BatchCopyToHistorical(trigger.newMap);
            database.executeBatch(myBatch);
        }
    }

}