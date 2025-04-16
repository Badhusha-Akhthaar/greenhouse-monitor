namespace greenhouseapp;

using { managed } from '@sap/cds/common';

entity Greenhouse : managed
{
    key ID : UUID;
    greenhouse_id : String(10) not null
        @assert.format : '^GH[a-zA-Z]+[0-9]{5}$'
        @mandatory;
    location : Address;
    sensors : Composition of many Sensors on sensors.greenhouse = $self;
}

annotate Greenhouse with @assert.unique :
{
    greenhouse_id : [ greenhouse_id ],
};

type Address
{
    city : String(50) not null
        @mandatory;
    state : String(50) not null
        @mandatory;
    country : String(50) not null
        @mandatory;
    latitude : Decimal not null
        @mandatory;
    longitude : Decimal not null
        @mandatory;
}

entity Sensors : managed
{
    key ID : UUID;
    sensor_id : String(10) not null
        @mandatory;
    greenhouse : Association to one Greenhouse;
    measures : Composition of many Measure on measures.sensor = $self;
    telemetries : Composition of many Telemetry on telemetries.sensor = $self;
    excursions : Composition of many Excursion on excursions.sensor = $self;
    state : SensorState;
}

annotate Sensors with @assert.unique :
{
    sensor_id : [ sensor_id ],
};

entity Measure : managed
{
    key ID : UUID;
    measure : String(20) not null
        @assert.format : '^[a-z]+$'
        @mandatory;
    uom : String(5) not null
        @mandatory;
    min : Decimal not null
        @mandatory;
    max : Decimal not null
        @mandatory;
    sensor : Association to one Sensors;
    currentValue : Decimal;
}

annotate Measure with @assert.unique :
{
    measure : [ sensor, measure ],
};

entity Telemetry
{
    key ID : UUID;
    timestamp : Timestamp;
    telemetryMeasures : Composition of many TelemetryMeasures on telemetryMeasures.telemetry = $self;
    sensor : Association to one Sensors;
}

entity TelemetryMeasures
{
    key ID : UUID;
    measure : String(20);
    value : Decimal;
    telemetry : Association to one Telemetry;
}

entity Excursion
{
    key ID : UUID;
    error_type : Threashold;
    sensor : Association to one Sensors;
    timestamp : Timestamp;
}

type Threashold : String enum
{
    ABOVE = 'Above Threshold';
    BELOW = 'Below Threshold';
}

type SensorState : String enum
{
    ANOMALY = 'Anomaly';
    NORMAL = 'Normal';
}
