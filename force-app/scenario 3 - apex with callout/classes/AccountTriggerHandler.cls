public with sharing class AccountTriggerHandler extends TriggerHandler {

    private final IApiResource parentApiResource;

    public AccountTriggerHandler(IApiResource parentApiResource) {
        super(Account.getSObjectType());

        if (parentApiResource == null) {
            throw new NullPointerException();
        }

        this.parentApiResource = parentApiResource;
    }

    public override void onBeforeUpdate(List<SObject> newList, Map<Id,SObject> oldMap) {

        List<Id> recalcParentDiscounts = new List<Id>();

        for (Account acct : (List<Account>)newList) {
            if (acct.Parent != ((Account)oldMap.get(acct.Id)).Parent && acct.Parent != null) {
                recalcParentDiscounts.add(acct.Id);
            }
        }

        if (!recalcParentDiscounts.isEmpty()) {
            futureBeforeUpdate(recalcParentDiscounts, JSON.serialize(parentApiResource));
        }
    }

    @future
    private static void futureBeforeUpdate(List<Id> recalcParentDiscounts, String parentApiResourceJSON) {

        IApiResource parentApiResource = (IApiResource)JSON.deserialize(parentApiResourceJSON, ParentApiResource.class);

        Map<Integer, Double> result = (Map<Integer, Double>)parentApiResource.get(null);

        // need a map to hold the discounts. In a real scenario this may be because we need to "transform" the data in some way first
        Map<Id, Double> acctIdToDiscount = new Map<Id, Double>();

        Integer iter = 0;
        for (Id acctId : recalcParentDiscounts) {
            Double discount = result.get(iter + 1); // map keys are hard-coded to 1, 2, 3 for demo purposes)
            acctIdToDiscount.put(acctId, discount);

            // Continue our faking... increment iter mod 3 to keep in the 1-3 range (well, 0-2 + 1)
            iter = Math.mod(iter + 1, 3);
        }

        List<Opportunity> opps = new List<Opportunity>();

        for (Opportunity opp : [SELECT Id, AccountId FROM Opportunity WHERE AccountId IN :recalcParentDiscounts AND IsClosed = FALSE]) {
            opp.Parent_Account_Discount__c = acctIdToDiscount.get(opp.AccountId);
            opps.add(opp);
        }

        update opps; // calling this directly breaks the ability to unit test the class. Should use some kind of Data interface or IUnitOfWork from apex-common
    }
}
