import 'package:chowfinder/core/network_client.dart';
import 'package:chowfinder/data/datasource/restaurants_datasource.dart';
import 'package:chowfinder/data/domain/repository/restaraunts_repository.dart';
import 'package:chowfinder/data/domain/usecase/get_restaurants_usecase.dart';
import 'package:get_it/get_it.dart';

class Injector {
  Injector._();

  static final Injector instance = Injector._();
  static final GetIt getIt = GetIt.instance;

  void init() {
    getIt.registerLazySingleton<NetworkClient>(() => NetworkClient());

    getIt.registerFactory<GetRestaurantsDataSource>(
      () => GetRestaurantsDataSourceImpl(network: getIt()),
    );

    getIt.registerFactory<RestaurantRepository>(
      () => RestaurantRepositoryImpl(dataSource: getIt()),
    );

    getIt.registerFactory<GetRestaurantsUsecase>(
      () => GetRestaurantsUsecaseImpl(repository: getIt()),
    );
  }

  static T get<T extends Object>() => getIt<T>();
}
