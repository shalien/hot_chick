
import 'dart:io';

import 'package:hot_chick/hot_chick.dart';
import 'package:test/test.dart';

void main() {

  group('Tests of the ecrypter part', () {

    var file;
    final password = 'HOTCHICK';

    setUp(() {
      file = File('hc.png');
    });

    test('Encrypt a file and generate the hci in synchronous mode using password HOTCHICK', () {

      HotChickEncrypter.encryptSync(file, password, generateIntermediary: true);

      expect(File('hc.hci').existsSync(), isTrue);
    });


    test('Encrypt a file with the password HOTCHICK', () {
      var value = HotChickEncrypter.encryptSync(file, password);
      expect(File('hc.hc').existsSync() && value, isTrue);
    });
  });

}