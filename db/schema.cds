namespace greenhouseapp;


using { managed } from '@sap/cds/common';

entity Greenhouse : managed
{
    key ID : UUID;
    key greenhouse_id : String(10);
    location : Address;
    sensors : Composition of many Sensors on sensors.greenhouse = $self;
}

type Address
{
    city : String(50);
    state : String(50);
    country : String(50);
    latitude : Decimal;
    longitude : Decimal;
}

entity Sensors : managed
{
    key ID : UUID;
    key sensor_id : String(10);
    greenhouse : Association to one Greenhouse;
    measures : Composition of many Measure on measures.sensor = $self;
}

entity Measure : managed
{
    key ID : UUID;
    measure : String(20);
    uom : String(5);
    min : Decimal;
    max : Decimal;
    sensor : Association to one Sensors;
}
