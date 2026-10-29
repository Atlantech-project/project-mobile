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
  String get updateRequiredTitle => 'حدّث التطبيق للمتابعة';

  @override
  String get updateRequiredMessage =>
      'لم يعد خادم الميناء يدعم هذا الإصدار من ATLANTECH. اطلب من فريق تقنية المعلومات بالميناء تثبيت أحدث إصدار على هذا الجهاز. التغييرات المحفوظة على الجهاز لن تُفقد.';

  @override
  String get updateInstalledVersion => 'الإصدار المثبّت';

  @override
  String get updateRequiredVersion => 'الإصدار المطلوب';

  @override
  String get devMockUpdateRequired => 'محاكاة طلب التحديث (426)';

  @override
  String get accessDeniedTitle => 'ليس لديك صلاحية لهذا';

  @override
  String get accessDeniedPermissionMessage =>
      'دورك أو نطاق المحطة الخاص بك لا يسمح بهذه الصفحة أو هذا الإجراء. التغييرات المحفوظة على الجهاز لن تُفقد.';

  @override
  String get accessDeniedRoleMessage =>
      'هذا التطبيق مخصص للمرشدين البحريين وقادة القاطرات ومشرفي محطة الحاويات. حسابك له دور مختلف، لذا سجّل الدخول بحساب ميداني أو استخدم لوحة التحكم على الويب.';

  @override
  String get accessDeniedReasonLabel => 'السبب';

  @override
  String get accessDeniedReasonPermission => 'الدور أو نطاق المحطة';

  @override
  String get accessDeniedReasonRole => 'ليس دورًا ميدانيًا';

  @override
  String get backToMyTasksAction => 'العودة إلى مهامي';

  @override
  String get signOutAction => 'تسجيل الخروج';

  @override
  String get devMockAccessDenied => 'محاكاة رفض الوصول (403)';
}
