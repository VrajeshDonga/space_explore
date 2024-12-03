import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:space_explore/models/favorite_model.dart';
import 'package:space_explore/view/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Register the adapter
  Hive.registerAdapter(FavoriteModelAdapter());

  // Open the box with the type
  final favoritesBox = await Hive.openBox<FavoriteModel>('favorites');
  await dotenv.load(fileName: ".env");
  runApp( MyApp(favoritesBox: favoritesBox,));
}