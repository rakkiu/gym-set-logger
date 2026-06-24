import 'dart:io';
import 'package:flutter/services.dart';

class AndroidStorageHelper {
  static const _channel = MethodChannel('com.gymsetlogger/storage');

  /// Save a file to the public Downloads folder using MediaStore (Android 10+)
  /// Returns the file path on success, null on failure.
  static Future<String?> saveToDownloads({
    required String fileName,
    required List<int> bytes,
    String mimeType = 'text/csv',
  }) async {
    if (!Platform.isAndroid) return null;

    try {
      final result = await _channel.invokeMethod('saveToDownloads', {
        'fileName': fileName,
        'bytes': bytes,
        'mimeType': mimeType,
      });
      return result as String?;
    } on PlatformException {
      return null;
    }
  }
}
