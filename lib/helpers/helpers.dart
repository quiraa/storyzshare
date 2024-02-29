import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

import 'package:intl/intl.dart';

class Helpers {
  static String formatDate(String rawDate) {
    DateTime dateTime = DateTime.parse(rawDate);
    final DateFormat formatter = DateFormat('EEEE, d MMM yyyy HH:mm:ss');
    return formatter.format(dateTime);
  }

  // static Future<Uint8List> compressImage(File imageFile) async {
  //   List<int> imageBytes = await imageFile.readAsBytes();

  //   img.Image? image = img.decodeImage(Uint8List.fromList(imageBytes));

  //   if (image != null && image.lengthInBytes > 1024 * 1024) {
  //     double scale = 1024 * 1024 / image.lengthInBytes;

  //     img.Image compressedImage = img.copyResize(
  //       image,
  //       width: (image.width * scale).round(),
  //       height: (image.height * scale).round(),
  //     );

  //     Uint8List compressedBytes = img.encodePng(compressedImage);

  //     return compressedBytes;
  //   }

  //   return Uint8List.fromList(imageBytes);
  // }

  static Future<File> compressImage(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();

    img.Image? image = img.decodeImage(Uint8List.fromList(imageBytes));

    if (image != null && image.lengthInBytes > 1024 * 1024) {
      double scale = 1024 * 1024 / image.lengthInBytes;

      img.Image compressedImage = img.copyResize(
        image,
        width: (image.width * scale).round(),
        height: (image.height * scale).round(),
      );

      List<int> compressedBytes = img.encodePng(compressedImage);

      String tempPath =
          imageFile.path.replaceAll(imageFile.path.split('/').last, '');
      String compressedImagePath =
          '$tempPath/${DateTime.now().millisecondsSinceEpoch}_compressed.jpg';

      File compressedImageFile = File(compressedImagePath);
      await compressedImageFile.writeAsBytes(compressedBytes);

      return compressedImageFile;
    }

    return imageFile;
  }
}
