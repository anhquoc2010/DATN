import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/generated/locale_keys.g.dart';

part 'explore.event.dart';
part 'explore.state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final CampaignRepository _repository;
  final Location _location;

  ExploreBloc({
    required CampaignRepository repository,
    required Location location,
  })  : _repository = repository,
        _location = location,
        super(const ExploreState()) {
    on<ExploreEvent>((event, emit) {});
    on<ExploreListCampainsGet>(_getHomeList);
    on<ExploreSortTypeChange>(_changeSortType);
    add(ExploreListCampainsGet());
  }
  Future<void> _getHomeList(
    ExploreListCampainsGet event,
    Emitter<ExploreState> emitter,
  ) async {
    emitter(
      ExploreState.loading(
        sortType: state.sortType,
        myLocation: state.myLocation,
      ),
    );
    final result = await _repository.getCampaigns(
      sortType: state.sortType ?? SortType.newest,
      myLocation: state.myLocation,
    );
    emitter(
      ExploreState.getSuccess(
        campaigns: result,
        sortType: state.sortType,
        myLocation: state.myLocation,
      ),
    );
  }

  Future<void> _changeSortType(
    ExploreSortTypeChange event,
    Emitter<ExploreState> emitter,
  ) async {
    final locationData = await _location.getLocation();
    emitter(
      state.copyWith(
        sortType: event.sortType,
        myLocation: LatLng(
          locationData.latitude!,
          locationData.longitude!,
        ),
      ),
    );

    add(ExploreListCampainsGet());
  }
}
