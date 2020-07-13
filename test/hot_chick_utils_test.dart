import 'dart:io';

import 'package:hot_chick/hot_chick.dart';
import 'package:hot_chick/src/utils/hot_chick_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Testing the sync version of the checksum computation', () {
    File file;

    setUp(() {
      file = File('hc.png');
    });

    test('Testing checksum sha1 sync', () {
      final hash = HotChickUtils.getHash(HotChickHash.SHA1);

      expect(HotChickUtils.getChecksumSync(file, hash),
          'c6d692c699ea1e6822022b4f1c63c79e686bb5c8');
    });

    test('Testing checksum sha224 sync', () {
      final hash = HotChickUtils.getHash(HotChickHash.SHA224);

      expect(HotChickUtils.getChecksumSync(file, hash),
          '2bcd860fa84ef392c4a7b5413cca035dc049d78467c5a5cc1a342db5');
    });

    test('Testing checksum sha256 sync', () {
      final hash = HotChickUtils.getHash(HotChickHash.SHA256);

      expect(HotChickUtils.getChecksumSync(file, hash),
          '3cff77947dd58b953bf94d2cc51d85f0e1e1f248201a03a0f15cfbc0485c2167');
    });

    test('Testing checksum sha384 sync', () {
      final hash = HotChickUtils.getHash(HotChickHash.SHA384);

      expect(HotChickUtils.getChecksumSync(file, hash),
          'ab2f0394bbfae0189ce48677ad2b6b61e8cc771645814c22390879293ce1e11aa9a38c56fd27b496ad5ac9a3781821af');
    });

    test('Testing checksum sha512 sync', () {
      final hash = HotChickUtils.getHash(HotChickHash.SHA512);

      expect(HotChickUtils.getChecksumSync(file, hash),
          '0064c493e5b24241470b0d3e00c39c292fe2bfe09e6fe352163c87d34b294ecfb25055b3e40d4f9ab37b82ad30a7b1c30bea2d615d5eb1fbec5de98203bac358');
    });

    test('Testing checksum MD5 sync', () {
      final hash = HotChickUtils.getHash(HotChickHash.MD5);

      expect(HotChickUtils.getChecksumSync(file, hash),
          'fc18f2092cf8f98d7a6a0bb6e4a037a6');
    });
  });

  group('Testing the async version of the checksum computation', () {
    File file;

    setUp(() {
      file = File('hc.png');
    });

    test('Testing checksum sha1 async', () async {
      final hash = HotChickUtils.getHash(HotChickHash.SHA1);

      expect(await HotChickUtils.getChecksum(file, hash),
          'c6d692c699ea1e6822022b4f1c63c79e686bb5c8');
    });

    test('Testing checksum sha224 async', () async {
      final hash = HotChickUtils.getHash(HotChickHash.SHA224);

      expect(await HotChickUtils.getChecksum(file, hash),
          '2bcd860fa84ef392c4a7b5413cca035dc049d78467c5a5cc1a342db5');
    });

    test('Testing checksum sha256 async', () async {
      final hash = HotChickUtils.getHash(HotChickHash.SHA256);

      expect(await HotChickUtils.getChecksum(file, hash),
          '3cff77947dd58b953bf94d2cc51d85f0e1e1f248201a03a0f15cfbc0485c2167');
    });

    test('Testing checksum sha384 async', () async {
      final hash = HotChickUtils.getHash(HotChickHash.SHA384);

      expect(await HotChickUtils.getChecksum(file, hash),
          'ab2f0394bbfae0189ce48677ad2b6b61e8cc771645814c22390879293ce1e11aa9a38c56fd27b496ad5ac9a3781821af');
    });

    test('Testing checksum sha512 async', () async {
      final hash = HotChickUtils.getHash(HotChickHash.SHA512);

      expect(await HotChickUtils.getChecksum(file, hash),
          '0064c493e5b24241470b0d3e00c39c292fe2bfe09e6fe352163c87d34b294ecfb25055b3e40d4f9ab37b82ad30a7b1c30bea2d615d5eb1fbec5de98203bac358');
    });

    test('Testing checksum MD5 async', () async {
      final hash = HotChickUtils.getHash(HotChickHash.MD5);

      expect(await HotChickUtils.getChecksum(file, hash),
          'fc18f2092cf8f98d7a6a0bb6e4a037a6');
    });
  });
}
