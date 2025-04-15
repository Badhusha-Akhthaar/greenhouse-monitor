using { greenhouseapp as schema } from '../db/schema';

@path: 'greenhouse'
service GreenhouseService {

    @odata.draft.enabled
    entity Greenhouse as projection on schema.Greenhouse;
    entity Sensors as projection on schema.Sensors;
    entity Measure as projection on schema.Measure;

}