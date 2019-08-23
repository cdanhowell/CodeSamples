public abstract class TriggerHandler implements ITriggerHandler{

    protected final SObjectType sType { get; private set; }
    protected final DescribeSObjectResult sTypeDesc { get; private set; }

    public TriggerHandler(SObjectType sType) {
        if (sType == null) {
            throw new NullPointerException();
        }

        this.sType = sType;
        this.sTypeDesc = sType.getDescribe();
    }

    public virtual void onBeforeUpdate(List<SObject> newList, Map<Id,SObject> newMap) { }

    // other trigger types omitted for brevity
}
