trigger AccountTrigger on Account (before update) {

    // better - call a single handler instance such as TriggerHandler.handle(Account.getSObjectType()) that
    // undertands how to construct individual handlers based on type (via type registration) so that this
    // class contains no logic other than invoking this singular handler
    ITriggerHandler handler = new AccountTriggerHandler(new ParentApiResource());

    if (Trigger.isBefore && Trigger.isUpdate) {
        handler.onBeforeUpdate(Trigger.new, Trigger.newMap);
    }
}