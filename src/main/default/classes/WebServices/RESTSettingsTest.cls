@isTest
public class RESTSettingsTest {
	@isTest
	public static void getAsString() {
		String value = RESTSettings.getAsString('OK');

		System.assertEquals('1234565', value);

		value = RESTSettings.getAsString('FAIL');

		System.assertEquals(null, value);

		value = RESTSettings.getAsString('');

		System.assertEquals(null, value);
	}
}