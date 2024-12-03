import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_explore/provider/favorites_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: ListView.builder(
        itemCount: favoritesProvider.allFavorites.length,
        itemBuilder: (context, index) {
          final item = favoritesProvider.allFavorites[index];
          return ListTile(
            leading: Image.network(item['photoUrl']),
            title: Text(item['photoId']),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                favoritesProvider.removeFavorite(item['photoId']);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Removed from Favorites')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
