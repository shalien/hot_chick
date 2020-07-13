import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:file_directory_ext/file_directory_ext.dart';
import 'package:hot_chick/src/constants/hot_chick_hash.dart';
import 'package:hot_chick/src/utils/hot_chick_utils.dart';
import 'package:hot_chick/src/constants/hot_chick_constants.dart';

class HotChickEncrypter {
  static Future<bool> encrypt(File file, String password,
      [Map<String, String> metadata]) async {}

  static bool encryptSync(File file, String password,
      {Map<String, String> metadata,
      HotChickHash hash = HotChickHash.SHA512,
      bool generateIntermediary = false,
      preserveFileName = false}) {
    final hashAlgorithm = HotChickUtils.getHash(hash);

    final size = file.lengthSync();
    final binaryContent = file.readAsBytesSync();
    final checksum =
        '${hash.toString().split('.').last}@${HotChickUtils.getChecksumSync(file, hashAlgorithm)}';

    final metadata = _generateMetadata(file, size, checksum);

    var bytesBuilder = BytesBuilder();
    bytesBuilder.add(utf8.encode(metadata));
    bytesBuilder.add(binaryContent);

    if (generateIntermediary) {
      var intermediary = File('${file.basename}.hci');
      intermediary.writeAsBytesSync(bytesBuilder.toBytes());
    }

    final key = Key.fromUtf8(password).stretch(32);
    final iv = IV.fromUtf8(key.base64.substring(0, 8));

    final encrypter = Encrypter(Salsa20(key));
    final encrypted = encrypter.encryptBytes(bytesBuilder.toBytes(), iv: iv);

    final encryptedFile = File('${file.basename}.hc');
    encryptedFile.writeAsBytesSync(encrypted.bytes);

    return encryptedFile.existsSync();
  }

  static String _generateMetadata(File file, int size, String checksum,
      [Map<String, String> metadata]) {
    final buffer = StringBuffer();
    buffer.write(
        '${HotChickConstants.HotChickMagicPacket}${HotChickConstants.HotChickLineEnd}');
    buffer.write('CHECKSUM:$checksum${HotChickConstants.HotChickLineEnd}');
    buffer.write('SIZE:${size}${HotChickConstants.HotChickLineEnd}');
    buffer.write(
        'ORIGINAL:${file.basename}.${file.extension}${HotChickConstants.HotChickLineEnd}');

    metadata?.forEach((key, value) {
      buffer.write(
          '${key.toUpperCase()}:${value}${HotChickConstants.HotChickLineEnd}');
    });

    buffer.write(
        'VERSION:${HotChickConstants.HotChickVersion}${HotChickConstants.HotChickLineEnd}');
    buffer.write('${HotChickConstants.HotChickBoundary}');

    return buffer.toString();
  }
}
