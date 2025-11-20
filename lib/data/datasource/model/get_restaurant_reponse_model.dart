import 'package:chowfinder/data/datasource/model/restaurant_model.dart';

sealed class GetRestaurantResponseModel {}

final class GetRestaurantSuccessResponseModel
    extends GetRestaurantResponseModel {
  final List<RestaurantModel> restaurants;

  GetRestaurantSuccessResponseModel({required this.restaurants});

  factory GetRestaurantSuccessResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final places = json['places'] as List<dynamic>? ?? [];
    final restaurants = places
        .map((e) => RestaurantModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return GetRestaurantSuccessResponseModel(restaurants: restaurants);
  }
}

final class GetRestaurantErrorResponseModel extends GetRestaurantResponseModel {
  final String message;

  GetRestaurantErrorResponseModel({required this.message});
}
