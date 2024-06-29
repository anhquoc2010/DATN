part of 'explore.bloc.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();

  @override
  List<Object> get props => [];
}

class ExploreListCampainsGet extends ExploreEvent {}

class ExploreSortTypeChange extends ExploreEvent {
  final SortType sortType;
  final LatLng? myLocation;

  const ExploreSortTypeChange(this.sortType, {this.myLocation});

  @override
  List<Object> get props => [sortType];
}
