//this class will link certs to resources
public class BatchLinkCertToRes implements Database.Batchable<sObject> {
    //create certification map to bulkify
    map<id,Certification__c> certM = new map<id,Certification__c>();
    //constructor to initialize map
    public BatchLinkCertToRes(map<id,Certification__c> certMapP){
        certM = certMapP;
}
    public Database.QueryLocator start(Database.BatchableContext bc) {
        //create scope based on bulkification map
        return database.getQueryLocator([SELECT City__c, Country__c, 
        Email__c, Id, Name, Name__c, Period__c, Resource__c, State_Province__c, Status__c, Type__c
        FROM Certification__c where id in :certM.keySet()]); 
    }

    public void execute(Database.BatchableContext bc, List<Certification__c> scope){
    	//get a full list of resources
        List<Resources__c> resL = [select id, webassessor_email__c, employee_email_id__c from resources__c];
       

        //create a string string map
        Map<string, string> resM = new Map<string, string>();

        //loop through all resources to build a map with their email as key and id as getter
        for(Resources__c resF:resL){
            resM.put(resF.Webassessor_Email__c , resF.Id);
        }

        //loop through certs and assign back
        for(Certification__c certF:scope){
            certf.Resource__c = resM.get(certF.Email__c);
        }
        //DML
        update scope;
    }

    public void finish(Database.BatchableContext bc){
        //upon finish, count the certs on the res
        BatchCountCertsOnRes myBatch = new BatchCountCertsOnRes(certM);
        database.executeBatch(myBatch);

    }
}