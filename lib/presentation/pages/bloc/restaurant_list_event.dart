part of 'restaurant_list_bloc.dart';

@immutable
sealed class RestaurantListEvent {}

class LoadListEvent extends RestaurantListEvent {
  final double radius;
  final List<PlaceTypeEnum>? includedTypes;
  final List<RankPreferenceEnum>? rankPreference;
  final int? maxResultCount;

  LoadListEvent({
    required this.radius,
    this.includedTypes,
    this.rankPreference,
    this.maxResultCount,
  });
}

class AddTypeEvent extends RestaurantListEvent {
  final PlaceTypeEnum type;
  AddTypeEvent({required this.type});
}

class AddRankEvent extends RestaurantListEvent {
  final RankPreferenceEnum rank;
  AddRankEvent({required this.rank});
}
