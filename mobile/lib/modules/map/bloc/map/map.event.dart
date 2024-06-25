part of 'map.bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

final class _MapsLocationPermissionGrand extends MapEvent {}

final class MapsLocationGet extends MapEvent {}

class MapMarkersGet extends MapEvent {
  const MapMarkersGet();

  @override
  List<Object?> get props => [];
}

class MapProjectsGet extends MapEvent {
  const MapProjectsGet();

  @override
  List<Object?> get props => [];
}
