public class BatchCountCertsOnRes implements Database.Batchable<sObject> {
    //certification map to bulkify
    map<id,Certification__c> certM = new map<id,Certification__c>();
    //create a set to also bulkify the resources
    Set<String> resID = new Set<String>();
    public BatchCountCertsOnRes(map<id,Certification__c> certMapP){
        certM = certMapP;       //initialize the certs
        //loop through certs to initialize res set
        for(Certification__c certF : [select resource__c from certification__c where id in :certM.keySet()]){
            resID.add(certF.resource__c);
        }
}
    //get the scope for res, based on the set in the constructor
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return database.getQueryLocator([SELECT Id, Emp_Code__c, Webassessor_Email__c, Certification_Count__c 
                                        FROM Resources__c where id in :resID]);

    }

    public void execute(Database.BatchableContext bc, List<Resources__c> scope){
        //create a map of id/res based on the scope
        Map<Id, Resources__c> resML = new Map<Id, Resources__c>(scope);

        //set count to 0 in map to properly count
        for(ID resFID: resML.keySet()){
            resML.get(resFID).Certification_Count__c = 0;
        }

        //loop through actions
        for(Certification__c certF: [SELECT resource__c FROM Certification__c where resource__c != null and id in :certM.keyset()]){
            //count up
            resML.get(certF.Resource__c).Certification_Count__c = resML.get(certF.Resource__c).Certification_Count__c + 1;
            
        }
        //DML
        update scope;
    }
    public void finish(Database.BatchableContext bc){
        //XXXXXXXXXXXX

    }
}