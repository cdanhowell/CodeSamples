@isTest
private class AccountNumberFormulaTest {

    @isTest static void testFormulaResult() {

        // arrange
        String expected = 'acctnumber';
        Account a = new Account(
            Name = 'testAcct',
            AccountNumber = expected
        );
        insert a;

        Opportunity opp = new Opportunity (
            Name = 'testOpp',
            AccountId = a.Id,
            StageName = 'New',
            CloseDate = Date.today()
        );
        insert opp;

        // Act
        Opportunity result = [SELECT Account_Number__c FROM Opportunity WHERE Id = :opp.Id];

        // Assert
        System.assertEquals(expected, result.Account_Number__c);
    }
}
