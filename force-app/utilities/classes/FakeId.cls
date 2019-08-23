@isTest
public class FakeId {

    private static Integer iterCount = 0;

    private final Id fakeId;

    public FakeId(SObjectType sType) {

        String iterStr = String.valueOf(iterCount);
        String newId = sType.getDescribe().getKeyPrefix()
            + '0'.repeat(12 - iterStr.length()) + iterStr;
        iterCount++;
        fakeId = (Id)newId;
    }

    public Id toId() {
        return fakeId;
    }
}
