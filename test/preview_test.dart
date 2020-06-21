import 'package:test/test.dart';

import 'config.dart';

@Timeout(Duration(seconds: 60))
void main() {
  final config = getConfig();
  final client = getClient(config);
  group('Preview', () {
    test('Get preview', () async {
      expect(await client.preview.getPreview('${config.image}', 64, 64),
          isNotNull);
    });
    test('Get preview stream', () async {
      expect(await client.preview.getPreviewStream('${config.image}', 64, 64),
          isNotNull);
    });
    test('Get thumbnail', () async {
      expect(await client.preview.getThumbnail('${config.image}', 64, 64),
          isNotNull);
    });
    test('Get thumbnail stream', () async {
      expect(await client.preview.getThumbnailStream('${config.image}', 64, 64),
          isNotNull);
    });
  });
}
