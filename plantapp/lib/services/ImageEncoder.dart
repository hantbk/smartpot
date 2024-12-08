import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageEncoder {
  static Future<String> encodeImageToBase64(File imageFile) async {
    final compressedImage = await FlutterImageCompress.compressWithFile(
      imageFile.path,
    );

    return base64Encode(compressedImage!);
  }
}
