import { Specification } from 'core/common/specifications';

export class CampaignLocationProximitySpecification extends Specification {
    #lat;
    #lng;
    #radius = 5000;
    
    constructor(lat, lng) {
        super();
        this.#lat = lat;
        this.#lng = lng;
    }

    toSql() {
        return [`ST_DWithin(
            ST_MakePoint(cast(coordinate->>'lng' as float), cast(coordinate->>'lat' as float))::geography,
            ST_MakePoint(:lng, :lat)::geography,:radius)`, 
            { lng: this.#lng, lat: this.#lat, radius: this.#radius }];
    }
}
