public without sharing class ExtractAllObjectsWithFieldsSorted {
    public List<String> excludeList;
    public Boolean shouldHaveRecordTypes;

    public ExtractAllObjectsWithFieldsSorted(){
        this.excludeList = new List<String>{'history', 'tag', 'share', 'feed', 'group', 'public', 'log'};
        this.shouldHaveRecordTypes = false;
    }

    public ExtractAllObjectsWithFieldsSorted(List<String> excludeList, Boolean shouldHaveRecordTypes){
        for(String excludeListItem : excludeList){
            this.excludeList.add(excludeListItem.toLowerCase());
        }
        this.excludeList.sort();
        this.shouldHaveRecordTypes = shouldHaveRecordTypes;
    }

    public Map<String, List<String>> doExtract() {
        Map<String, List<String>> objectAndFieldsMap = new Map<String, List<String>>();
    
        for(String sObjectTypeName : readSObjectTypeNames()){
            Schema.SObjectType objectType = Schema.getGlobalDescribe().get( sObjectTypeName );
            String objectName = objectType.getDescribe().getName();
            List<Schema.RecordTypeInfo> recordTypeInfos = objectType.getDescribe().getRecordTypeInfos();

            if(!this.excludeList.contains(objectName) && (this.shouldHaveRecordTypes && recordTypeInfos.size() > 0)){
                if(!objectAndFieldsMap.keySet().contains(objectName)){
                    objectAndFieldsMap.put(objectName, new List<String>());
                }

                Map<String, Schema.SObjectField> schemaFieldsMap = objectType.getDescribe().fields.getMap();
                List<String> sortedKeys = new List<String>( schemaFieldsMap.keySet() );
                sortedKeys.sort();                

                for( String key : sortedKeys ) {
                    objectAndFieldsMap.get(objectName).add(schemaFieldsMap.get( key ).getDescribe().getName());
                }

                if(objectAndFieldsMap.get(objectName).size() > 0){
                    objectAndFieldsMap.get(objectName).sort();
                }
            }
        }       
        return objectAndFieldsMap;
    }

    public List<String> readSObjectTypeNames(){
        List<String> sObjectTypeNamesList = new List<String>(Schema.getGlobalDescribe().keySet());
        sObjectTypeNamesList.sort();
        return sObjectTypeNamesList;
    }
}
