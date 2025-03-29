import 'dart:io';

import 'package:uni_links_desktop/src/protocol_registrar.dart';
import 'package:win32_registry/win32_registry.dart';

class ProtocolRegistrarImplWindows extends ProtocolRegistrar {
  ProtocolRegistrarImplWindows._();

  /// The shared instance of [ProtocolRegistrarImplWindows].
  static final ProtocolRegistrarImplWindows instance =
      ProtocolRegistrarImplWindows._();

  @override
  Future<void> register(String scheme) async {
    String appPath = Platform.resolvedExecutable;

    String protocolRegKey = 'Software\\Classes\\$scheme';
    RegistryValue protocolRegValue = const RegistryValue.string(
      'URL Protocol',
      '',
    );
    String protocolCmdRegKey = 'shell\\open\\command';
    RegistryValue protocolCmdRegValue = RegistryValue.string(
      '',
      '"$appPath" "%1"',
    );

    final regKey = Registry.currentUser.createKey(protocolRegKey);
    regKey.createValue(protocolRegValue);
    regKey.createKey(protocolCmdRegKey).createValue(protocolCmdRegValue);
  }
}
