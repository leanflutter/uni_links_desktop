import 'package:uni_links_desktop/src/protocol_registrar.dart';

void registerProtocol(String scheme) {
  protocolRegistrar.register(scheme);
}
