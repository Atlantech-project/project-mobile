import 'package:intl/intl.dart';

import '../widgets/app_ltr.dart';

/// Date and time text. The app shows port times in UTC, as the design does.
/// Every result is wrapped in an LTR isolate so it reads right in Arabic.
abstract final class AppFormats {
  /// `12:45 UTC`
  static String time(DateTime value) =>
      ltrIsolate('${DateFormat.Hm().format(value.toUtc())} UTC');

  /// `09 Oct 2026` in the active locale.
  static String date(DateTime value, String locale) =>
      ltrIsolate(DateFormat('dd MMM yyyy', locale).format(value.toUtc()));

  /// `09 Oct 2026 · 12:45 UTC`
  static String dateTime(DateTime value, String locale) =>
      '${date(value, locale)} · ${time(value)}';

  /// `11:50–12:45 UTC`
  static String timeRange(DateTime start, DateTime end) => ltrIsolate(
    '${DateFormat.Hm().format(start.toUtc())}–'
    '${DateFormat.Hm().format(end.toUtc())} UTC',
  );
}
