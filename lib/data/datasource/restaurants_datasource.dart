import 'dart:async';

import 'package:chowfinder/core/network_client.dart';
import 'package:chowfinder/data/datasource/model/get_restaurant_reponse_model.dart';

abstract class GetRestaurantsDataSource {
  final NetworkClient network;

  GetRestaurantsDataSource({required this.network});

  Future<GetRestaurantResponseModel> getRestaurants({
    required double radius,
    List<String>? types,
    String? rankPreference,
    int? maxResults,
  });
}

class GetRestaurantsDataSourceImpl extends GetRestaurantsDataSource {
  GetRestaurantsDataSourceImpl({required super.network});
  final String basePath = '/v1/places:';
  final String nearbyPath = 'searchNearby';

  @override
  Future<GetRestaurantResponseModel> getRestaurants({
    required double radius,
    List<String>? types,
    String? rankPreference,
    int? maxResults,
  }) async {
    try {
      final response = await network.post(
        '$basePath$nearbyPath',
        data: {
          'locationRestriction': {
            "circle": {
              "center": {"latitude": 43.659642, "longitude": -79.400764},
              "radius": radius,
            },
          },
          if (types != null) 'includedTypes': types,
          if (rankPreference != null) 'rankPreference': rankPreference,
          if (maxResults != null) 'maxResultCount': maxResults,
        },
      );
      final data = response.data;
      if (response.statusCode == 200 && data != null) {
        return GetRestaurantSuccessResponseModel.fromJson(data);
      } else {
        return GetRestaurantErrorResponseModel(
          message: 'Failed to fetch restaurants',
        );
      }
    } catch (e) {
      return GetRestaurantErrorResponseModel(message: 'Error occurred: $e');
    }
  }
}
