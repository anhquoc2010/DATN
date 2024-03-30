import { Order } from './'

export class ThenByOrder extends Order {
    #firstOrder;
    #secondOrder;

    constructor(firstOrder, secondOrder) {
        super();
        this.#firstOrder = firstOrder;
        this.#secondOrder = secondOrder;
    }

    toSql() {
        console.log(123,this.#firstOrder.toSql(), " ",this.#secondOrder.toSql());
        return `${this.#firstOrder.toSql()}, ${this.#secondOrder.toSql()}`;
    }
}
