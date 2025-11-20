import 'package:chowfinder/data/domain/entity/place_types_enum.dart';
import 'package:chowfinder/data/domain/entity/rank_preference_enum.dart';

class GetRestaurantParamsEntity {
  final double radius;
  final List<PlaceTypeEnum>? includedTypes;
  final RankPreferenceEnum? rankPreference;
  final int? maxResultCount;

  GetRestaurantParamsEntity({
    required this.radius,
    this.includedTypes,
    this.rankPreference,
    this.maxResultCount,
  });
}
