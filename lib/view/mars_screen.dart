import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:space_explore/provider/favorites_provider.dart';
import 'package:space_explore/service/mars_rover_service.dart';

class MarsScreen extends StatefulWidget {
  const MarsScreen({super.key});

  @override
  _MarsScreenState createState() => _MarsScreenState();
}

class _MarsScreenState extends State<MarsScreen> {
  final MarsRoverService _marsRoverService = MarsRoverService();
  List<dynamic> marsPhotos = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final photos = await _marsRoverService.fetchMarsPhotos(sol: 1000, );
      setState(() {
        marsPhotos = photos;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to fetch Mars Rover photos. Please try again.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mars Photos'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: fetchPhotos,
              child: const Text('Retry'),
            ),
          ],
        ),
      )
          : marsPhotos.isEmpty
          ? const Center(child: Text('No photos available'))
          : ListView.builder(
        itemCount: marsPhotos.length,
        itemBuilder: (context, index) {
          final photo = marsPhotos[index];
          final photoId = photo['id'].toString();
          final isFavorite =
          favoritesProvider.isFavorite(photoId);

          return ListTile(
            leading: Image.network(photo['img_src']),
            title: Text('Rover: ${photo['rover']['name']}'),
            subtitle:
            Text('Camera: ${photo['camera']['full_name']}'),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                if (isFavorite) {
                  favoritesProvider.removeFavorite(photoId);
                } else {
                  favoritesProvider.addFavorite(photoId, photo);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
