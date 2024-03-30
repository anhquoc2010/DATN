import { ThenByOrder } from './';

export class Order {
    constructor(direction = null) {
        if (direction) {
            this.validateDirection(direction);
        }
        this.direction = direction;
    }

    validateDirection(direction) {
        var direction = direction.toUpperCase();

        if (direction !== 'ASC' && direction !== 'DESC') {
            throw new Error('Invalid direction');
        }
    }

    thenBy(order) {
        return new ThenByOrder(this, order);
    }
}
