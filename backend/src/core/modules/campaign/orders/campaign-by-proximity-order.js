import { Order } from 'core/common/orders';

export class CampaignByProximityOrder extends Order {
    #lat;
    #lng;

    constructor(lat, lng, direction = 'ASC') {
        super(direction);
        if (!lat || !lng) throw new Error('Latitude and longitude are required');
        this.#lat = parseFloat(lat);
        this.#lng = parseFloat(lng);
    }

    toSql() {
        return `ST_Distance(
            ST_MakePoint(cast(coordinate->>'lng' as float), cast(coordinate->>'lat' as float))::geography,
            ST_MakePoint(${this.#lng}, ${this.#lat})::geography) ${this.direction}`;
    }
}
