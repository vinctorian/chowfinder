part of 'restaurant_list_bloc.dart';

@immutable
sealed class RestaurantListState {
  final List<PlaceTypeEnum>? includedTypes;
  final RankPreferenceEnum? rankPreference;
  final int? maxResultCount;

  RestaurantListState({
    this.includedTypes,
    this.rankPreference,
    this.maxResultCount,
  });

  RestaurantListState copyWith({
    List<PlaceTypeEnum>? includedTypes,
    RankPreferenceEnum? rankPreference,
    int? maxResultCount,
  });
}

final class RestaurantListInitial extends RestaurantListState {
  RestaurantListInitial({
    super.includedTypes,
    super.maxResultCount,
    super.rankPreference,
  });

  @override
  RestaurantListState copyWith({
    List<PlaceTypeEnum>? includedTypes,
    RankPreferenceEnum? rankPreference,
    int? maxResultCount,
  }) {
    return RestaurantListInitial(
      includedTypes: includedTypes ?? this.includedTypes,
      rankPreference: rankPreference ?? this.rankPreference,
      maxResultCount: maxResultCount ?? this.maxResultCount,
    );
  }
}

final class RestaurantLoadingState extends RestaurantListState {
  RestaurantLoadingState({
    super.includedTypes,
    super.maxResultCount,
    super.rankPreference,
  });

  @override
  RestaurantListState copyWith({
    List<PlaceTypeEnum>? includedTypes,
    RankPreferenceEnum? rankPreference,
    int? maxResultCount,
  }) {
    return RestaurantLoadingState(
      includedTypes: includedTypes ?? this.includedTypes,
      rankPreference: rankPreference ?? this.rankPreference,
      maxResultCount: maxResultCount ?? this.maxResultCount,
    );
  }
}

final class RestaurantLoadedState extends RestaurantListState {
  final List<RestaurantEntity> restaurants;

  RestaurantLoadedState({
    required this.restaurants,
    super.includedTypes,
    super.maxResultCount,
    super.rankPreference,
  });

  @override
  RestaurantListState copyWith({
    List<RestaurantEntity>? restaurants,
    List<PlaceTypeEnum>? includedTypes,
    RankPreferenceEnum? rankPreference,
    int? maxResultCount,
  }) {
    return RestaurantLoadedState(
      restaurants: restaurants ?? this.restaurants,
      includedTypes: includedTypes ?? this.includedTypes,
      rankPreference: rankPreference ?? this.rankPreference,
      maxResultCount: maxResultCount ?? this.maxResultCount,
    );
  }
}

final class FilterUpdatedState extends RestaurantLoadedState {
  FilterUpdatedState({
    required super.restaurants,
    super.includedTypes,
    super.maxResultCount,
    super.rankPreference,
  });

  @override
  FilterUpdatedState copyWith({
    List<RestaurantEntity>? restaurants,
    List<PlaceTypeEnum>? includedTypes,
    RankPreferenceEnum? rankPreference,
    int? maxResultCount,
  }) {
    return FilterUpdatedState(
      restaurants: restaurants ?? this.restaurants,
      includedTypes: includedTypes ?? this.includedTypes,
      rankPreference: rankPreference ?? this.rankPreference,
      maxResultCount: maxResultCount ?? this.maxResultCount,
    );
  }
}

final class RestaurantErrorState extends RestaurantListState {
  RestaurantErrorState({
    super.includedTypes,
    super.maxResultCount,
    super.rankPreference,
  });

  @override
  RestaurantListState copyWith({
    List<PlaceTypeEnum>? includedTypes,
    RankPreferenceEnum? rankPreference,
    int? maxResultCount,
  }) {
    return RestaurantErrorState(
      includedTypes: includedTypes ?? this.includedTypes,
      rankPreference: rankPreference ?? this.rankPreference,
      maxResultCount: maxResultCount ?? this.maxResultCount,
    );
  }
}
