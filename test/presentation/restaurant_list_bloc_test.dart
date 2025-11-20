import 'package:chowfinder/data/domain/entity/get_restaurants_entity.dart';
import 'package:chowfinder/presentation/pages/bloc/restaurant_list_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../init.mocks.dart';

void main() {
  late MockGetRestaurantsUsecase usecase;

  setUp(() {
    usecase = MockGetRestaurantsUsecase();
    provideDummy<GetRestaurantEntity>(
      GetRestaurantSuccessEntity(restaurants: []),
    );
  });

  blocTest<RestaurantListBloc, RestaurantListState>(
    "s",
    build: () => RestaurantListBloc(usecase: usecase),
    seed: () => RestaurantListInitial(),

    setUp: () {
      when(
        usecase.call(params: anyNamed("params")),
      ).thenAnswer((_) async => GetRestaurantSuccessEntity(restaurants: []));
    },
    act: (bloc) => bloc.add(LoadListEvent(radius: 1)),
    expect: () => [isA<RestaurantLoadingState>(), isA<RestaurantLoadedState>()],
  );
}
