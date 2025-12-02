import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

extension FileExtensions on File {
  MultipartFile toMultipartFileSync() {
    return MultipartFile.fromFileSync(path, filename: path.split('/').last);
  }

  Future<MultipartFile> toMultipartFile() async {
    final bytes = await compressImage();
    return MultipartFile.fromBytes(bytes, filename: path.split('/').last);
  }

  Future<Uint8List> compressImage({int quality = 70}) async {
    final result = await FlutterImageCompress.compressWithFile(
      path,
      quality: quality,
      minWidth: 100,
      minHeight: 100,
      format: CompressFormat.webp,
    );

    return result ?? readAsBytesSync();
  }
}

extension FileListExtensions on List<File> {
  List<MultipartFile> toMultipartFilesSync() {
    return map((file) => file.toMultipartFileSync()).toList();
  }

  Future<List<MultipartFile>> toMultipartFiles() async {
    return Future.wait(map((file) => file.toMultipartFile()).toList());
  }
}
