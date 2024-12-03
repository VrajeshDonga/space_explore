import 'package:flutter/material.dart';
import 'package:space_explore/service/mars_rover_service.dart';

class MarsRoverProvider with ChangeNotifier {
  final MarsRoverService _marsRoverService = MarsRoverService();
  List<dynamic> _photos = [];
  bool _isLoading = true;

  List<dynamic> get photos => _photos;

  bool get isLoading => _isLoading;

  Future<void> fetchPhotos(
      {required String rover, required int sol, String? camera}) async {
    _isLoading = true;
    notifyListeners();

    try {
      _photos = await _marsRoverService.fetchMarsPhotos(
           sol: sol, camera: camera);
    } catch (e) {
      _photos = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
