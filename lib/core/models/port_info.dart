/// Port identity from `GET /system/info` (MB-P53 keeps it in the meta box).
class PortInfo {
  const PortInfo({
    required this.portId,
    required this.portCode,
    required this.portName,
    this.licenseMode = LicenseMode.full,
    this.minAppVersion,
  });

  final String portId;

  /// Shown as the port identifier, e.g. `PORT-ALX`.
  final String portCode;
  final String portName;

  /// Always [LicenseMode.full] for now (DEC-54).
  final LicenseMode licenseMode;
  final String? minAppVersion;
}

/// `license_mode`. READ_ONLY is deferred (DEC-54).
enum LicenseMode { full, readOnly }
