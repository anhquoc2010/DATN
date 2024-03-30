import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from '../../../utils';

export const SearchCampaignInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        name: Joi.string().trim().optional().empty(''),
        lng: Joi.number().optional(),
        lat: Joi.number().optional(),
        ward: Joi.string().optional(),
        district: Joi.string().optional(),
        city: Joi.string().optional(),
        orderBy: JoiUtils.order().optional(),
        currentLat: Joi.number().optional(),
        currentLng: Joi.number().optional(),
    }),
);