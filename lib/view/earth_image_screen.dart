import 'package:flutter/material.dart';
import 'package:space_explore/service/earth_image_service.dart';

class EarthImageScreen extends StatefulWidget {
  const EarthImageScreen({super.key});

  @override
  State<EarthImageScreen> createState() => _EarthImageScreenState();
}

class _EarthImageScreenState extends State<EarthImageScreen> {
  final EarthImageService _service = EarthImageService();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lonController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String? _imageUrl;

  Future<void> _fetchImage() async {
    final lat = double.tryParse(_latController.text);
    final lon = double.tryParse(_lonController.text);

    if (lat == null || lon == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter valid latitude and longitude')),
      );
      return;
    }

    final url = await _service.fetchEarthImage(
      lat: lat,
      lon: lon,
      date: _selectedDate.toIso8601String(),
    );

    setState(() {
      _imageUrl = url;
    });
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Earth Imagery')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _latController,
              decoration: const InputDecoration(labelText: 'Latitude'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _lonController,
              decoration: const InputDecoration(labelText: 'Longitude'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickDate,
                  child: Text(
                      'Pick Date: ${_selectedDate.toLocal()}'.split(' ')[0]),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _fetchImage,
                  child: const Text('Fetch Image'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _imageUrl != null
                ? Expanded(child: Image.network(_imageUrl!, fit: BoxFit.cover))
                : const Text('No image to display'),
          ],
        ),
      ),
    );
  }
}
