import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/common/constants/endpoints.dart';
import 'package:mobile/common/helpers/dio.helper.dart';
import 'package:mobile/data/datasources/campaign.mock.dart';
import 'package:mobile/data/dtos/set_campaign.dto.dart';
import 'package:mobile/data/models/campaign.model.dart';

@lazySingleton
class CampaignDataSource {
  final DioHelper _dioHelper;

  CampaignDataSource({required DioHelper dioHelper}) : _dioHelper = dioHelper;

  Future<List<CampaignModel>> getCampaigns() async {
    return CampaignMock.getCampains();
  }

  Future<List<CampaignModel>> searchCampaigns(
    int? provinceCode,
    int? districtCode,
    int? wardCode,
    String keyword,
  ) async {
    return await CampaignMock.getCampains();
  }

  Future<CampaignModel> getCampaignById(int id) async {
    return (await CampaignMock.getCampains())[id];
  }

  Future<void> setCampaign(SetCampaignDTO setCampaignParams) async {
    await _dioHelper.post(
      '${Endpoints.campaignByOrganization}/${setCampaignParams.organizationId}/campaigns',
      data: setCampaignParams.toJson(),
    );
  }

  Future<List<CampaignModel>> getCampainsByLocation(LatLng wardLocation) async {
    return CampaignMock.getCampains();
  }

  Future<List<CampaignModel>> getCampaignsByOrganizationId(
    int organizationId,
  ) async {
    final response = await _dioHelper
        .get('${Endpoints.campaignByOrganization}/$organizationId/campaigns');

    return (response.body as List<dynamic>)
        .map((e) => CampaignModel.fromJson(e))
        .toList();
  }

  Future<CampaignModel> getCampaignDetail(int campaignId) async {
    return (await CampaignMock.getCampains())[0];
  }

  Future<void> joinCampaign(int campaignId) async {}
}
