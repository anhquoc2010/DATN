import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/common/constants/constants.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/utils/toast.util.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/map/bloc/bottom_sheet_bloc/map_bottom_sheet.bloc.dart';
import 'package:mobile/modules/map/bloc/map/map.bloc.dart';
import 'package:mobile/modules/map/widgets/map_bottom_sheet.widget.dart';
import 'package:mobile/modules/map/widgets/map_search_button.widget.dart';

class MapPage extends StatelessWidget {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapBottomsheetBloc(
        campaignRepository: getIt.get<CampaignRepository>(),
      ),
      child: BlocListener<MapBloc, MapState>(
        listener: (context, state) => _listenMapStateChanged(context, state),
        child: _MapView(
          controller: _controller,
        ),
      ),
    );
  }

  Future<void> _listenMapStateChanged(
    BuildContext context,
    MapState state,
  ) async {
    if (state.error != null && context.mounted) {
      ToastUtil.showError(
        context,
        text: state.error,
      );
    }

    if (state is MapGetLocationSuccess) {
      final controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: state.myLocation ?? defaultLocation,
            zoom: 9,
          ),
        ),
      );
    }
  }
}

class _MapView extends StatelessWidget {
  final Completer<GoogleMapController> controller;

  const _MapView({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.home_search.tr(),
        bottom: const MapSearchButtonWidget(),
        toolbarHeight: kToolbarHeight + 60,
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return SizedBox(
            height: context.height,
            width: context.width,
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: defaultLocation,
                zoom: 5,
              ),
              onMapCreated: (gController) {
                controller.complete(gController);
                context.read<MapBloc>().add(const MapMarkersGet());
              },
              padding: Platform.isAndroid
                  ? EdgeInsets.only(
                      top: context.height * 0.2,
                    )
                  : EdgeInsets.only(
                      bottom: context.height * 0.15,
                    ),
              myLocationEnabled: true,
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              buildingsEnabled: false,
              markers: state.markers
                      ?.map(
                        (e) => Marker(
                          markerId: e.markerId,
                          position: e.position,
                          onTap: () {
                            _onClickMarker(context, e.position);
                          },
                        ),
                      )
                      .toSet() ??
                  const {},
            ),
          );
        },
      ),
    );
  }

  void _onClickMarker(BuildContext context, LatLng wardLocation) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      builder: (ccontext) {
        return BlocProvider.value(
          value: context.read<MapBottomsheetBloc>()
            ..add(MapBottomSheetGetCampaigns(wardLocation: wardLocation)),
          child: const CampaignBottomSheet(),
        );
      },
    );
  }
}
