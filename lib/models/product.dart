import 'dart:io';
import 'location.dart';

class Product {
  final String id;
  final String deviceCondition;
  final String listedBy;
  final String deviceStorage;
  final List<File> images;
  final File defaultImage;
  final String listingState;
  final String listingLocation;
  final String listingLocality;
  final String listingPrice;
  final String make;
  final String marketingName;
  final bool openForNegotiation;
  final double? discountPercentage;
  final bool verified;
  final String listingId;
  final String status;
  final String verifiedDate;
  final String listingDate;
  final String deviceRam;
  final String warranty;
  final String imagePath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Location location;
  final int? originalPrice;
  final int? discountedPrice;

  Product({
    required this.id,
    required this.deviceCondition,
    required this.listedBy,
    required this.deviceStorage,
    required this.images,
    required this.defaultImage,
    required this.listingState,
    required this.listingLocation,
    required this.listingLocality,
    required this.listingPrice,
    required this.make,
    required this.marketingName,
    required this.openForNegotiation,
    this.discountPercentage,
    required this.verified,
    required this.listingId,
    required this.status,
    required this.verifiedDate,
    required this.listingDate,
    required this.deviceRam,
    required this.warranty,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
    required this.location,
    this.originalPrice,
    this.discountedPrice,
  });

  // Factory method to create a Product from a map (e.g. from JSON)
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      deviceCondition: map['deviceCondition'] ?? '',
      listedBy: map['listedBy'] ?? '',
      deviceStorage: map['deviceStorage'] ?? '',
      images: List<File>.from(
        (map['images'] as List)
            .map((x) => File(x['thumbImage']?.toString() ?? '')) ??
            [],
      ),
      // Fix for defaultImage (now it's a map with 'fullImage')
      defaultImage: File(map['defaultImage']?['fullImage']?.toString() ?? ''),
      listingState: map['listingState'] ?? '',
      listingLocation: map['listingLocation'] ?? '',
      listingLocality: map['listingLocality'] ?? '',
      listingPrice: map['listingPrice'] ?? '',
      make: map['make'] ?? '',
      marketingName: map['marketingName'] ?? '',
      openForNegotiation: map['openForNegotiation'] ?? false,
      discountPercentage: map['discountPercentage']?.toDouble(),
      verified: map['verified'] ?? false,
      listingId: map['listingId'] ?? '',
      status: map['status'] ?? '',
      verifiedDate: map['verifiedDate'] ?? '',
      listingDate: map['listingDate'] ?? '',
      deviceRam: map['deviceRam'] ?? '',
      warranty: map['warranty'] ?? '',
      imagePath: map['imagePath'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      location: Location.fromMap(map['location']),
      originalPrice: map['originalPrice'],
      discountedPrice: map['discountedPrice'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'deviceCondition': deviceCondition,
      'listedBy': listedBy,
      'deviceStorage': deviceStorage,
      'images': images.map((x) => {'thumbImage': x.path}).toList(),
      'defaultImage': {'fullImage': defaultImage.path},
      'listingState': listingState,
      'listingLocation': listingLocation,
      'listingLocality': listingLocality,
      'listingPrice': listingPrice,
      'make': make,
      'marketingName': marketingName,
      'openForNegotiation': openForNegotiation,
      'discountPercentage': discountPercentage,
      'verified': verified,
      'listingId': listingId,
      'status': status,
      'verifiedDate': verifiedDate,
      'listingDate': listingDate,
      'deviceRam': deviceRam,
      'warranty': warranty,
      'imagePath': imagePath,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'location': location.toMap(),
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
    };
  }
}
