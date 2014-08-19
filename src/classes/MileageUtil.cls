public class MileageUtil {
	static final Integer MAX_MILES_PER_DAY = 500;

	public static void areMilesAllowed(Mileage__c[] miles) {
		String createdbyId = UserInfo.getUserId();
		
		Double totalMiles = 0;
		
		/* adds miles that were created in previous requests for today */
		for(Mileage__c mq:[select miles__c from Mileage__c
		where Date__c = TODAY and
		createdById = :createdbyId and
		miles__c != null]) {
		totalMiles += mq.miles__c;
		}
		
		/* Totals the miles in the request */
		for (Mileage__c m:miles) {
		totalMiles += m.miles__c;
		if(totalMiles > MAX_MILES_PER_DAY)
		m.addError('Mileage request exceeds daily limit: ' + MAX_MILES_PER_DAY);
		}		
	}
}