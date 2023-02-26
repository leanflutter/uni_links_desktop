import 'dart:io';

import 'package:uni_links_desktop/src/protocol_registrar_impl_macos.dart';
import 'package:uni_links_desktop/src/protocol_registrar_impl_windows.dart';

class ProtocolRegistrar {
  /// The shared instance of [ProtocolRegistrar].
  static ProtocolRegistrar get instance {
    if (Platform.isMacOS) return ProtocolRegistrarImplMacOS.instance;
    if (Platform.isWindows) return ProtocolRegistrarImplWindows.instance;
    return ProtocolRegistrar();
  }

  Future<void> register(String scheme) async {
    throw UnimplementedError();
  }
}

final protocolRegistrar = ProtocolRegistrar.instance;
