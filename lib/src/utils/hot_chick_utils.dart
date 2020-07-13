import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:hot_chick/src/constants/hot_chick_hash.dart';

class HotChickUtils {
  static String getChecksumSync(File file, Hash hash) {
    final binary = file.readAsBytesSync();

    return hash.convert(binary).toString();
  }

  static Future<String> getChecksum(File file, Hash hash) async {
    await for (var digest in hash.bind(file.openRead())) {
      return digest.toString();
    }
  }

  static Hash getHash(HotChickHash hash) {
    Hash selectedHash;

    switch (hash) {
      case HotChickHash.SHA1:
        selectedHash = sha1;
        break;
      case HotChickHash.SHA224:
        selectedHash = sha224;
        break;
      case HotChickHash.SHA256:
        selectedHash = sha256;
        break;
      case HotChickHash.SHA384:
        selectedHash = sha384;
        break;
      case HotChickHash.SHA512:
        selectedHash = sha512;
        break;
      case HotChickHash.MD5:
        selectedHash = md5;
        break;
      default:
        selectedHash = sha512;
        break;
    }

    return selectedHash;
  }
}
