//this batch class has to run on after delete
public class BatchClearCertifications implements Database.Batchable<sObject> {
    //this map will carry the certs to act upon
    map<id,Certification__c> certM = new map<id,Certification__c>();
    //populate the certs to bulkify
    public BatchClearCertifications(map<id,Certification__c> certMapP){
        certM = certMapP;
}
    public database.QueryLocator start(Database.BatchableContext bc) {
        //get a list of the certifications that were just inserted (to get the period)
        List<Certification__c> certL = [SELECT Id, Period__c
        FROM Certification__c where id in :certM.keySet()];

        date periodVar = certL[0].Period__c;

        //create cert scope based on parameter cert set
        return database.getQueryLocator([SELECT Id
        FROM Certification__c where period__c != :periodVar]); 
    }

    public void execute(Database.BatchableContext bc, list<Certification__c> scope){
        delete scope;
    }
    public void finish(Database.BatchableContext bc){
        //upon finish, copy all the new records to the historical obj
        BatchCopyToHistorical myBatch = new BatchCopyToHistorical(certM);
        database.executeBatch(myBatch);

    }
}