sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'com.greenhouseapp.greenhouse',
            componentId: 'GreenhouseList',
            contextPath: '/Greenhouse'
        },
        CustomPageDefinitions
    );
});