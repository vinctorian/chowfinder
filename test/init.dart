import 'package:chowfinder/core/injector.dart';
import 'package:chowfinder/core/network_client.dart';
import 'package:chowfinder/data/datasource/restaurants_datasource.dart';
import 'package:chowfinder/data/domain/repository/restaraunts_repository.dart';
import 'package:chowfinder/data/domain/usecase/get_restaurants_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'init.mocks.dart';

// Generate mocks
@GenerateNiceMocks([
  MockSpec<NetworkClient>(),
  MockSpec<GetRestaurantsDataSource>(),
  MockSpec<RestaurantRepository>(),
  MockSpec<GetRestaurantsUsecase>(),
])
void main() {
  setUp(() {
    Injector.getIt.reset();
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
  });

  test("Injector provides mock network client", () {
    final network = Injector.get<NetworkClient>();
    expect(network, isA<MockNetworkClient>());
  });
}
