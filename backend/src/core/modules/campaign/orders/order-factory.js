import { CampaignByProximityOrder, CampaignStatusOrder } from '.'

export class OrderFactory {
    static OrderTypeEnum = {
        PROXIMITY: 'proximity',
        PASSED_ONGOING_UPCOMING: 'passed_ongoing_upcoming',
        UPCOMING_PASSED_ONGOING: 'upcoming_passed_ongoing',
        PASSED_UPCOMING_ONGOING: 'passed_upcoming_ongoing',
    };
    static getOrder(param, lat, lng, direction) {
        switch(param) {
            case this.OrderTypeEnum.PROXIMITY:
                return new CampaignByProximityOrder(lat, lng, direction);
            case this.OrderTypeEnum.PASSED_ONGOING_UPCOMING:
                return new CampaignStatusOrder(3, 2, 1, direction);
            case this.OrderTypeEnum.UPCOMING_PASSED_ONGOING:
                return new CampaignStatusOrder(1, 3, 2, direction);
            case this.OrderTypeEnum.PASSED_UPCOMING_ONGOING:
                return new CampaignStatusOrder(2, 3, 1, direction);
            default:
                throw new Error('Order not found');
        }
    }

    static getAllOrderQueryValues() {
        return Object.values(this.OrderTypeEnum).join(", ");
    }
}
