class RestaurantModel {
  final String displayName;
  final String formattedAddress;
  final String? websiteUri;
  final double? rating;
  final int? userRatingCount;
  final String? openingHours;
  final String? placeId;
  RestaurantModel({
    required this.displayName,
    required this.formattedAddress,
    this.placeId,
    this.websiteUri,
    this.rating,
    this.userRatingCount,
    this.openingHours,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      displayName: json['displayName']["text"],
      formattedAddress: json['formattedAddress'],
      websiteUri: json['websiteUri'],
      rating: (json['rating'] != null)
          ? (json['rating'] as num).toDouble()
          : null,
      userRatingCount: json['userRatingCount'],
    );
  }
}
