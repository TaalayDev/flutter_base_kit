import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:flutter_base_kit/flutter_base_kit_platform_interface.dart';
import 'package:flutter_base_kit/flutter_base_kit_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterBaseKitPlatform
    with MockPlatformInterfaceMixin
    implements FlutterBaseKitPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterBaseKitPlatform initialPlatform = FlutterBaseKitPlatform.instance;

  test('$MethodChannelFlutterBaseKit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterBaseKit>());
  });

  test('getPlatformVersion', () async {
    FlutterBaseKit flutterBaseKitPlugin = FlutterBaseKit();
    MockFlutterBaseKitPlatform fakePlatform = MockFlutterBaseKitPlatform();
    FlutterBaseKitPlatform.instance = fakePlatform;

    expect(await flutterBaseKitPlugin.getPlatformVersion(), '42');
  });
}
