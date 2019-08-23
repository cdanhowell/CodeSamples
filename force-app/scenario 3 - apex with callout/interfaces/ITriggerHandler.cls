public interface ITriggerHandler {

    void onBeforeUpdate(List<SObject> newList, Map<Id, SObject> oldMap);
    // other trigger types omitted for brevity.
}
