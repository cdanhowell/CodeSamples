@isTest
private class PayorRatingFlowTests {

    @isTest static void testNewOpp_Excellent() {
        // arrange
        Double expected = [SELECT Discount__c FROM Payor_History_Discounts__mdt WHERE DeveloperName = 'Excellent'].Discount__c;

        Account a = new Account (
            Name = 'testacct',
            Payor_History__c = 'Excellent'
        );
        insert a;

        Opportunity opp = new Opportunity (
            StageName = 'New',
            AccountId = a.Id,
            CloseDate = Date.today(),
            Name = 'testopp'
        );

        // act
        insert opp;

        // assert
        Opportunity result = [SELECT Good_Payer_Discount__c FROM Opportunity WHERE Id = :opp.Id];

        System.assertEquals(expected, result.Good_Payer_Discount__c);
    }

    @isTest static void testNewOpp_Good() {
        // arrange
        Double expected = [SELECT Discount__c FROM Payor_History_Discounts__mdt WHERE DeveloperName = 'Default'].Discount__c;

        Account a = new Account (
            Name = 'testacct',
            Payor_History__c = 'Good'
        );
        insert a;

        Opportunity opp = new Opportunity (
            StageName = 'New',
            AccountId = a.Id,
            CloseDate = Date.today(),
            Name = 'testopp'
        );

        // act
        insert opp;

        // assert
        Opportunity result = [SELECT Good_Payer_Discount__c FROM Opportunity WHERE Id = :opp.Id];

        System.assertEquals(expected, result.Good_Payer_Discount__c);
    }

    @isTest static void testNewOpp_Average() {
        // arrange
        Double expected = [SELECT Discount__c FROM Payor_History_Discounts__mdt WHERE DeveloperName = 'Default'].Discount__c;

        Account a = new Account (
            Name = 'testacct',
            Payor_History__c = 'Average'
        );
        insert a;

        Opportunity opp = new Opportunity (
            StageName = 'New',
            AccountId = a.Id,
            CloseDate = Date.today(),
            Name = 'testopp'
        );

        // act
        insert opp;

        // assert
        Opportunity result = [SELECT Good_Payer_Discount__c FROM Opportunity WHERE Id = :opp.Id];

        System.assertEquals(expected, result.Good_Payer_Discount__c);
    }

    @isTest static void testNewOpp_DefaultToExcellent() {
        // arrange
        Double expected = [SELECT Discount__c FROM Payor_History_Discounts__mdt WHERE DeveloperName = 'Excellent'].Discount__c;

        Account a = new Account (
            Name = 'testacct',
            Payor_History__c = 'Good'
        );
        insert a;

        Opportunity opp = new Opportunity (
            StageName = 'New',
            AccountId = a.Id,
            CloseDate = Date.today(),
            Name = 'testopp'
        );
        insert opp;

        // act
        a.Payor_History__c = 'Excellent';
        update a;

        // assert
        Opportunity result = [SELECT Good_Payer_Discount__c FROM Opportunity WHERE Id = :opp.Id];

        System.assertEquals(expected, result.Good_Payer_Discount__c);
    }

    @isTest static void testNewOpp_ExcellentToDefault() {
        // arrange
        Double expected = [SELECT Discount__c FROM Payor_History_Discounts__mdt WHERE DeveloperName = 'Default'].Discount__c;

        Account a = new Account (
            Name = 'testacct',
            Payor_History__c = 'Excellent'
        );
        insert a;

        Opportunity opp = new Opportunity (
            StageName = 'New',
            AccountId = a.Id,
            CloseDate = Date.today(),
            Name = 'testopp'
        );
        insert opp;

        // act
        a.Payor_History__c = 'Average';
        update a;

        // assert
        Opportunity result = [SELECT Good_Payer_Discount__c FROM Opportunity WHERE Id = :opp.Id];

        System.assertEquals(expected, result.Good_Payer_Discount__c);
    }

    // etc... need to test the IsClosed = false filter on the update process
}
