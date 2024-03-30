import { SwaggerDocument } from '../../../packages/swagger';

export const CurrentLatitudeQuery = SwaggerDocument.ApiParams(
    {
        name: 'currentLat',
        paramsIn: 'query',
        type: 'string',
        required: false,
        description: "User's current latitude",
    }
);