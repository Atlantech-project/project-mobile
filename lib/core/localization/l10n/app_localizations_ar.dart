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

  @override
  String get splashStatus => 'جارٍ تجهيز مساحة العمل';

  @override
  String get loading => 'جارٍ التحميل';

  @override
  String get retryAction => 'إعادة المحاولة';

  @override
  String get stateEmptyTitle => 'لا يوجد شيء هنا بعد';

  @override
  String get stateEmptyMessage => 'عندما تتوفر بيانات ستظهر هنا.';

  @override
  String get stateErrorTitle => 'حدث خطأ ما';

  @override
  String get stateErrorMessage =>
      'تعذّر تحميل هذه الصفحة. حاول مرة أخرى بعد قليل.';

  @override
  String get stateOfflineTitle => 'أنت غير متصل';

  @override
  String get stateOfflineMessage =>
      'لا توجد بيانات محفوظة على هذا الجهاز بعد. اتصل بشبكة الميناء وحاول مرة أخرى.';

  @override
  String get pageNotFoundTitle => 'الصفحة غير موجودة';

  @override
  String get pageNotFoundMessage => 'هذه الصفحة غير موجودة أو تم نقلها.';

  @override
  String get backToStartAction => 'العودة للبداية';

  @override
  String get devPreviewStates => 'معاينة حالات الصفحة';

  @override
  String get devStateEmpty => 'فارغة';

  @override
  String get devStateError => 'خطأ';

  @override
  String get devStateOffline => 'غير متصل';

  @override
  String get updateRequiredTitle => 'يلزم تحديث التطبيق';

  @override
  String get updateRequiredMessage =>
      'لم يعد هذا الإصدار من ATLANTECH مدعومًا. حدّث التطبيق للمتابعة.';

  @override
  String get updateInstalledVersion => 'الإصدار المثبّت حاليًا';

  @override
  String get updateRequiredVersion => 'الإصدار المطلوب';

  @override
  String get updateRequiredVersionUnknown => 'لم يرسله الخادم';

  @override
  String get updateNoticeTitle => 'ثبّت الإصدار الجديد';

  @override
  String get updateNoticeMessage =>
      'يصل التحديث إلى الميناء كملف APK، أو يثبّته المسؤول على هذا الجهاز. يظل الدخول إلى التطبيق محظورًا حتى يتم التثبيت.';

  @override
  String get updateGuidance => 'يلزم الرجوع إلى المسؤول';

  @override
  String get updateBlocked => 'محظور حتى يتم تثبيت التحديث المطلوب.';

  @override
  String get updateOutboxNote =>
      'التحقق من الإصدار لا يرسل عناصر صندوق الإرسال ولا يؤكدها. التغييرات المحفوظة على الجهاز تبقى باسم المستخدم الذي سجّلها.';

  @override
  String get devMockUpdateRequired => 'محاكاة طلب التحديث (426)';

  @override
  String get accessDeniedTitle => 'تم رفض الوصول';

  @override
  String get accessDeniedPermissionMessage =>
      'ليس لديك صلاحية للوصول إلى الصفحة أو الإجراء المطلوب.';

  @override
  String get accessDeniedRoleMessage =>
      'هذا التطبيق مخصص للأدوار الميدانية فقط.';

  @override
  String get accessDeniedReasonLabel => 'السبب';

  @override
  String get accessDeniedReasonPermission =>
      'دورك أو نطاق المحطة الخاص بك لا يسمح بهذه الصفحة أو هذا الإجراء.';

  @override
  String get accessDeniedReasonRole =>
      'دورك يعمل على لوحة التحكم على الويب فقط.';

  @override
  String get accessDeniedContact =>
      'تواصل مع مسؤول النظام إذا كنت تحتاج إلى الوصول.';

  @override
  String get accessDeniedRoleContact =>
      'استخدم لوحة تحكم ATLANTECH على الويب، أو سجّل الدخول بحساب مرشد بحري أو قائد قاطرة أو مشرف محطة الحاويات.';

  @override
  String get accessDeniedBackHint =>
      'العودة إلى قائمة مهامك. التغييرات المحفوظة على الجهاز لن تُفقد.';

  @override
  String get accessDeniedSignOutHint =>
      'سجّل الخروج، ثم سجّل الدخول بحساب ميداني.';

  @override
  String get backToMyTasksAction => 'العودة إلى مهامي';

  @override
  String get signOutAction => 'تسجيل الخروج';

  @override
  String get devMockAccessDenied => 'محاكاة رفض الوصول (403)';
}
