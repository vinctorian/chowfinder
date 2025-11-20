import 'package:chowfinder/data/datasource/model/get_restaurant_reponse_model.dart';
import 'package:chowfinder/data/datasource/model/restaurant_model.dart';
import 'package:chowfinder/data/datasource/restaurants_datasource.dart';
import 'package:chowfinder/data/domain/entity/get_restaurants_entity.dart';
import 'package:chowfinder/data/domain/entity/restaurant_entity.dart';

abstract class RestaurantRepository {
  Future<GetRestaurantEntity> getRestaurants({
    required double radius,
    List<String>? types,
    String? rankPreference,
    int? maxResults,
  });
}

class RestaurantRepositoryImpl extends RestaurantRepository {
  final GetRestaurantsDataSource dataSource;

  RestaurantRepositoryImpl({required this.dataSource});

  @override
  Future<GetRestaurantEntity> getRestaurants({
    required double radius,
    List<String>? types,
    String? rankPreference,
    int? maxResults,
  }) async {
    return switch (await dataSource.getRestaurants(
      radius: radius,
      types: types,
      rankPreference: rankPreference,
      maxResults: maxResults,
    )) {
      GetRestaurantSuccessResponseModel(:final restaurants) =>
        GetRestaurantSuccessEntity(
          restaurants: restaurants.map((e) => _mapToEntity(e)).toList(),
        ),
      GetRestaurantErrorResponseModel(:final message) =>
        GetRestaurantErrorEntity(message: message),
    };
  }

  RestaurantEntity _mapToEntity(RestaurantModel model) {
    return RestaurantEntity(
      displayName: model.displayName,
      formattedAddress: model.formattedAddress,
      placeId: model.placeId,
      rating: model.rating,
      userRatingCount: model.userRatingCount,
      openingHours: model.openingHours,
      websiteUri: model.websiteUri,
    );
  }
}
