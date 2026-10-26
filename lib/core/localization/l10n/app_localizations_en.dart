// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'ATLANTECH';

  @override
  String get fieldOperations => 'Field Operations';

  @override
  String get titlePortIdentification => 'Port Identification';

  @override
  String get titleSignIn => 'Sign in';

  @override
  String get titleMyTasks => 'My Tasks';

  @override
  String get titleTaskDetails => 'Task Details';

  @override
  String get titleSyncOutbox => 'Sync and Outbox';

  @override
  String get titleNotifications => 'Notifications';

  @override
  String get titleAccessDenied => 'Access Denied';

  @override
  String get titleAppUpdateRequired => 'App Update Required';

  @override
  String get titleSettings => 'Settings';

  @override
  String get continueAction => 'Continue';

  @override
  String get cancelAction => 'Cancel';

  @override
  String get confirmAction => 'Confirm';

  @override
  String get backAction => 'Back';

  @override
  String get switchLanguage => 'العربية';

  @override
  String get connectionOnline => 'Online';

  @override
  String get connectionOffline => 'Offline';

  @override
  String get requiredMark => 'Required';

  @override
  String get roleMarinePilot => 'Marine Pilot';

  @override
  String get roleTugMaster => 'Tug Master';

  @override
  String get roleCtSupervisor => 'CT Supervisor';

  @override
  String get roleNctSupervisor => 'NCT Supervisor';

  @override
  String get roleUnsupported => 'Unsupported role';

  @override
  String get devMockSignIn => 'Mock sign-in as Pilot';

  @override
  String get devMockSignInUnsupported => 'Mock sign-in as unsupported role';

  @override
  String get devMockSignOut => 'Mock sign-out';

  @override
  String get devOpenSampleTask => 'Open sample task';

  @override
  String placeholderNote(String taskId) {
    return 'This screen will be built in task $taskId';
  }
}
