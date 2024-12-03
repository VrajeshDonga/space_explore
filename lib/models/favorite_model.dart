import 'package:hive/hive.dart';

part 'favorite_model.g.dart';

@HiveType(typeId: 0)
class FavoriteModel extends HiveObject {
  @HiveField(0)
  final String type; // "APOD", "Mars", or "Earth"

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final String? extraData; // Additional info like coordinates or rover name

  FavoriteModel({
    required this.type,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.extraData,
  });
}
