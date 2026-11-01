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

  @override
  String get errorBadRequest => 'تعذّر تنفيذ الطلب.';

  @override
  String get errorUnauthenticated => 'انتهت الجلسة. سجّل الدخول مرة أخرى.';

  @override
  String get errorInvalidCredentials =>
      'اسم المستخدم أو كلمة المرور غير صحيحة.';

  @override
  String get errorForbidden =>
      'دورك أو نطاق المحطة الخاص بك لا يسمح بهذا الإجراء.';

  @override
  String get errorAccountDisabled => 'هذا الحساب معطّل. تواصل مع مسؤول النظام.';

  @override
  String get errorPasswordChangeRequired => 'غيّر كلمة المرور للمتابعة.';

  @override
  String get errorNotFound => 'هذا السجل لم يعد موجوداً.';

  @override
  String get errorVersionConflict =>
      'تم تعديل هذا السجل من مستخدم آخر. يتم عرض أحدث نسخة.';

  @override
  String get errorValidationFailed =>
      'بعض البيانات غير صحيحة. راجع الحقول وحاول مرة أخرى.';

  @override
  String get errorIdempotencyKeyReused =>
      'تم إرسال هذا الطلب من قبل ببيانات مختلفة.';

  @override
  String get errorLicenseReadOnly =>
      'ترخيص الميناء للقراءة فقط. لا يمكن حفظ تغييرات جديدة.';

  @override
  String get errorAppUpdateRequired =>
      'هذا الإصدار من التطبيق لم يعد مدعوماً. حدّث التطبيق للمتابعة.';

  @override
  String get errorTooManyAttempts =>
      'محاولات كثيرة. انتظر قليلاً ثم حاول مرة أخرى.';

  @override
  String get errorServerError =>
      'حدثت مشكلة في الخادم. حاول مرة أخرى بعد قليل.';

  @override
  String get errorServiceUnavailable =>
      'الخادم غير متاح الآن. حاول مرة أخرى بعد قليل.';

  @override
  String get errorNetwork =>
      'لا يمكن الوصول إلى خادم الميناء. تحقق من شبكة الميناء وحاول مرة أخرى.';

  @override
  String get errorTimeout => 'تأخر خادم الميناء في الرد. حاول مرة أخرى.';

  @override
  String get errorUntrustedServer =>
      'هذه الشبكة ليست شبكة الميناء. اتصل بشبكة الميناء وحاول مرة أخرى.';

  @override
  String get errorUnknown => 'حدث خطأ ما. حاول مرة أخرى بعد قليل.';

  @override
  String get connectionUnknown => 'غير معروف';

  @override
  String get portHeaderSubtitle => 'العمليات الميدانية · تحديد الميناء';

  @override
  String get portLoading => 'جارٍ الاتصال بخادم الميناء';

  @override
  String get portTitle => 'تأكيد الميناء';

  @override
  String get portIntro =>
      'هوية الميناء تأتي من الخادم، ولا يتم اختيارها على هذا الجهاز.';

  @override
  String get portLoadedTitle => 'تم استلام هوية الميناء';

  @override
  String get portLoadedMessage =>
      'راجع اسم الميناء ومعرّفه القادمين من الخادم. تابع فقط إذا كان هذا هو الميناء الذي تعمل فيه.';

  @override
  String get portUnavailableTitle => 'تعذّر الاتصال بالخادم';

  @override
  String get portUnavailableMessage =>
      'تعذّر جلب هوية الميناء وحالة الترخيص. أعد الاتصال بالخادم ثم حاول مرة أخرى. المتابعة غير متاحة.';

  @override
  String get portFailedTitle => 'تعذّر التحقق من هوية الميناء';

  @override
  String get portFailedMessage =>
      'الاتصال بالخادم متاح، لكن لم تصل هوية ميناء صالحة. أعد التحقق، ولا تتابع بميناء غير مؤكد.';

  @override
  String get portIncorrectTitle => 'يبدو أن الميناء المتصل غير صحيح';

  @override
  String get portIncorrectMessage =>
      'لا تتابع. لا يمكن تعديل هوية الميناء من هنا. تأكد من شبكة الميناء ثم تحقق مرة أخرى.';

  @override
  String get portConnectedLabel => 'الميناء المتصل';

  @override
  String get portSourceServer => 'هوية من الخادم';

  @override
  String get portSourceNotVerified => 'غير مؤكد';

  @override
  String get portSourceBlocked => 'رد الخادم · المراجعة موقوفة';

  @override
  String get portNameLabel => 'اسم الميناء';

  @override
  String get portIdentifierLabel => 'معرّف الميناء';

  @override
  String get portUnavailableValue => 'غير متاح';

  @override
  String get portLicenseLabel => 'حالة الترخيص';

  @override
  String get portLicenseActive => 'نشط';

  @override
  String get portLicenseUnknown => 'غير معروف · لم يتم جلبه';

  @override
  String get portNoIdentityNote =>
      'لا توجد هوية أو ترخيص مؤكد. لا يُسمح باختيار الميناء على الجهاز.';

  @override
  String get portNotMyPortAction => 'هذا ليس مينائي';

  @override
  String get portContinueHint =>
      'تابع إلى تسجيل الدخول. صلاحيات دورك ومهامك تظل كما هي.';

  @override
  String get portBlockedHint =>
      'المتابعة موقوفة حتى يتم التحقق من هوية الخادم والترخيص.';

  @override
  String get portIncorrectHint =>
      'المتابعة موقوفة حتى يتم التحقق من الميناء الصحيح. لا يمكن التصحيح أو تغيير الميناء من هنا.';

  @override
  String get loginHeaderSubtitle => 'العمليات الميدانية · تسجيل الدخول';

  @override
  String get loginTitle => 'تسجيل الدخول للعمليات الميدانية';

  @override
  String get loginAgainTitle => 'سجّل الدخول مرة أخرى';

  @override
  String get loginChangeTitle => 'تعيين كلمة مرور جديدة';

  @override
  String get loginPortLabel => 'الميناء';

  @override
  String get loginPortNotConfirmed => 'لم يتم التأكيد بعد';

  @override
  String get loginPortNotConfirmedNote =>
      'سيتم تأكيد هوية الميناء بعد الاتصال.';

  @override
  String get loginPortServerNote => 'هوية الميناء من الخادم';

  @override
  String get loginAccountLabel => 'الحساب';

  @override
  String get loginFirstLogin => 'أول دخول';

  @override
  String get loginFirstLoginNote =>
      'تم استخدام كلمة مرور مؤقتة. اختر كلمة مرور جديدة للمتابعة.';

  @override
  String get loginAccountDisabled => 'الحساب معطّل';

  @override
  String get loginAccountDisabledNote =>
      'هذا الحساب معطّل. تواصل مع مسؤول الميناء.';

  @override
  String get loginUsername => 'اسم المستخدم';

  @override
  String get loginUsernameHint => 'أدخل اسم المستخدم';

  @override
  String get loginUsernameFixed => 'صاحب الأحداث غير المرسلة · ثابت';

  @override
  String get loginUsernameRequired => 'اسم المستخدم مطلوب.';

  @override
  String get loginPassword => 'كلمة المرور';

  @override
  String get loginPasswordHint => 'أدخل كلمة المرور';

  @override
  String get loginPasswordRequired => 'كلمة المرور مطلوبة.';

  @override
  String get loginShowPassword => 'إظهار';

  @override
  String get loginHidePassword => 'إخفاء';

  @override
  String get loginAction => 'تسجيل الدخول';

  @override
  String get loginSigningInAction => 'جارٍ تسجيل الدخول…';

  @override
  String get loginNewPassword => 'كلمة المرور الجديدة';

  @override
  String get loginNewPasswordHint => 'أدخل كلمة المرور الجديدة';

  @override
  String get loginPasswordRule => '8 أحرف على الأقل، فيها حروف وأرقام.';

  @override
  String get loginConfirmPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get loginConfirmPasswordHint => 'أعد كتابة كلمة المرور الجديدة';

  @override
  String get loginNewPasswordRequired => 'هذا الحقل مطلوب.';

  @override
  String get loginPasswordTooShort => 'استخدم 8 أحرف على الأقل.';

  @override
  String get loginPasswordLettersNumbers => 'استخدم حروفًا وأرقامًا معًا.';

  @override
  String get loginPasswordMismatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get loginChangeAction => 'حفظ ومتابعة';

  @override
  String get loginSigningInTitle => 'جارٍ تسجيل الدخول…';

  @override
  String get loginSigningInMessage =>
      'جارٍ التحقق من البيانات مع الخادم. انتظر قليلًا، لم يكتمل الدخول بعد.';

  @override
  String get loginInvalidTitle => 'تعذّر تسجيل الدخول';

  @override
  String get loginInvalidMessage =>
      'اسم المستخدم أو كلمة المرور غير صحيحة. راجع البيانات وحاول مرة أخرى.';

  @override
  String get loginExpiredTitle => 'انتهت الجلسة · المزامنة متوقفة';

  @override
  String loginExpiredMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'و$count حدث في صندوق الصادر محفوظة',
      many: 'و$count حدثًا في صندوق الصادر محفوظة',
      few: 'و$count أحداث في صندوق الصادر محفوظة',
      two: 'وحدثان في صندوق الصادر محفوظة',
      one: 'وحدث واحد في صندوق الصادر محفوظان',
      zero: 'وصندوق الصادر محفوظان',
    );
    return 'أعد الاتصال وسجّل الدخول بنفس المستخدم قبل إرسال الأحداث المعلّقة. العمل المحفوظ $_temp0.';
  }

  @override
  String get loginReauthTitle => 'سجّل الدخول مرة أخرى قبل المزامنة';

  @override
  String loginReauthMessage(int count, String username) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حدث في صندوق الصادر تخص',
      many: '$count حدثًا في صندوق الصادر تخص',
      few: '$count أحداث في صندوق الصادر تخص',
      two: 'حدثان في صندوق الصادر يخصان',
      one: 'حدث واحد في صندوق الصادر يخص',
      zero: 'الأحداث غير المرسلة تخص',
    );
    return '$_temp0 $username. سجّل الدخول بهذا المستخدم لإرسالها؛ لا يمكن لمستخدم آخر إرسال هذه الأحداث.';
  }

  @override
  String get loginOfflineTitle => 'يلزم الاتصال بالخادم';

  @override
  String loginOfflineMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'العمل المحفوظ و$count حدث في صندوق الصادر باقون على هذا الجهاز؛ لم يُرسل شيء.',
      many:
          'العمل المحفوظ و$count حدثًا في صندوق الصادر باقون على هذا الجهاز؛ لم يُرسل شيء.',
      few:
          'العمل المحفوظ و$count أحداث في صندوق الصادر باقون على هذا الجهاز؛ لم يُرسل شيء.',
      two:
          'العمل المحفوظ وحدثان في صندوق الصادر باقون على هذا الجهاز؛ لم يُرسل شيء.',
      one:
          'العمل المحفوظ وحدث واحد في صندوق الصادر باقون على هذا الجهاز؛ لم يُرسل شيء.',
      zero: 'العمل المحفوظ باقٍ على هذا الجهاز.',
    );
    return 'لا يمكن إكمال الدخول بدون اتصال. $_temp0';
  }

  @override
  String get loginTooManyTitle => 'محاولات كثيرة';

  @override
  String get loginServerErrorTitle => 'تعذّر إكمال الدخول';

  @override
  String get loginFootnote => 'بعد الدخول ترتبط جلستك بهذا الجهاز.';

  @override
  String loginOutboxFootnote(String username) {
    return 'صندوق الصادر محفوظ · المالك: $username\nإعادة الدخول لا تحذف الأحداث المعلّقة ولا تنقلها لمستخدم آخر.';
  }

  @override
  String get loginChangeFootnote => 'مطلوب مرة واحدة قبل فتح أي مهمة.';

  @override
  String get loginDisabledFootnote => 'لا يمكن فتح أي مهمة لحساب معطّل.';

  @override
  String get taskTypePilotage => 'إرشاد بحري';

  @override
  String get taskTypeTug => 'مساعدة القاطرات';

  @override
  String get taskTypeTerminal => 'عملية المحطة · تسجيل الفعلي';

  @override
  String get taskStatusAssigned => 'مُسندة';

  @override
  String get taskStatusStarted => 'قيد التنفيذ';

  @override
  String get taskStatusDone => 'تم التنفيذ';

  @override
  String get systemLabelUpdated => 'محدّثة';

  @override
  String get systemLabelOverridden => 'مستبدلة بخطة أحدث';

  @override
  String get systemLabelCancelled => 'ملغاة';

  @override
  String get outboxStatusPending => 'معلّق';

  @override
  String get outboxStatusSending => 'جارٍ الإرسال';

  @override
  String get outboxStatusDone => 'تم';

  @override
  String get outboxStatusRejected => 'مرفوض';

  @override
  String get rejectPlanCancelled => 'تم رفض هذا التحديث لأن الخطة أُلغيت.';

  @override
  String get rejectIllegalTransition =>
      'حالة المهمة تغيّرت بالفعل، لذلك تعذّر تطبيق هذا التحديث.';

  @override
  String get rejectNotAssigned => 'هذه المهمة لم تعد مسندة إليك.';

  @override
  String get rejectNotFound => 'هذه المهمة لم تعد موجودة.';

  @override
  String get rejectInvalidEvent => 'لم يقبل الخادم هذا التحديث.';

  @override
  String get rejectUnknown => 'رفض الخادم هذا التحديث.';

  @override
  String get notificationTypeAssignment => 'إسناد مهمة';

  @override
  String get notificationTypeReminder => 'تذكير قبل التنفيذ';

  @override
  String get notificationTypeCancelled => 'إلغاء الخطة';

  @override
  String get notificationStatusSent => 'مُرسل';

  @override
  String get notificationStatusFailed => 'فشل';

  @override
  String get notificationStatusAcknowledged => 'تم الإقرار';

  @override
  String get eventAcknowledgement => 'إقرار';

  @override
  String get eventDeviceLabel => 'سجل الجهاز';

  @override
  String get eventDispatchLabel => 'الإرسال';

  @override
  String get eventAcceptanceLabel => 'قبول الخادم';

  @override
  String get eventDeviceNone => 'لا يوجد تحديث محفوظ على الجهاز';

  @override
  String eventDeviceSaved(String action, String time) {
    return 'تم حفظ $action · $time';
  }

  @override
  String get eventDispatchNone => 'لم يُرسل أي تحديث';

  @override
  String get eventDispatchWaiting => 'لم يُرسل · معلّق';

  @override
  String get eventDispatchFailed => 'فشلت المحاولة · محفوظ';

  @override
  String get eventDispatchSending => 'جارٍ الإرسال · في انتظار الرد';

  @override
  String eventDispatchDone(String time) {
    return 'تم الإرسال · $time';
  }

  @override
  String get eventAcceptanceNone => 'لا يوجد تحديث جديد في انتظار القبول';

  @override
  String eventAcceptanceWaiting(String action) {
    return '$action لم يتأكد بعد';
  }

  @override
  String eventAcceptanceDone(String action, String time) {
    return 'تم قبول $action · $time';
  }

  @override
  String eventAcceptanceRejected(String action) {
    return 'تم رفض $action · محفوظ';
  }

  @override
  String get outboxAction => 'صندوق الصادر';

  @override
  String get tasksListTitle => 'مهامي المسندة';

  @override
  String tasksListTitleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مهمة',
      many: '$count مهمة',
      few: '$count مهام',
      two: 'مهمتان',
      one: 'مهمة واحدة',
    );
    return 'مهامي المسندة · $_temp0';
  }

  @override
  String get tasksListTitleCt => 'المحطة A · تسجيل الفعلي';

  @override
  String tasksListTitleCtCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مهمة',
      many: '$count مهمة',
      few: '$count مهام',
      two: 'مهمتان',
      one: 'مهمة واحدة',
    );
    return 'المحطة A · تسجيل الفعلي · $_temp0';
  }

  @override
  String get tasksRefreshAction => 'تحديث';

  @override
  String get tasksRefreshing => 'جارٍ التحديث…';

  @override
  String get tasksSyncLoading => 'تحميل المهام · المزامنة منفصلة';

  @override
  String tasksSyncPending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حدث معلّق',
      many: '$count حدثًا معلّقًا',
      few: '$count أحداث معلّقة',
      two: 'حدثان معلّقان',
      one: 'حدث معلّق واحد',
    );
    return '$_temp0 · لم يؤكدها الخادم';
  }

  @override
  String get tasksSyncNone => 'لا توجد تحديثات تنفيذ في الانتظار';

  @override
  String get tasksFeedOnline =>
      'تحديثات المهام المباشرة تعمل · الاتصال ليس تأكيدًا للمزامنة';

  @override
  String get tasksFeedOffline =>
      'تحديثات المهام متوقفة · أعد الاتصال لرؤية المهام الحالية';

  @override
  String get tasksLoadingMessage => 'جارٍ تحميل مهامي…';

  @override
  String get tasksEmptyTitle => 'لا توجد مهام مسندة';

  @override
  String get tasksEmptyMessage =>
      'ستظهر المهام الجديدة عبر التحديثات المباشرة. ويمكنك أيضًا تحديث القائمة.';

  @override
  String get tasksErrorMessage =>
      'فشل الطلب. أعد المحاولة لطلب مهامك مرة أخرى.';

  @override
  String get tasksErrorNoticeTitle => 'قائمة المهام غير متاحة';

  @override
  String get tasksErrorNoticeMessage =>
      'تعذّر تحميل قائمة المهام. هذا لا يعني أنه لا توجد مهام، ولم تتغير أي مهمة أو تحديث.';

  @override
  String get tasksLoadingNoticeTitle => 'جارٍ تحميل مهامك';

  @override
  String get tasksLoadingNoticeMessage =>
      'الطلب قيد التنفيذ. التحميل لا يعني عدم وجود مهام.';

  @override
  String get tasksOfflineEmptyTitle => 'غير متصل · لا توجد مهام محفوظة';

  @override
  String tasksOfflineEmptyMessage(String name) {
    return 'لا توجد مهام محفوظة على هذا الجهاز لـ $name. اتصل بالشبكة لتحميل المهام.';
  }

  @override
  String get tasksOfflineCachedTitle =>
      'غير متصل · المهام المحفوظة قد تكون قديمة';

  @override
  String tasksOfflineCachedMessage(String time) {
    return 'آخر حفظ: $time. افتح المهمة المحفوظة لتسجيل التنفيذ الفعلي؛ التحديثات غير المرسلة تبقى على هذا الجهاز.';
  }

  @override
  String get tasksOfflineCachedMessageNoTime =>
      'افتح المهمة المحفوظة لتسجيل التنفيذ الفعلي؛ التحديثات غير المرسلة تبقى على هذا الجهاز.';

  @override
  String get tasksUpdateTitle => 'وصل تحديث على المهام';

  @override
  String tasksUpdateMessage(String reference) {
    return 'وصل تحديث للمهمة $reference. راجعه في تفاصيل المهمة. تحديثاتك المعلّقة لن تُستبدل.';
  }

  @override
  String get tasksLockedTitle => 'المخطط غيّر مهمة';

  @override
  String tasksLockedMessage(String reference) {
    return 'المهمة $reference أُلغيت أو استُبدلت بخطة أحدث. تم إيقاف إجراءاتها.';
  }

  @override
  String tasksPendingTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count تحديث محلي في انتظار القبول',
      many: '$count تحديثًا محليًا في انتظار القبول',
      few: '$count تحديثات محلية في انتظار القبول',
      two: 'تحديثان محليان في انتظار القبول',
      one: 'تحديث محلي واحد في انتظار القبول',
    );
    return '$_temp0';
  }

  @override
  String tasksPendingMessage(String action, String time) {
    return 'تم حفظ $action على هذا الجهاز الساعة $time. الحالة المؤكدة من الخادم تبقى كما هي حتى القبول.';
  }

  @override
  String get tasksEmptyNoticeTitle => 'تم استلام قائمة المهام';

  @override
  String tasksEmptyNoticeMessage(String name) {
    return 'لا توجد مهام مسندة إلى $name في رد الخادم الحالي.';
  }

  @override
  String get tasksScopeTitle => 'مهامك المسندة فقط';

  @override
  String tasksScopeMessage(String name) {
    return 'تم الدخول باسم $name. افتح المهمة لتقر بها وتسجّل التنفيذ الفعلي في تفاصيل المهمة.';
  }

  @override
  String get tasksScopeTugTitle => 'مهامك كقائد قاطرة';

  @override
  String get tasksScopeCtTitle => 'نطاق محطتك';

  @override
  String tasksScopeCtMessage(String name) {
    return 'تم الدخول باسم $name. عمليات المحطة التي تحتاج تسجيل الحالة الفعلية. لا تظهر سجلات محطات أخرى.';
  }

  @override
  String taskTugRef(String tug) {
    return 'القاطرة $tug';
  }

  @override
  String get taskCached => 'محفوظة';

  @override
  String get taskBerth => 'الرصيف';

  @override
  String get taskScheduledTime => 'الوقت المخطط';

  @override
  String get taskType => 'نوع المهمة';

  @override
  String get taskLocalUpdate => 'تحديث التنفيذ المحلي';

  @override
  String taskLocalSaved(String action) {
    return '$action · محفوظ على الجهاز';
  }

  @override
  String get taskLocalNone => 'لا يوجد';

  @override
  String get taskSynchronization => 'المزامنة';

  @override
  String get taskSyncPending => 'معلّق · لم يؤكده الخادم';

  @override
  String get taskSyncSending => 'جارٍ الإرسال · في انتظار الرد';

  @override
  String get taskSyncRejected => 'مرفوض · راجع صندوق الصادر';

  @override
  String get taskSyncNone => 'لا يوجد تحديث في الانتظار لهذه المهمة';

  @override
  String get taskOpenAction => 'فتح المهمة';

  @override
  String get taskServer => 'الخادم';

  @override
  String get taskServerCached => 'الخادم · محفوظ';

  @override
  String get taskServerNoUpdate => 'لم يُسجّل أي تحديث تنفيذ';

  @override
  String get taskDetailsTitle => 'تفاصيل المهمة وتحديث الحالة';

  @override
  String taskDetailsSubtitle(String reference, String type) {
    return 'المهمة $reference · $type';
  }

  @override
  String get taskDetailsSubtitleEmpty => 'التنفيذ الميداني';

  @override
  String get taskLoadingTitle => 'جارٍ تحميل تفاصيل المهمة…';

  @override
  String get taskLoadingMessage =>
      'جارٍ جلب المهمة من الخادم. البيانات المحفوظة تبقى ظاهرة إن وُجدت.';

  @override
  String get taskLoadingData => 'جارٍ تحميل بيانات المهمة…';

  @override
  String get taskNoDataNoticeTitle => 'بيانات المهمة غير متاحة';

  @override
  String get taskNoDataNoticeMessage =>
      'لا يوجد سجل مهمة لعرضه. هذا لا يعني أن المهمة اكتملت.';

  @override
  String get taskNoDataTitle => 'لا توجد بيانات للمهمة';

  @override
  String get taskNoDataMessage =>
      'تفاصيل المهمة غير متاحة على هذا الجهاز. ارجع إلى مهامي لمراجعة عملك.';

  @override
  String get taskCancelledTitle => 'المخطط ألغى المهمة';

  @override
  String get taskCancelledMessage =>
      'تم إلغاء هذه المهمة. الإجراءات متوقفة؛ وأي تحديث محلي يبقى في صندوق الصادر لكن لا يمكن تطبيقه.';

  @override
  String get taskOverriddenTitle => 'استُبدلت بخطة أحدث';

  @override
  String get taskOverriddenMessage =>
      'نسخة أحدث من الخطة استبدلت هذه المهمة. الإجراءات متوقفة؛ وأي تحديث محلي يُحفظ للمراجعة ولا يُطبّق.';

  @override
  String get taskRejectedTitle => 'رفضه الخادم · التحديث محفوظ';

  @override
  String get taskSyncFailedTitle => 'فشلت المزامنة · التحديث محفوظ';

  @override
  String taskSyncFailedMessage(String action) {
    return 'لم يقبل الخادم $action بعد. تحديثك المحلي وبيانات المهمة المحفوظة ما زالت متاحة.';
  }

  @override
  String get taskOfflineTitle => 'غير متصل · استخدام بيانات المهمة المحفوظة';

  @override
  String get taskOfflineMessage =>
      'يمكنك تسجيل التنفيذ الفعلي. التحديثات المحفوظة تبقى على الجهاز وفي صندوق الصادر حتى يقبلها الخادم.';

  @override
  String get taskUpdatedTitle => 'وصل تغيير في الخطة · راجع المهمة';

  @override
  String get taskUpdatedMessage =>
      'المخطط حدّث هذه المهمة. راجع التفاصيل بالأسفل؛ تحديثاتك المحلية محفوظة.';

  @override
  String get taskPendingTitle => 'تحديث محلي في انتظار المزامنة';

  @override
  String taskPendingMessage(String action) {
    return '$action محفوظ على هذا الجهاز وفي انتظار الإرسال. الاتصال لا يعني أن الخادم قبله.';
  }

  @override
  String get taskConfirmedTitle => 'الخادم أكّد تحديث التنفيذ';

  @override
  String taskConfirmedMessage(String action, String time) {
    return 'قبل الخادم $action الساعة $time. خرج هذا التحديث من قائمة صندوق الصادر.';
  }

  @override
  String get taskAcknowledgedTitle => 'تم الإقرار بالمهمة';

  @override
  String get taskAcknowledgedMessage =>
      'تم تسجيل إقرارك. الإقرار لا يسجّل قيد التنفيذ أو تم التنفيذ؛ احفظ حالة التنفيذ بشكل منفصل.';

  @override
  String get taskNotAcknowledgedTitle => 'لم يتم الإقرار بعد';

  @override
  String get taskNotAcknowledgedMessage =>
      'فتح المهمة لا يعني الإقرار بها. استخدم زر الإقرار؛ وتحديثات التنفيذ تظل متاحة.';

  @override
  String get taskInfoTitle => 'معلومات المهمة';

  @override
  String get taskInfoTitleCached => 'معلومات المهمة · محفوظة';

  @override
  String get taskVesselName => 'اسم السفينة';

  @override
  String get taskPlannedTime => 'الوقت المخطط';

  @override
  String get taskAssignedBerth => 'الرصيف المحدد';

  @override
  String get taskAssignedTugs => 'القاطرات المحددة';

  @override
  String get taskAssignedPilot => 'المرشد البحري المحدد';

  @override
  String get taskPlanReference => 'مرجع الخطة / المهمة';

  @override
  String get taskAckTitle => 'الإقرار بالمهمة';

  @override
  String get taskAckNotYet => 'لم يتم الإقرار بعد';

  @override
  String taskAckDone(String time) {
    return 'أقررت بها · $time';
  }

  @override
  String taskAckSaved(String time) {
    return 'تم الإقرار · محفوظ على الجهاز $time';
  }

  @override
  String get taskAcknowledgeAction => 'إقرار';

  @override
  String get taskAcknowledgedBadge => 'تم الإقرار';

  @override
  String get taskUpdateTitle => 'تحديث حالة المهمة';

  @override
  String taskServerConfirmed(String status) {
    return 'الحالة المؤكدة من الخادم: $status';
  }

  @override
  String taskLatestLocal(String status) {
    return 'آخر تحديث محلي: $status';
  }

  @override
  String get taskSelectionNote =>
      'اختر الحالة ثم احفظ. الاختيار وحده لا يُحفظ.';

  @override
  String get taskSaveAction => 'حفظ تحديث الحالة';

  @override
  String get taskSaveSyncLabel => 'الحفظ والمزامنة';

  @override
  String get taskSyncNoTask => 'لا يوجد سجل للمهمة على الجهاز';

  @override
  String get taskSyncNoTaskNote => 'الاتصال لا يؤكد توفّر المهمة.';

  @override
  String get taskSyncAckSeparate => 'الإقرار منفصل عن حالة التنفيذ.';

  @override
  String get taskSyncRejectedTitle => 'رفضه الخادم';

  @override
  String get taskSyncRejectedNote => 'محفوظ في صندوق الصادر كمرفوض.';

  @override
  String get taskSyncFailedShort => 'فشلت المزامنة';

  @override
  String get taskSyncFailedNote =>
      'لم يُقبل بعد · محفوظ في صندوق الصادر كمعلّق.';

  @override
  String get taskSyncPendingOffline => 'في انتظار المزامنة · غير متصل';

  @override
  String taskSyncCachedAt(String time) {
    return 'آخر حفظ للمهمة: $time';
  }

  @override
  String get taskSyncPendingTitle => 'في انتظار المزامنة';

  @override
  String get taskSyncSendingTitle => 'جارٍ الإرسال';

  @override
  String get taskSyncWaitingNote => 'في انتظار الإرسال؛ قبول الخادم لم يتأكد.';

  @override
  String get taskSyncDoneTitle => 'تم · أكّده الخادم';

  @override
  String taskSyncDoneNote(String saved, String accepted) {
    return 'الحفظ على الجهاز: $saved · القبول: $accepted';
  }

  @override
  String get taskOutboxLabel => 'صندوق الصادر';

  @override
  String taskOutboxRetained(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count تحديث محفوظ',
      many: '$count تحديثًا محفوظًا',
      few: '$count تحديثات محفوظة',
      two: 'تحديثان محفوظان',
      one: 'تحديث واحد محفوظ',
    );
    return 'صندوق الصادر · $_temp0';
  }

  @override
  String taskOutboxWaiting(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count تحديث في انتظار المزامنة',
      many: '$count تحديثًا في انتظار المزامنة',
      few: '$count تحديثات في انتظار المزامنة',
      two: 'تحديثان في انتظار المزامنة',
      one: 'تحديث واحد في انتظار المزامنة',
    );
    return '$_temp0';
  }

  @override
  String get taskOutboxEmpty => 'لا توجد تحديثات في الانتظار';

  @override
  String get taskRetrySyncAction => 'إعادة المزامنة';

  @override
  String get syncTitle => 'حالة المزامنة وصندوق الصادر';

  @override
  String get syncStripSending => 'جارٍ الإرسال · في انتظار رد الخادم';

  @override
  String syncStripFailed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حدث معلّق محفوظ',
      many: '$count حدثًا معلّقًا محفوظًا',
      few: '$count أحداث معلّقة محفوظة',
      two: 'حدثان معلّقان محفوظان',
      one: 'حدث معلّق محفوظ',
    );
    return 'فشل المزامنة · $_temp0';
  }

  @override
  String get syncStripOffline => 'معلّق · الإرسال متوقف بدون اتصال';

  @override
  String syncStripRejected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حدث مرفوض · محفوظة',
      many: '$count حدثًا مرفوضًا · محفوظة',
      few: '$count أحداث مرفوضة · محفوظة',
      two: 'حدثان مرفوضان · محفوظان',
      one: 'حدث مرفوض واحد · محفوظ',
    );
    return '$_temp0';
  }

  @override
  String get syncStripConfirmed => 'تم تأكيد المزامنة';

  @override
  String get syncStripNone => 'لا توجد أحداث معلّقة';

  @override
  String get syncStripCaption =>
      'الحفظ على الجهاز ← الإرسال ← قبول الخادم خطوات منفصلة';

  @override
  String get syncSendingAction => 'جارٍ الإرسال…';

  @override
  String get syncRetryAction => 'أعد المحاولة الآن';

  @override
  String get syncRefreshAction => 'تحديث الحالة';

  @override
  String get syncCountPending => 'أحداث معلّقة';

  @override
  String get syncCountDone => 'أحداث تمت';

  @override
  String get syncCountRejected => 'أحداث مرفوضة';

  @override
  String syncListTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سجل محفوظ',
      many: '$count سجلًا محفوظًا',
      few: '$count سجلات محفوظة',
      two: 'سجلان محفوظان',
      one: 'سجل واحد محفوظ',
      zero: 'لا يوجد',
    );
    return 'أحداث الجهاز · $_temp0';
  }

  @override
  String get syncEmptyTitle => 'لا توجد أحداث على هذا الجهاز';

  @override
  String get syncEmptyMessage =>
      'الإقرارات وتحديثات الحالة التي تحفظها ستظهر هنا حتى يؤكدها الخادم.';

  @override
  String syncOwnership(String username) {
    return 'سجّلها: $username · الأحداث تبقى على هذا الجهاز';
  }

  @override
  String get syncOwnershipNote =>
      'لا حذف ولا نقل بدون علمك. انقطاع الاتصال أو إعادة الدخول لا يغيّر صاحب الحدث.';

  @override
  String get syncWipedTitle => 'تم مسح الجهاز';

  @override
  String get syncWipedMessage =>
      'الأحداث المعلّقة على جهاز تم مسحه أو إعادة تثبيت التطبيق عليه تضيع. الأحداث المكتملة تُحذف بعد 30 يومًا.';

  @override
  String get syncSendingTitle => 'الإرسال جارٍ';

  @override
  String get syncSendingMessage =>
      'الأحداث في حالة إرسال أثناء الطلب، وترجع معلّقة إذا فشل الإرسال. الإرسال ليس قبولًا من الخادم.';

  @override
  String get syncFailedTitle => 'فشل الإرسال · يمكن إعادة المحاولة';

  @override
  String get syncFailedMessage =>
      'فشلت محاولة الإرسال قبل رد الخادم. الأحداث المحفوظة تبقى معلّقة وتُعاد المحاولة تلقائيًا. الأحداث التي لم تُرسل تضيع إذا تم مسح الجهاز.';

  @override
  String get syncOfflineTitle => 'محفوظ هنا؛ لم يُرسل';

  @override
  String syncOfflineMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حدث باقٍ',
      many: '$count حدثًا باقيًا',
      few: '$count أحداث باقية',
      two: 'حدثان باقيان',
      one: 'حدث واحد باقٍ',
    );
    return '$_temp0 على هذا الجهاز. أعد الاتصال للإرسال باسم من سجّلها؛ الحفظ بدون اتصال ليس قبولًا من الخادم.';
  }

  @override
  String get syncRejectedTitle => 'رفض نهائي من الخادم';

  @override
  String get syncRejectedMessage =>
      'الحدث المرفوض يبقى ظاهرًا مع سببه. إعادة المحاولة لا تتجاوز الرفض.';

  @override
  String get syncWaitingTitle => 'في انتظار الإرسال';

  @override
  String get syncWaitingMessage =>
      'الأحداث المحفوظة تُرسل بالترتيب بمجرد الوصول للخادم.';

  @override
  String get syncConfirmedTitle => 'الخادم أكّد الاستلام';

  @override
  String get syncConfirmedMessage =>
      'الحدث يصبح مكتملًا فقط بعد قبول الخادم. السجل المؤكد يبقى ظاهرًا.';

  @override
  String get syncEventLabel => 'الحدث / تحديث الحالة';

  @override
  String syncEventStatus(String status) {
    return 'التنفيذ الفعلي: $status';
  }

  @override
  String get syncRecordedLabel => 'سُجّل على الجهاز';

  @override
  String get syncRelatedLabel => 'المهمة المرتبطة';

  @override
  String syncRelatedValue(String terminal, String berth) {
    return '$terminal · الرصيف $berth';
  }

  @override
  String get syncDeviceSaveLabel => 'الحفظ على الجهاز';

  @override
  String get syncDeviceSaved => 'محفوظ على الجهاز';

  @override
  String get syncDispatchOffline => 'لم يُرسل · بدون اتصال';

  @override
  String get syncEventPendingNote =>
      'المعلّق ليس مكتملًا: الخادم لم يؤكد هذا التحديث.';

  @override
  String get syncEventFailedNote =>
      'فشلت محاولة الإرسال السابقة. يبقى معلّقًا حتى يقبله الخادم.';

  @override
  String syncEventRejectedNote(String reason) {
    return 'سبب الرفض: $reason';
  }

  @override
  String get syncEventDoneNote =>
      'سجل مؤكد · الأحداث المكتملة تبقى على الجهاز 30 يومًا ثم تُحذف.';

  @override
  String get settingsTitle => 'الإعدادات والجلسة';

  @override
  String get settingsLoading => 'جارٍ تحميل الإعدادات…';

  @override
  String get settingsStripNoEvents => 'لا توجد أحداث تنفيذ معلّقة';

  @override
  String get settingsStripNone =>
      'الجهاز: لا تحديث في الانتظار · الإرسال: لا يوجد · الخادم: لا قبول جديد';

  @override
  String get settingsStripUnknown =>
      'حالة الاتصال غير متاحة · المزامنة غير مؤكدة';

  @override
  String settingsStripPending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حدث معلّق',
      many: '$count حدثًا معلّقًا',
      few: '$count أحداث معلّقة',
      two: 'حدثان معلّقان',
      one: 'حدث معلّق واحد',
    );
    return '$_temp0 · محفوظ على الجهاز';
  }

  @override
  String settingsStripPendingCaption(String action) {
    return 'الجهاز: محفوظ · الإرسال: لم يُرسل · الخادم: $action غير مؤكد';
  }

  @override
  String get settingsReadOnlyTitle => 'معلومات للعرض فقط';

  @override
  String get settingsReadOnlyMessage =>
      'المستخدم الحالي والجهاز الحالي فقط. لا يمكن تعديل بيانات الحساب أو الميناء أو التطبيق من هنا.';

  @override
  String get settingsPendingTitle => 'راجع التحديثات غير المرسلة قبل الخروج';

  @override
  String get settingsPendingMessage =>
      'تسجيل الخروج لا يحذف الأحداث المعلّقة ولا ينقلها. راجع صندوق الإرسال الآن؛ الإرسال يحتاج دخول نفس المستخدم مرة أخرى.';

  @override
  String get settingsUnknownTitle => 'غير معروف لا يعني بدون اتصال';

  @override
  String get settingsUnknownMessage =>
      'التطبيق لا يستطيع تحديد حالة الاتصال الآن. لا نقول إنه بدون اتصال ولا إن المزامنة نجحت؛ بيانات الحساب المتاحة تبقى للعرض فقط.';

  @override
  String get settingsAccountTitle => 'الحساب';

  @override
  String get settingsAccountName => 'اسم الحساب';

  @override
  String get settingsUsername => 'اسم المستخدم';

  @override
  String get settingsRole => 'الدور المعيّن';

  @override
  String get settingsPortTitle => 'الميناء';

  @override
  String get settingsPortName => 'اسم الميناء';

  @override
  String get settingsPortId => 'معرّف الميناء';

  @override
  String get settingsPortNote => 'بيانات الميناء من الخادم';

  @override
  String get settingsNotAvailable => 'غير متاح';

  @override
  String get settingsAppTitle => 'التطبيق والجهاز';

  @override
  String get settingsVersion => 'الإصدار المثبّت';

  @override
  String get settingsDevice => 'معلومات الجهاز';

  @override
  String get settingsConnection => 'الاتصال الحالي';

  @override
  String get settingsAppNote =>
      'تظهر فقط المعلومات المتاحة لهذا التطبيق. اللغة: الإنجليزية أو العربية (اتجاه من اليمين لليسار). التحديثات المعلّقة تبقى على الجهاز عند انتهاء الجلسة.';

  @override
  String get settingsSessionTitle => 'الجلسة';

  @override
  String get settingsSessionMessage =>
      'تسجيل الخروج ينهي الجلسة على هذا الجهاز.';

  @override
  String settingsSessionPending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حدث معلّق',
      many: '$count حدثًا معلّقًا',
      few: '$count أحداث معلّقة',
      two: 'حدثان معلّقان',
      one: 'حدث معلّق واحد',
    );
    return '$_temp0 · يبقى باسم المستخدم الأصلي';
  }

  @override
  String get settingsReviewOutbox => 'مراجعة صندوق الإرسال';

  @override
  String get settingsLogOut => 'تسجيل الخروج';

  @override
  String get logoutDialogTitle => 'تسجيل الخروج من هذا الجهاز؟';

  @override
  String get logoutDialogMessage => 'ستنتهي جلستك الحالية.';

  @override
  String logoutDialogMessagePending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count تحديث غير مرسل يبقى',
      many: '$count تحديثًا غير مرسل يبقى',
      few: '$count تحديثات غير مرسلة تبقى',
      two: 'تحديثان غير مرسلين يبقيان',
      one: 'تحديث واحد غير مرسل يبقى',
    );
    return 'ستنتهي جلستك الحالية. $_temp0 معلّقًا على هذا الجهاز وقد يحتاج دخولًا جديدًا.';
  }

  @override
  String logoutRetainedTitle(String action) {
    return '$action · محفوظ على الجهاز · لم يُرسل ولم يُقبل';
  }

  @override
  String logoutRetainedMessage(String username) {
    return 'المالك: $username. سجّل الدخول مرة أخرى بنفس المستخدم للمزامنة. الأحداث لا تُحذف ولا تُنقل عند الخروج.';
  }

  @override
  String get logoutReviewPending => 'مراجعة الأحداث المعلّقة';

  @override
  String get logoutConfirm => 'تأكيد الخروج';

  @override
  String get signedOutHeader => 'العمليات الميدانية · تم الخروج';

  @override
  String get signedOutTitle => 'تم تسجيل خروجك';

  @override
  String get signedOutMessage =>
      'انتهت جلسة الجهاز الحالية. سجّل الدخول مرة أخرى للرجوع إلى التطبيق.';

  @override
  String signedOutPendingTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count تحديث غير مرسل يبقى',
      many: '$count تحديثًا غير مرسل يبقى',
      few: '$count تحديثات غير مرسلة تبقى',
      two: 'تحديثان غير مرسلين يبقيان',
      one: 'تحديث واحد غير مرسل يبقى',
    );
    return '$_temp0 معلّقًا على هذا الجهاز';
  }

  @override
  String signedOutPendingMessage(String username) {
    return 'المستخدم الذي سجّله: $username. سجّل الدخول بنفس المستخدم قبل المزامنة؛ لا يستطيع مستخدم آخر إرسال هذا الحدث.';
  }

  @override
  String get signedOutDeviceRecord => 'سجل الجهاز';

  @override
  String signedOutDeviceRecordValue(String action, String time) {
    return '$action · حُفظ الساعة $time · محفوظ';
  }

  @override
  String get signedOutDispatchValue => 'متوقف · لا توجد جلسة نشطة';

  @override
  String get signedOutFootnote =>
      'الخروج لم يرسل الأحداث المعلّقة ولم يحذفها ولم ينقلها. لا تظهر هنا أي إعدادات للحساب.';

  @override
  String get notifStripLoading => 'جارٍ استلام الإشعارات…';

  @override
  String get notifStripLoadingCaption => 'المزامنة لم تتأكد بعد';

  @override
  String get notifStripError => 'التحديث غير متاح';

  @override
  String get notifStripOffline => 'بدون اتصال · عرض الإشعارات المحفوظة';

  @override
  String get notifStripReceived => 'تم استلام التحديثات من خادم الميناء';

  @override
  String notifLastSync(String time) {
    return 'آخر مزامنة للقائمة: $time';
  }

  @override
  String get notifCachedCaption =>
      'محفوظة على هذا الجهاز؛ الإشعارات الجديدة تصل بعد عودة الاتصال';

  @override
  String get notifErrorTitle => 'تعذّر تحديث الإشعارات';

  @override
  String get notifErrorMessage =>
      'الاتصال بخادم الميناء غير متاح. هذا خطأ في تحميل القائمة، وليس حالة إشعار فشل.';

  @override
  String get notifOfflineTitle => 'بدون اتصال';

  @override
  String get notifOfflineMessage =>
      'الإقرارات التي تقوم بها الآن تُحفظ على الجهاز وتُرسل عند عودة الاتصال.';

  @override
  String get notifFailedTitle => 'تعذّر توصيل أحد الإشعارات';

  @override
  String get notifFailedMessage =>
      'فشل يعني أن النظام لم يستطع توزيعه. الإقرار لا يحل المشكلة، ولا يوجد إعادة إرسال يدوي. افتح المهمة للتحقق منها.';

  @override
  String get notifFilterAll => 'الكل';

  @override
  String get notifListTitle => 'إشعاراتي';

  @override
  String notifListTitleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count',
      zero: 'لا يوجد',
    );
    return 'إشعاراتي · $_temp0 · الأحدث أولًا';
  }

  @override
  String get notifLoadingMessage => 'جارٍ تحميل الإشعارات…';

  @override
  String get notifEmptyTitle => 'لا توجد إشعارات';

  @override
  String get notifEmptyMessage =>
      'المهام الجديدة والتذكيرات والخطط الملغاة ستظهر هنا.';

  @override
  String get notifErrorListMessage =>
      'تعذّر تحميل الإشعارات الجديدة والحالات الحالية.';

  @override
  String get notifFilteredEmptyTitle => 'لا توجد إشعارات تطابق الفلتر';

  @override
  String notifFilteredEmptyMessage(String status) {
    return 'لا يوجد شيء بحالة «$status». امسح الفلتر لعرض كل إشعاراتك.';
  }

  @override
  String get notifClearFilter => 'مسح الفلتر';

  @override
  String get notifExplainTitle => 'فهم الحالة والتوصيل';

  @override
  String get notifExplainStatus =>
      'مُرسل = أرسله النظام، وليس تأكيد وصوله للجهاز. فشل = فشل في التوزيع. تم الإقرار = إقرار المستخدم، وليس دليلًا على مزامنة الجهاز.';

  @override
  String get notifExplainOffline =>
      'الإقرارات بدون اتصال تنتظر في صندوق الإرسال حتى يقبلها الخادم.';

  @override
  String get notifMessageAssignment => 'تم تعيينك لهذه المهمة.';

  @override
  String get notifMessageReminder => 'هذه المهمة ستبدأ قريبًا.';

  @override
  String get notifMessageCancelled =>
      'تم إلغاء خطة هذه المهمة. لا توجد إجراءات أخرى ممكنة.';

  @override
  String get notifNoteSent =>
      'تم الإرسال من النظام. قم بالإقرار لتأكيد أنك رأيته.';

  @override
  String get notifNoteAckPending =>
      'الإقرار محفوظ على الجهاز · في انتظار قبول الخادم.';

  @override
  String get notifNoteFailed =>
      'فشل التوزيع. الإقرار لا يحل المشكلة؛ لا يوجد إعادة إرسال يدوي.';

  @override
  String notifNoteAcknowledged(String time) {
    return 'تم الإقرار الساعة $time. إقرار المستخدم فقط.';
  }

  @override
  String get notifRelatedTask => 'المهمة المرتبطة';

  @override
  String get notifTimestamp => 'وقت الاستلام';

  @override
  String get notifOpenTask => 'فتح المهمة';

  @override
  String get notifAcknowledge => 'إقرار';

  @override
  String get notifAckSavedAction => 'محفوظ · في انتظار المزامنة';

  @override
  String get notifAckSavedBadge => 'إقرار معلّق';
}
