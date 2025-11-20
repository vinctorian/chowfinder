import 'package:chowfinder/data/domain/entity/get_restaurant_params_entity.dart';
import 'package:chowfinder/data/domain/entity/get_restaurants_entity.dart';
import 'package:chowfinder/data/domain/repository/restaraunts_repository.dart';

abstract class GetRestaurantsUsecase {
  Future<GetRestaurantEntity> call({required GetRestaurantParamsEntity params});
}

class GetRestaurantsUsecaseImpl extends GetRestaurantsUsecase {
  final RestaurantRepository repository;

  GetRestaurantsUsecaseImpl({required this.repository});

  @override
  Future<GetRestaurantEntity> call({
    required GetRestaurantParamsEntity params,
  }) {
    return repository.getRestaurants(
      radius: params.radius,
      types: params.includedTypes?.map((e) => e.name).toList(),
      rankPreference: params.rankPreference?.name,
      maxResults: params.maxResultCount,
    );
  }
}
