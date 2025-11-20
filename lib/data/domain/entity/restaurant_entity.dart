class RestaurantEntity {
  final String displayName;
  final String formattedAddress;
  final String? websiteUri;
  final double? rating;
  final int? userRatingCount;
  final String? openingHours;
  final String? placeId;

  RestaurantEntity({
    required this.displayName,
    required this.formattedAddress,
    this.placeId,
    this.websiteUri,
    this.rating,
    this.userRatingCount,
    this.openingHours,
  });
}
