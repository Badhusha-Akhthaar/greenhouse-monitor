using {greenhouseapp as schema} from '../db/schema';

@path: 'analytical'
service AnalyticalService {
    entity Greenhouse as projection on schema.Greenhouse;
    entity Sensors    as projection on schema.Sensors;
    entity Measure    as projection on schema.Measure;
    entity ExcursionAnalytics as projection on schema.Excursion {
        sensor.ID as sensor_id,
        sensor.greenhouse.ID as sensor_greenhouse_id,
        sensor,
        count(*) as excursionCount
    } group by sensor.ID,sensor.greenhouse.ID;
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
