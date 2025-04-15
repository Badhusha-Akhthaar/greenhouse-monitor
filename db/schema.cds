namespace greenhouseapp;

using { managed } from '@sap/cds/common';

@assert.unique:{ greenhouse_id: [greenhouse_id]}
entity Greenhouse : managed
{
    key ID : UUID;
    greenhouse_id : String(10) not null @assert.format : '^GH[a-zA-Z]+[0-9]{5}$';
    location : Address;
    sensors : Composition of many Sensors on sensors.greenhouse = $self;
}

type Address
{
    city : String(50) not null;
    state : String(50) not null;
    country : String(50) not null;
    latitude : Decimal not null;
    longitude : Decimal not null;
}

@assert.unique:{ sensor_id: [greenhouse,sensor_id]}
entity Sensors : managed
{
    key ID : UUID;
    sensor_id : String(10) not null;
    greenhouse : Association to one Greenhouse;
    measures : Composition of many Measure on measures.sensor = $self;
}

@assert.unique:{ measure: [sensor,measure]}
entity Measure : managed
{
    key ID : UUID;
    measure : String(20) not null @assert.format : '^[a-z]+$';
    uom : String(5) not null;
    min : Decimal not null;
    max : Decimal not null;
    sensor : Association to one Sensors;
}
