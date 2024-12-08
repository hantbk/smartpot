import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantapp/pages/micro/PlantSuggestionCard.dart';
import 'package:plantapp/pages/models/PlantSuggestion.dart';
import '../services/PlantIndentifyService.dart';
import '../services/ImageEncoder.dart';

class PlantIdentifyPage extends StatefulWidget {
  const PlantIdentifyPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlantIdentifyPageState createState() => _PlantIdentifyPageState();
}

class _PlantIdentifyPageState extends State<PlantIdentifyPage> {
  File? _imageFile;
  Uint8List? _imageBytes;
  String? _responseText;

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _imageFile = null;
          _imageBytes = bytes;
        });
      } else {
        setState(() {
          _imageFile = File(pickedFile.path);
          _imageBytes = null;
        });
      }
    }
  }
  // Future<void> sendRequest(String urlPath) async {
  //   if (_imageFile == null && _imageBytes == null) {
  //     _showErrorDialog("No image selected. Please select an image first.");
  //     return;
  //   }
  //     // Mã hóa ảnh và gửi tới API
  //     final String base64Image;
  //     if (kIsWeb) {
  //       base64Image = base64Encode(_imageBytes!);
  //     } else {
  //       base64Image = await ImageEncoder.encodeImageToBase64(_imageFile!);
  //     }
  //     final String indentifyPath =
  //         '/identification?details=common_names,url,description,taxonomy,synonyms,watering,best_light_condition,best_soil_type,common_uses,cultural_significance,toxicity,best_watering&language=en';
  //     final response =
  //         await PlantIdentifyService.identifyPlant(base64Image, indentifyPath);

  //     if (response != null) {
  //       final Map<String, dynamic> data = json.decode(response);
  //       final List<dynamic> suggestions =
  //           data['result']['classification']['suggestions'];
  //       final plantSuggestions = suggestions
  //           .map((suggestion) => PlantSuggestion.fromJson(suggestion))
  //           .toList();
  //       // final suggestionsCards = plantSuggestions.map((suggestion) {
  //       //   return PlantSuggestionCard(suggestion);
  //       // }).toList();
  //       _showSuggestionsDialog(plantSuggestions);
  //     } else {
  //       _showErrorDialog("An error occurred");
  //     }

  //     setState(() {
  //       _responseText = response != null
  //           ? "Finding successfull"
  //           : "Failed to identify plant.";
  //     });
  //   }
  // }
  Future<void> sendRequest(String urlPath) async {
    if (_imageFile == null && _imageBytes == null) {
      _showErrorDialog("No image selected. Please select an image first.");
      return;
    }

    final String base64Image;
    if (kIsWeb) {
      base64Image = base64Encode(_imageBytes!);
    } else {
      base64Image = await ImageEncoder.encodeImageToBase64(_imageFile!);
    }

    final response =
        await PlantIdentifyService.identifyPlant(base64Image, urlPath);

    if (response != null) {
      final Map<String, dynamic> data = json.decode(response);
      final List<dynamic> suggestions =
          data['result']['classification']['suggestions'];
      final plantSuggestions = suggestions
          .map((suggestion) => PlantSuggestion.fromJson(suggestion))
          .toList();
      _showSuggestionsDialog(plantSuggestions);
    } else {
      _showErrorDialog("Failed to identify the plant. Please try again.");
    }

    setState(() {
      _responseText =
          response != null ? "Request successful" : "Request failed.";
    });
  }

  void _showSuggestionsDialog(List<PlantSuggestion> suggestions) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: [
                // Tiêu đề của dialog
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Plant Suggestions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                // Danh sách các PlantSuggestionCard
                Expanded(
                  child: ListView.builder(
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      return PlantSuggestionCard(suggestions[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          content: Text("Failed to identify the plant. Please try again."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Identifier'),
        backgroundColor: const Color.fromRGBO(161, 207, 107, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageBytes != null && kIsWeb)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.memory(
                  _imageBytes!,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              )
            else if (_imageFile != null && !kIsWeb)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  _imageFile!,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              )
            else
              Column(
                children: const [
                  Icon(Icons.image_not_supported,
                      size: 100, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    'No image selected.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _responseText != null
                    ? Text(
                        'Response: $_responseText',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      )
                    : const Text(
                        'Identify a plant to see response.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
