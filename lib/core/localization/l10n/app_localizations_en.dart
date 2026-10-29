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
  String get placeholderNote => 'This screen will be built in a later task.';

  @override
  String get splashStatus => 'Preparing your workspace';

  @override
  String get loading => 'Loading';

  @override
  String get retryAction => 'Try again';

  @override
  String get stateEmptyTitle => 'Nothing here yet';

  @override
  String get stateEmptyMessage =>
      'When there is something to show, it will appear here.';

  @override
  String get stateErrorTitle => 'Something went wrong';

  @override
  String get stateErrorMessage =>
      'This page could not be loaded. Try again in a moment.';

  @override
  String get stateOfflineTitle => 'You are offline';

  @override
  String get stateOfflineMessage =>
      'Nothing is saved on this device yet. Connect to the port network and try again.';

  @override
  String get pageNotFoundTitle => 'Page not found';

  @override
  String get pageNotFoundMessage => 'This page does not exist or has moved.';

  @override
  String get backToStartAction => 'Back to start';

  @override
  String get devPreviewStates => 'Preview page states';

  @override
  String get devStateEmpty => 'Empty';

  @override
  String get devStateError => 'Error';

  @override
  String get devStateOffline => 'Offline';

  @override
  String get updateRequiredTitle => 'Update the app to continue';

  @override
  String get updateRequiredMessage =>
      'This version of ATLANTECH is no longer supported by the port server. Ask your port IT team to install the latest version on this device. Changes saved on this device are kept.';

  @override
  String get updateInstalledVersion => 'Installed version';

  @override
  String get updateRequiredVersion => 'Required version';

  @override
  String get devMockUpdateRequired => 'Simulate update required (426)';

  @override
  String get accessDeniedTitle => 'You do not have access to this';

  @override
  String get accessDeniedPermissionMessage =>
      'Your role or terminal scope does not allow this page or action. Changes saved on this device are kept.';

  @override
  String get accessDeniedRoleMessage =>
      'This app is for Marine Pilots, Tug Masters and CT Supervisors. Your account has a different role, so sign in with a field account or use the web dashboard.';

  @override
  String get accessDeniedReasonLabel => 'Reason';

  @override
  String get accessDeniedReasonPermission => 'Role or terminal scope';

  @override
  String get accessDeniedReasonRole => 'Not a field role';

  @override
  String get backToMyTasksAction => 'Back to My Tasks';

  @override
  String get signOutAction => 'Sign out';

  @override
  String get devMockAccessDenied => 'Simulate access denied (403)';
}
