import 'dart:async';

import 'package:flutter/material.dart';
import 'package:protocol_handler/protocol_handler.dart';
import 'package:uni_links_platform_interface/uni_links_platform_interface.dart';

void enableUniLinksDesktop() {
  WidgetsFlutterBinding.ensureInitialized();
  UniLinksPlatform.instance = UniLinksDesktop();
}

void registerProtocol(String scheme) {
  protocolHandler.register(scheme);
}

class UniLinksDesktop extends UniLinksPlatform with ProtocolListener {
  /// Registers this class as the default instance of [UniLinksDesktop].
  static void registerWith() {
    // UniLinksPlatform.instance = UniLinksDesktop();
  }

  final _linkStreamController = StreamController<String?>();

  UniLinksDesktop() {
    protocolHandler.addListener(this);
  }

  @override
  Future<String?> getInitialLink() => protocolHandler.getInitialUrl();

  @override
  Stream<String?> get linkStream =>
      _linkStreamController.stream.asBroadcastStream();

  @override
  void onProtocolUrlReceived(String url) {
    _linkStreamController.sink.add(url);
  }
}
