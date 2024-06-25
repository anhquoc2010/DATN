import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/data/repositories/place.repository.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:location/location.dart';

part 'map.state.dart';
part 'map.event.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final PlaceRepository _placeRepository;
  final Location _location;

  MapBloc({
    required PlaceRepository placeRepository,
    required Location location,
  })  : _placeRepository = placeRepository,
        _location = location,
        super(
          const MapState.initial(),
        ) {
    on<_MapsLocationPermissionGrand>(_onGrandLocationPermission);
    on<MapsLocationGet>(_onGetLocation);
    on<MapMarkersGet>(_onGetMarkers);
    add(_MapsLocationPermissionGrand());
    add(const MapMarkersGet());
  }

  Future<void> _onGrandLocationPermission(
    _MapsLocationPermissionGrand event,
    Emitter<MapState> emit,
  ) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        emit(
          state.copyWith(
            error: LocaleKeys.map_location_error.tr(),
          ),
        );
        return;
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        emit(
          state.copyWith(
            error: LocaleKeys.map_location_error.tr(),
          ),
        );
        return;
      }
    }

    add(MapsLocationGet());
  }

  Future<void> _onGetLocation(
    MapsLocationGet event,
    Emitter<MapState> emit,
  ) async {
    try {
      final locationData = await _location.getLocation();
      emit(
        state.copyWith(
          myLocation: LatLng(
            locationData.latitude!,
            locationData.longitude!,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _onGetMarkers(
    MapMarkersGet event,
    Emitter<MapState> emiiter,
  ) async {
    try {
      final response = await _placeRepository.getCoordinates();
      emiiter(
        state.copyWith(
          markers: response
              .map(
                (e) => Marker(
                  markerId: MarkerId(e.id.toString()),
                  position: LatLng(e.coordinate!.lat, e.coordinate!.lng),
                ),
              )
              .toSet(),
        ),
      );
    } catch (e) {
      log('Error in get markers');
      emiiter(
        state.copyWith(
          error: LocaleKeys.map_error_get_markers.tr(),
        ),
      );
    }
  }
}
