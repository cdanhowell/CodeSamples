@isTest
private class AccountTriggerHandlerTests {

    @isTest static void test_onBeforeUpdate_noParent() {
        // arrange
        List<Account> newList = new List<Account> {
            new Account(
                Id = new FakeId(Account.getSObjectType()).toId(),
                Name = 'acct1'
            )
        };

        Map<Id, Account> oldMap = new Map<Id, Account> {
            newList[0].Id => newList[0]
        };

        AccountTriggerHandler handler = new AccountTriggerHandler(new FakeParentResource());

        // act
        handler.onBeforeUpdate(newList, oldMap);

        // assert
        // make a behavior assert using Apex Mocks from apex-common or through a custom mocking interface
    }

    private class FakeParentResource implements IApiResource {
        public Object get(Map<String, Object> queryParams) {
            return null; // can put some fake data, but won't need since we won't be able to run this test as a unit test
        }
    }
}
