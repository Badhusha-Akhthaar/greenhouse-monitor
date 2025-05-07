using GreenhouseService as service from '../../srv/admin-service';
annotate service.Greenhouse with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>GreenhouseId}',
                Value : greenhouse_id,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>City}',
                Value : location_city,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>State}',
                Value : location_state,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Country1}',
                Value : location_country,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Latitude}',
                Value : location_latitude,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Longitude}',
                Value : location_longitude,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Sensors}',
            ID : 'i18nSensors',
            Target : 'sensors/@UI.LineItem#i18nSensors',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : '{i18n>Id}',
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>GreenhouseId}',
            Value : greenhouse_id,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>City}',
            Value : location_city,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>State}',
            Value : location_state,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Country1}',
            Value : location_country,
        },
    ],
    UI.SelectionFields : [
        greenhouse_id,
        location_city,
        location_country,
        location_state,
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : greenhouse_id,
        },
        TypeName : '',
        TypeNamePlural : '',
    },
);

annotate service.Greenhouse with {
    greenhouse_id @Common.Label : '{i18n>GreenhouseId}'
};

annotate service.Greenhouse : location.city with @Common.Label : '{i18n>City}';

annotate service.Greenhouse : location.country with @Common.Label : '{i18n>Country1}';

annotate service.Greenhouse : location.state with @Common.Label : '{i18n>State}';

annotate service.Sensors with @(
    UI.LineItem #i18nSensors : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : sensor_id,
            Label : '{i18n>SensorId}',
        },
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : sensor_id,
        },
        TypeName : '',
        TypeNamePlural : '',
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>SensorDetails}',
            ID : 'i18nSensorDetails',
            Target : '@UI.FieldGroup#i18nSensorDetails',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Measures}',
            ID : 'i18nMeasures',
            Target : 'measures/@UI.LineItem#i18nMeasures',
        },
    ],
    UI.FieldGroup #i18nSensorDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : sensor_id,
                Label : '{i18n>SensorId}',
            },
            {
                $Type : 'UI.DataField',
                Value : certificate,
                Label : '{i18n>Certificate}',
            },
            {
                $Type : 'UI.DataField',
                Value : private_key,
                Label : '{i18n>Privatekey}',
            },
        ],
    },
);

annotate service.Measure with @(
    UI.LineItem #i18nMeasures : [
        {
            $Type : 'UI.DataField',
            Value : measure,
            Label : '{i18n>MeasureName}',
        },
        {
            $Type : 'UI.DataField',
            Value : uom,
            Label : '{i18n>UnitOfMeasurement}',
        },
        {
            $Type : 'UI.DataField',
            Value : min,
            Label : '{i18n>MinimumThreshold}',
        },
        {
            $Type : 'UI.DataField',
            Value : max,
            Label : '{i18n>MaximumThreshold}',
        },
        {
            $Type : 'UI.DataField',
            Value : currentValue,
            Label : '{i18n>CurrentValue}',
        },
    ]
);

annotate service.Sensors with {
    certificate @UI.MultiLineText : true
};

annotate service.Sensors with {
    private_key @UI.MultiLineText : true
};

