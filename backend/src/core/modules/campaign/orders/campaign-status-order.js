import { Order } from 'core/common/orders';

export class CampaignStatusOrder extends Order {
    #upComing;
    #onGoing;
    #passed;

    constructor(upComing, onGoing, passed, direction = 'ASC') {
        super(direction);
        this.#upComing = Number(upComing);
        this.#onGoing = Number(onGoing);
        this.#passed = Number(passed);
    }

    toSql() {
        return `
            CASE
                WHEN campaigns.start_date > NOW() AND campaigns.end_date > NOW() THEN ${this.#upComing}  -- UPCOMING
                WHEN campaigns.start_date < NOW() AND campaigns.end_date < NOW() THEN ${this.#passed}  -- PASSED
                ELSE ${this.#onGoing}  -- ONGOING
            END ${this.direction}
        `;
    }
}
