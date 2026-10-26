import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../config/app_config.dart';

/// Builds the TLS trust for the port server: only certificates signed by the
/// offline ATLANTECH Root CA are accepted, not the phone's system CAs.
abstract final class RootCa {
  static Future<SecurityContext> securityContext() async {
    final pem = await _loadPem();
    if (pem != null) {
      return SecurityContext(withTrustedRoots: false)
        ..setTrustedCertificatesBytes(pem);
    }
    if (kDebugMode) {
      // DEV-ONLY(MB-F2): until the real Root CA is bundled, debug builds use
      // the system CAs so a dev server with a public certificate works.
      debugPrint(
        'RootCa: ${AppConfig.rootCaAsset} has no certificate; '
        'debug build falls back to the system CAs.',
      );
      return SecurityContext(withTrustedRoots: true);
    }
    // Release without the Root CA: trust nothing rather than any CA.
    return SecurityContext(withTrustedRoots: false);
  }

  static final _pemHeader = RegExp(
    r'^-----BEGIN CERTIFICATE-----\s*$',
    multiLine: true,
  );

  static Future<List<int>?> _loadPem() async {
    try {
      final text = await rootBundle.loadString(AppConfig.rootCaAsset);
      // Match the header on its own line: the placeholder file only mentions
      // it inside a comment.
      if (!_pemHeader.hasMatch(text)) return null;
      return utf8.encode(text);
    } on FlutterError {
      return null;
    }
  }
}
