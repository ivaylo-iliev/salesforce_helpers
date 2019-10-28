/**
 * Read Custom Metadata type REST_Settings__mdt and extract all settings for the REST API connection.
 * See RESTSettingsReadme.md for details.
 */

public with sharing class RESTSettings {
	public static String getAsString(String settingName) {
		if (String.isEmpty(settingName)) {
			return null;
		}

		List<REST_Settings__mdt> data = [SELECT value__c FROM REST_Settings__mdt WHERE DeveloperName = :settingName LIMIT 1];
		if (Test.isRunningTest()) {
			if (settingName == 'OK') {
				data.add(new REST_Settings__mdt(
						DeveloperName = 'OK',
						Label  = 'OK Test value',
						value__c = '1234565'
				));
			} else if (settingName == 'FAIL') {
				data.clear();
			}
		}

		if (data.size() == 0) {
			return null;
		}

		return data[0].value__c;
	}
}