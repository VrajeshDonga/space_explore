import 'package:flutter/material.dart';
import 'package:space_explore/service/nasa_service.dart';

class ApodProvider with ChangeNotifier {
  Map<String, dynamic>? _apodData;
  bool _isLoading = true;

  Map<String, dynamic>? get apodData => _apodData;

  bool get isLoading => _isLoading;

  final NasaService _nasaService = NasaService();

  Future<void> fetchAPOD() async {
    _isLoading = true;
    notifyListeners();

    try {
      _apodData = await _nasaService.fetchAPOD();
    } catch (e) {
      _apodData = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
