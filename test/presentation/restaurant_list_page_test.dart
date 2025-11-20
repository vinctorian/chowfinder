import 'package:chowfinder/core/injector.dart';
import 'package:chowfinder/core/network_client.dart';
import 'package:chowfinder/data/datasource/restaurants_datasource.dart';
import 'package:chowfinder/data/domain/entity/get_restaurants_entity.dart';
import 'package:chowfinder/data/domain/entity/restaurant_entity.dart';
import 'package:chowfinder/data/domain/repository/restaraunts_repository.dart';
import 'package:chowfinder/data/domain/usecase/get_restaurants_usecase.dart';
import 'package:chowfinder/presentation/pages/bloc/restaurant_list_bloc.dart';
import 'package:chowfinder/presentation/pages/restaurant_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../init.mocks.dart';

void main() {
  late MockGetRestaurantsUsecase usecase;

  setUp(() {
    Injector.getIt.registerLazySingleton<NetworkClient>(
      () => MockNetworkClient(),
    );
    Injector.getIt.registerLazySingleton<GetRestaurantsDataSource>(
      () => MockGetRestaurantsDataSource(),
    );
    Injector.getIt.registerLazySingleton<RestaurantRepository>(
      () => MockRestaurantRepository(),
    );
    Injector.getIt.registerLazySingleton<GetRestaurantsUsecase>(
      () => MockGetRestaurantsUsecase(),
    );
    usecase = MockGetRestaurantsUsecase();

    provideDummy<GetRestaurantEntity>(
      GetRestaurantSuccessEntity(
        restaurants: [
          RestaurantEntity(displayName: "test", formattedAddress: "test"),
        ],
      ),
    );
  });

  testWidgets("smoketest", (WidgetTester tester) async {
    when(usecase.call(params: anyNamed("params"))).thenAnswer(
      (_) async => GetRestaurantSuccessEntity(
        restaurants: [
          RestaurantEntity(displayName: "test", formattedAddress: "test"),
        ],
      ),
    );
    final Widget testable = BlocProvider(
      create: (context) => RestaurantListBloc(usecase: usecase),
      child: RestaurantListPage(radius: 1),
    );

    await tester.pumpWidget(MaterialApp(home: testable));

    await tester.pumpAndSettle();
    expect(find.text("test"), findsWidgets);
  });
}
