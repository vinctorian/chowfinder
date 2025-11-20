import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chowfinder/data/domain/entity/get_restaurant_params_entity.dart';
import 'package:chowfinder/data/domain/entity/get_restaurants_entity.dart';
import 'package:chowfinder/data/domain/entity/place_types_enum.dart';
import 'package:chowfinder/data/domain/entity/rank_preference_enum.dart';
import 'package:chowfinder/data/domain/entity/restaurant_entity.dart';
import 'package:chowfinder/data/domain/usecase/get_restaurants_usecase.dart';
import 'package:meta/meta.dart';

part 'restaurant_list_event.dart';
part 'restaurant_list_state.dart';

class RestaurantListBloc
    extends Bloc<RestaurantListEvent, RestaurantListState> {
  final GetRestaurantsUsecase usecase;
  RestaurantListBloc({required this.usecase}) : super(RestaurantListInitial()) {
    on<LoadListEvent>(_loadList);
    on<AddTypeEvent>(_addPlaceType);
  }

  void _loadList(LoadListEvent event, Emitter<RestaurantListState> emit) async {
    final currentState = state;
    emit(RestaurantLoadingState());
    final response = await usecase.call(
      params: GetRestaurantParamsEntity(
        radius: event.radius,
        includedTypes: currentState.includedTypes,
        maxResultCount: currentState.maxResultCount,
        rankPreference: currentState.rankPreference,
      ),
    );

    emit(switch (response) {
      GetRestaurantSuccessEntity() => RestaurantLoadedState(
        restaurants: response.restaurants,
        maxResultCount: currentState.maxResultCount,
        includedTypes: currentState.includedTypes,
        rankPreference: currentState.rankPreference,
      ),
      GetRestaurantErrorEntity() => RestaurantErrorState(
        maxResultCount: currentState.maxResultCount,
        includedTypes: currentState.includedTypes,
        rankPreference: currentState.rankPreference,
      ),
    });
  }

  FutureOr<void> _addPlaceType(
    AddTypeEvent event,
    Emitter<RestaurantListState> emit,
  ) {
    final currentState = state;
    if (currentState is RestaurantLoadedState) {
      final types = currentState.includedTypes;
      if (types != null && !types.contains(event.type)) {
        types.add(event.type);
        emit(
          FilterUpdatedState(
            restaurants: currentState.restaurants,
            includedTypes: currentState.includedTypes,
            maxResultCount: currentState.maxResultCount,
            rankPreference: currentState.rankPreference,
          ),
        );
      } else if (types != null && types.contains(event.type)) {
        types.removeWhere((item) => item.name == event.type.name);
        emit(
          FilterUpdatedState(
            restaurants: currentState.restaurants,
            includedTypes: currentState.includedTypes,
            maxResultCount: currentState.maxResultCount,
            rankPreference: currentState.rankPreference,
          ),
        );
      } else {
        List<PlaceTypeEnum> list = [event.type];
        emit(currentState.copyWith(includedTypes: list));
      }
    }
  }
}
