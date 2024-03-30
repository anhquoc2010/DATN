import { OrderFactory } from 'core/modules/campaign/orders';
import { SwaggerDocument } from '../../../packages/swagger';

export const CampaignOrderQuery = SwaggerDocument.ApiParams({
    name: 'orderBy',
    paramsIn: 'query',
    type: 'string',
    required: false,
    description: `Syntax follows the pattern 'value + 'asc' or 'desc' (+ ', ') (e.g., 'value1 asc, value2 desc'). Allowed values include: ${OrderFactory.getAllOrderQueryValues()}.`,
});
