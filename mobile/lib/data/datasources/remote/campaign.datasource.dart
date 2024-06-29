import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/common/constants/endpoints.dart';
import 'package:mobile/common/extensions/dynamic.extension.dart';
import 'package:mobile/common/helpers/dio.helper.dart';
import 'package:mobile/data/dtos/paticipant_feedback.dto.dart';
import 'package:mobile/data/dtos/organization_feedback.dto.dart';
import 'package:mobile/data/dtos/set_campaign.dto.dart';
import 'package:mobile/data/dtos/set_donate.dto.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/modules/explore/explore.dart';

@lazySingleton
class CampaignDataSource {
  final DioHelper _dioHelper;

  CampaignDataSource({required DioHelper dioHelper}) : _dioHelper = dioHelper;

  Future<List<CampaignModel>> getCampaigns({
    SortType sortType = SortType.newest,
    LatLng? myLocation,
  }) async {
    var orderBy = '';
    switch (sortType) {
      case SortType.newest:
        orderBy = 'passed_ongoing_upcoming DESC';
        break;
      case SortType.nearest:
        orderBy = 'proximity ASC';
        break;
    }

    final response = await _dioHelper.get(
      myLocation == null
          ? '${Endpoints.campaigns}?orderBy=$orderBy'
          : '${Endpoints.campaigns}?orderBy=$orderBy&currentLat=${myLocation.latitude}&currentLng=${myLocation.longitude}',
    );
    return response.body
        .map<CampaignModel>((e) => CampaignModel.fromJson(e))
        .toList();
  }

  Future<List<CampaignModel>> searchCampaigns({
    String? province,
    String? district,
    String? ward,
    String? keyword,
  }) async {
    // bỏ 'Thành phố', 'Tỉnh', 'Quận', 'Huyện', 'Thị xã', 'Thị trấn', 'Phường', 'Xã'
    if (province != null) {
      province = province.replaceAll('Thành phố', '');
      province = province.replaceAll('Tỉnh', '');
      province = province.replaceAll('Quận', '');
      province = province.replaceAll('Huyện', '');
      province = province.replaceAll('Thị xã', '');
      province = province.replaceAll('Thị trấn', '');
      province = province.replaceAll('Phường', '');
      province = province.replaceAll('Xã', '');
    }
    if (district != null) {
      district = district.replaceAll('Thành phố', '');
      district = district.replaceAll('Tỉnh', '');
      district = district.replaceAll('Quận', '');
      district = district.replaceAll('Huyện', '');
      district = district.replaceAll('Thị xã', '');
      district = district.replaceAll('Thị trấn', '');
      district = district.replaceAll('Phường', '');
      district = district.replaceAll('Xã', '');
    }
    if (ward != null) {
      ward = ward.replaceAll('Thành phố', '');
      ward = ward.replaceAll('Tỉnh', '');
      ward = ward.replaceAll('Quận', '');
      ward = ward.replaceAll('Huyện', '');
      ward = ward.replaceAll('Thị xã', '');
      ward = ward.replaceAll('Thị trấn', '');
      ward = ward.replaceAll('Phường', '');
      ward = ward.replaceAll('Xã', '');
    }
    final response = await _dioHelper.get(
      '${Endpoints.campaigns}?${keyword.isNotNullOrEmpty ? 'name=${keyword?.trim()}' : ''}${province.isNotNullOrEmpty ? '&city=${province?.trim()}' : ''}${district.isNotNullOrEmpty ? '&district=${district?.trim()}' : ''}${ward.isNotNullOrEmpty ? '&ward=${ward?.trim()}' : ''}',
    );
    return response.body
        .map<CampaignModel>((e) => CampaignModel.fromJson(e))
        .toList();
  }

  Future<void> setCampaign(SetCampaignDTO setCampaignParams) async {
    await _dioHelper.post(
      '${Endpoints.campaignByOrganization}/${setCampaignParams.organizationId}/campaigns',
      formData: setCampaignParams.toJson(),
    );
  }

  Future<List<CampaignModel>> getCampaignsByLocation(
    LatLng wardLocation,
  ) async {
    final response = await _dioHelper.get(
      Endpoints.campaigns,
      queryParameters: {
        'lat': wardLocation.latitude,
        'lng': wardLocation.longitude,
      },
    );
    return response.body
        .map<CampaignModel>((e) => CampaignModel.fromJson(e))
        .toList();
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
    final response = await _dioHelper.get(
      '${Endpoints.campaigns}/$campaignId',
    );
    return CampaignModel.fromJson(response.body);
  }

  Future<void> joinCampaign(int campaignId) async {
    _dioHelper.post(
      '${Endpoints.campaigns}/$campaignId/volunteers',
    );
  }

  Future<void> organizationFeedback(OrganizationFeedbackDTO params) async {
    await _dioHelper.post(
      '${Endpoints.campaigns}/${params.campaignId}/feedbacks',
      formData: params.toJson(),
    );
  }

  Future<void> updateOrganizationFeedback(
    OrganizationFeedbackDTO params,
  ) async {
    await _dioHelper.put(
      '${Endpoints.campaigns}/${params.campaignId}/feedbacks',
      formData: params.toJson(),
    );
  }

  Future<void> participantFeedback(ParticipantFeedbackDTO params) async {
    await _dioHelper.post(
      '${Endpoints.campaigns}/${params.campaignId}/user-feedbacks',
      data: params.toJson(),
    );
  }

  Future<void> updateParticipantFeedback(ParticipantFeedbackDTO params) async {
    await _dioHelper.put(
      '${Endpoints.campaigns}/${params.campaignId}/user-feedbacks',
      data: params.toJson(),
    );
  }

  Future<void> donateToCampaign(SetDonateDTO params) async {
    await _dioHelper.post(
      '${Endpoints.campaigns}/${params.campaignId}/donations',
      formData: params.toJson(),
    );
  }

  Future<List<CampaignModel>> getOrgCapaigns(int id) async {
    final response = await _dioHelper.get(
      '${Endpoints.campaignByOrganization}/$id/campaigns',
    );
    return response.body
        .map<CampaignModel>((e) => CampaignModel.fromJson(e))
        .toList();
  }

  Future<List<CampaignModel>> getListVoluntaryCampaign() async {
    final response = await _dioHelper.get(
      Endpoints.myVoluntary,
    );
    return response.body
        .map<CampaignModel>((e) => CampaignModel.fromJson(e))
        .toList();
  }
}
