sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/greenhouseapp/greenhouse/test/integration/FirstJourney',
		'com/greenhouseapp/greenhouse/test/integration/pages/GreenhouseList',
		'com/greenhouseapp/greenhouse/test/integration/pages/GreenhouseObjectPage',
		'com/greenhouseapp/greenhouse/test/integration/pages/SensorsObjectPage'
    ],
    function(JourneyRunner, opaJourney, GreenhouseList, GreenhouseObjectPage, SensorsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/greenhouseapp/greenhouse') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheGreenhouseList: GreenhouseList,
					onTheGreenhouseObjectPage: GreenhouseObjectPage,
					onTheSensorsObjectPage: SensorsObjectPage
                }
            },
            opaJourney.run
        );
    }
);