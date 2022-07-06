//this batch class has to run on after delete
public class BatchCopyToHistorical implements Database.Batchable<sObject> {
    //this map will carry the certs to act upon
    map<id,Certification__c> certM = new map<id,Certification__c>();
    //populate the certs to bulkify
    public BatchCopyToHistorical(map<id,Certification__c> certMapP){
        certM = certMapP;
}
    public database.QueryLocator start(Database.BatchableContext bc) {
        
        //create cert scope based on parameter cert set
        return database.getQueryLocator([SELECT City__c, Country__c, 
        Email__c, Id, Name, Name__c, Period__c, Resource__c, State_Province__c, Status__c, Type__c
        FROM Certification__c where id in :certM.keySet()]); 
    }

    public void execute(Database.BatchableContext bc, list<Certification__c> scope){
        //create a certhist to later DML insert
        list<Historical_Certification__c> histL = new list<Historical_Certification__c>();
        //fill up the histcert list
        for(Certification__c certF: scope){
            histl.add(new Historical_Certification__c(
                        City__c = certF.City__c,
                        Country__c = certF.Country__c,
                        Email__c = certF.Email__c,
                        Name = certF.Name,
                        Certification__c = certF.Name,
                        name__c = certF.name__c,
                        Period__c = certF.Period__c,
                        resource__c = certF.resource__c,
                        State_Province__c = certF.State_Province__c,
                        Status__c = certF.Status__c,
                        Type__c = certF.Type__c
            ));
        }
        //insert the list
        insert histL;
    }
    public void finish(Database.BatchableContext bc){
        //upon finish, run linking to resources on certs
        BatchLinkCertToRes myBatch = new BatchLinkCertToRes(certM);
        Database.executeBatch(myBatch);

    }
}