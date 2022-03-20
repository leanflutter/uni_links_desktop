import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:uni_links_desktop/uni_links_desktop.dart';

void main() {
  const MethodChannel channel = MethodChannel('uni_links_desktop');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  // test('getPlatformVersion', () async {
  //   expect(await UniLinksDesktop.platformVersion, '42');
  // });
}
