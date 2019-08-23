# Salesforce App

Code sample 8/19/2019

Request: "Please build out a trigger on account updates to make a change to all of their child opportunities."

## Solution 0: Update the Lightning Detail page (not included)

Overview:

If this is a scenario where data from the Account simply needs to be shown on the Opportunity page, but no actual DML statement is needed then the most direct option would be to simpy add a standard Lightning Related Record component to the Opportunity Detail page and include the relevant fields and data. Potentially if this requires some sort of logic or manipulation of the data, but the data doesn't need to be persisted or reportable per-se, a custom component could be used.

## Solution 1: Formula Field

Overview:

The request specifies that changes to the Account should be reflected on the Opportunity. It's unclear if this is a simple field update/sync or if a formula field will get the job done. Given that a trigger or flow updating all opportunity records would cause the last modified date to be updated, this may not be desirable.

Using a formula field will allow the Opportunities to reflect the Account page's current state information regardless of when the Opportunity is accessed. This solution is ideal for scenarios where all child opportunities need to reflect the current-state of the parent Account object's field and the logic is relatively simple.

Example Problem/Solution:

Sales reps want to see the Account Number directly on the Opportunity detail page.

Created a Formula field on Opportunity (Account_Number__c) to show the Account Number (Account.AccountNumber).

## Solution 2: Flow

Overview:

There are some limitations of formula fields - namely that they are recalculated any time a record is accessed and they are not indexed by default. For large queries (SOQL, Reports, or API) that reference the formula fields, this can lead to poor performance. Queries that filter based on a formula field are especially impacted - they first have to calculate the formula field's value for every record and do a full database scan to find matching records. Finally, they will show the Account's current state not the Account's state at the time of the last update.

The provided request doesn't indicate that this will be a concern, however an additional weakness of a formula can be that it is recalculated on access. This means an older and closed opportunity will be updated just like a newer opportunity. This behavior can be undesired if the update needs to be atomic based on some critiera (e.g., only update the value for opportunities that are not closed).

In both cases, a Process Builder, Flow, or Apex Trigger would be needed. By caching the value of the calculation in a field, we can increase the performance of queries at the cost of performance of inserts and updates and prevent future updates from leaking and modifying old data. The three options are in order of preference assuming the tool has the capabilities to handle the request.

Example Problem/Solution:

Management would like Sales folks to encourage paying on time by tracking and offering Good Payor Discounts on Opportunities.

Opportunity.Good_Payor_Discount__c - percent field with a discount that can be applied to the opportunity based on payment history
Account.Payor_History__c field - picklist with 3 values - Excellent, Good, and Average
Payor_History__mdt - custom metadata type used to match discount values
Update_Payor_Rating_Discount - Process Builder flow that updates the value in the opportunity when Account.Payor_History__c is updated and when the Opportunity is not closed.

## Scenario 3: Apex Trigger

Overview:
Perhaps Flow is inappropriate - the logic is too complex or requires some fine tuning of the queries and logic or whatever else. The next option is using Apex to automate the change.

Example problem/solution:

Opportunities get discounts based on their parent accounts. The discount amount is stored outside of Salesforce and provided via an API call. This call needs to be batched to preserve callout limits and can sometimes be long running. The discount should be applied to all open Opportunities on a new Parent Discount field.


