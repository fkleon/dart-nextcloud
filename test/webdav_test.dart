import 'dart:io';

import 'package:nextcloud/nextcloud.dart';
import 'package:test/test.dart';

import 'config.dart';

@Timeout(Duration(seconds: 60))
Future main() async {
  final config = getConfig();
  final client = getClient(config);
  try {
    await client.webDav.delete(config.testDir);
    // ignore: empty_catches
  } on RequestException {}
  group('WebDAV', () {
    test('Create directory', () async {
      expect(
          (await client.webDav.mkdir(config.testDir)).statusCode, equals(201));
    });
    test('List directory', () async {
      expect((await client.webDav.ls(config.testDir)).length, equals(0));
    });
    test('Upload files', () async {
      expect(
          (await client.webDav.upload(
                  File('test/files/test.png').readAsBytesSync(),
                  '${config.testDir}/test.png'))
              .statusCode,
          equals(201));
      expect(
          (await client.webDav.upload(
                  File('test/files/test.txt').readAsBytesSync(),
                  '${config.testDir}/test.txt'))
              .statusCode,
          equals(201));
      expect((await client.webDav.ls(config.testDir)).length, equals(2));
    });
    test('Copy file', () async {
      expect(
          await client.webDav.copy(
            '${config.testDir}/test.txt',
            '${config.testDir}/test2.txt',
          ),
          null);
      expect((await client.webDav.ls(config.testDir)).length, equals(3));
    });
    test('Move file', () async {
      expect(
          await client.webDav.move(
            '${config.testDir}/test2.txt',
            '${config.testDir}/test3.txt',
          ),
          null);
      expect((await client.webDav.ls(config.testDir)).length, equals(3));
      expect(
          (await client.webDav.ls(config.testDir))
              .where((f) => f.name == 'test3.txt')
              .length,
          equals(1));
    });
  });
}
