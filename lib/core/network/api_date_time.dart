/// Datetimes sent to the server (CT-01): UTC ISO 8601 with microseconds and
/// `Z`, for example `2026-11-02T10:15:04.123456Z`.
///
/// Use it for every datetime the app writes (`reported_at`,
/// `client_sent_at`, …). Never use it on `version`: that is an opaque string
/// and is sent back exactly as received.
abstract final class ApiDateTime {
  static String format(DateTime value) {
    final utc = value.toUtc();
    String two(int n) => n.toString().padLeft(2, '0');
    final fraction = (utc.millisecond * 1000 + utc.microsecond)
        .toString()
        .padLeft(6, '0');
    return '${utc.year.toString().padLeft(4, '0')}-${two(utc.month)}-'
        '${two(utc.day)}T${two(utc.hour)}:${two(utc.minute)}:'
        '${two(utc.second)}.${fraction}Z';
  }
}
