import { SwaggerDocument } from '../../../packages/swagger';

export const CurrentLongitudeQuery = SwaggerDocument.ApiParams(
    {
        name: 'currentLng',
        paramsIn: 'query',
        type: 'string',
        required: false,
        description: "User's current longitude",
    }
);
