sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/vbm/AnalyticMap"
], (Controller,AnalyticMap) => {
    "use strict";
    AnalyticMap.GeoJSONURL = "https://ui5.sap.com/test-resources/sap/ui/vbm/demokit/media/analyticmap/L0.json";
    return Controller.extend("greenhouseapp.analyticaldashboard.controller.Dashboard", {
        onInit() {
            let oMap = this.getView().byId("sensorMapSpots")
        }
    });
});