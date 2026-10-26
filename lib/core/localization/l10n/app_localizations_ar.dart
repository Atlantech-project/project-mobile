// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'ATLANTECH';

  @override
  String get titlePortIdentification => 'تحديد الميناء';

  @override
  String get titleSignIn => 'تسجيل الدخول';

  @override
  String get titleMyTasks => 'مهامي';

  @override
  String get titleTaskDetails => 'تفاصيل المهمة';

  @override
  String get titleSyncOutbox => 'المزامنة وصندوق الصادر';

  @override
  String get titleNotifications => 'الإشعارات';

  @override
  String get titleAccessDenied => 'تم رفض الوصول';

  @override
  String get titleAppUpdateRequired => 'يلزم تحديث التطبيق';

  @override
  String get titleSettings => 'الإعدادات';

  @override
  String get continueAction => 'متابعة';

  @override
  String get cancelAction => 'إلغاء';

  @override
  String get confirmAction => 'تأكيد';

  @override
  String get backAction => 'رجوع';

  @override
  String get switchLanguage => 'English';

  @override
  String get connectionOnline => 'متصل';

  @override
  String get connectionOffline => 'غير متصل';

  @override
  String get requiredMark => 'مطلوب';

  @override
  String get roleMarinePilot => 'مرشد بحري';

  @override
  String get roleTugMaster => 'قائد قاطرة';

  @override
  String get roleCtSupervisor => 'مشرف محطة الحاويات';

  @override
  String get roleNctSupervisor => 'مشرف المحطة غير الحاوية';

  @override
  String get roleUnsupported => 'دور غير مدعوم';

  @override
  String get devMockSignIn => 'دخول تجريبي كمرشد';

  @override
  String get devMockSignInUnsupported => 'دخول تجريبي بدور غير مدعوم';

  @override
  String get devMockSignOut => 'خروج تجريبي';

  @override
  String get devOpenSampleTask => 'فتح مهمة تجريبية';

  @override
  String get placeholderNote => 'سيتم بناء هذه الشاشة في مهمة لاحقة.';
}
