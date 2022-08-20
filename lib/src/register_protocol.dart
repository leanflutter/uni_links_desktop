import './protocol_registrar.dart';

void registerProtocol(String scheme) {
  protocolRegistrar.register(scheme);
}
