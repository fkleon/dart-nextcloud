import 'package:nextcloud/nextcloud.dart';
import 'package:test/test.dart';

import 'config.dart';

@Timeout(Duration(seconds: 60))
void main() {
  final config = getConfig();
  group('Connections', () {
    final urls = [
      ['http://cloud.test.com/index.php/123', 'http://cloud.test.com'],
      ['https://cloud.test.com:80/index.php/123', 'https://cloud.test.com'],
      ['cloud.test.com', 'https://cloud.test.com'],
      ['cloud.test.com:90', 'https://cloud.test.com'],
      ['test.com/cloud', 'https://test.com/cloud'],
      ['test.com/cloud/index.php/any/path', 'https://test.com/cloud'],
    ];
    for (final url in urls) {
      test('${url[0]} returns ${url[1]} as base URL', () {
        final client = NextCloudClient.withCredentials(
          url[0],
          config.username,
          config.password,
        );
        expect(client.baseUrl, equals(url[1]));
      });
    }
  });
}
