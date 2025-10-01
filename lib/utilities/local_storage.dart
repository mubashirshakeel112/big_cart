import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ImageStorage {
  // Save image as Base64 String
  Future<void> saveImage(File imageFile) async {
    final prefs = await SharedPreferences.getInstance();
    final bytes = await imageFile.readAsBytes(); // read image as bytes
    final base64String = base64Encode(bytes); // convert to base64 string
    await prefs.setString("saved_image", base64String);
  }

  // Load image back as File (from Base64 String)
  Future<File?> loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final base64String = prefs.getString("saved_image");

    if (base64String == null) return null;

    final bytes = base64Decode(base64String);

    // Create temp file from bytes
    final tempDir = Directory.systemTemp;
    final file = await File('${tempDir.path}/temp_image.png').writeAsBytes(bytes);
    return file;
  }

  // Remove stored image
  Future<void> removeImage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("saved_image");
  }
}
