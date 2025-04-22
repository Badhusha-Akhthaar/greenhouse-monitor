using {greenhouseapp as schema} from '../db/schema';

@path: 'analytical'
service AnalyticalService {
    entity Greenhouse as projection on schema.Greenhouse;
    @cds.redirection.target: true
    entity Sensors    as projection on schema.Sensors;
    entity Measure    as projection on schema.Measure;
    entity ExcursionAnalytics as projection on schema.Excursion {
        sensor,
        timestamp,
        count(*) as excursionCount: Integer
    } group by sensor.ID,timestamp;

    
    entity AnomalySensors as projection on schema.Sensors {
        greenhouse.ID as greenhouse_id,
        count(*) as anomalySensorCount: Integer
    } group by greenhouse.ID,state having state = 'ANOMALY';

    entity NormalSensors as projection on schema.Sensors {
        greenhouse.ID as greenhouse_id,
        count(*) as anomalySensorCount: Integer
    } group by greenhouse.ID,state having state = 'NORMAL';


    entity TemperatureReadings as projection on schema.Telemetry{
        key timestamp,
        key telemetryMeasures.measure,
        telemetryMeasures.value,
        sensor,
    } group by sensor.ID,telemetryMeasures.measure,timestamp,telemetryMeasures.value;
}

// annotate AnalyticalService.Greenhouse with @(
//     Aggregation.ApplySupported           : {
//         Transformations       : [
//             'aggregate',
//             'topcount',
//             'bottomcount',
//             'identity',
//             'concat',
//             'groupby',
//             'filter',
//             'search'
//         ],
//         GroupableProperties   : [
//             location_city,
//             location_state
//         ],
//         AggregatableProperties: [{
//             $Type   : 'Aggregation.AggregatablePropertyType',
//             Property: greenhouse_id,
//         }, ]
//     },
//     Analytics.AggregatedProperty #totalGH: {
//         $Type               : 'Analytics.AggregatedPropertyType',
//         AggregatableProperty: greenhouse_id,
//         AggregationMethod   : 'countdistinct',
//         Name                : 'totalGH',
//         ![@Common.Label]    : 'Total Greenhouse'
//     }
// );
