import 'package:chowfinder/data/domain/entity/restaurant_entity.dart';

sealed class GetRestaurantEntity {}

class GetRestaurantSuccessEntity extends GetRestaurantEntity {
  final List<RestaurantEntity> restaurants;

  GetRestaurantSuccessEntity({required this.restaurants});
}

class GetRestaurantErrorEntity extends GetRestaurantEntity {
  final String message;

  GetRestaurantErrorEntity({required this.message});
}
