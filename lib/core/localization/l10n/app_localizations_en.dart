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
  String get updateRequiredTitle => 'App Update Required';

  @override
  String get updateRequiredMessage =>
      'This version of ATLANTECH is no longer supported. Update the app to continue.';

  @override
  String get updateInstalledVersion => 'Current installed version';

  @override
  String get updateRequiredVersion => 'Required version';

  @override
  String get updateRequiredVersionUnknown => 'Not sent by the server';

  @override
  String get updateNoticeTitle => 'Install the new version';

  @override
  String get updateNoticeMessage =>
      'The update reaches the port as an APK file, or your administrator installs it on this tablet. App access stays blocked until it is installed.';

  @override
  String get updateGuidance => 'Administrator guidance required';

  @override
  String get updateBlocked => 'Blocked until the required update is installed.';

  @override
  String get updateOutboxNote =>
      'The version check does not send or confirm Outbox items. Changes saved on this device are kept under the user who recorded them.';

  @override
  String get devMockUpdateRequired => 'Simulate update required (426)';

  @override
  String get accessDeniedTitle => 'Access Denied';

  @override
  String get accessDeniedPermissionMessage =>
      'You do not have permission to access the requested page or action.';

  @override
  String get accessDeniedRoleMessage => 'This app is for field roles only.';

  @override
  String get accessDeniedReasonLabel => 'Reason';

  @override
  String get accessDeniedReasonPermission =>
      'Your role or terminal scope does not allow this page or action.';

  @override
  String get accessDeniedReasonRole =>
      'Your role works on the web dashboard only.';

  @override
  String get accessDeniedContact =>
      'Contact your system administrator if you need access.';

  @override
  String get accessDeniedRoleContact =>
      'Use the ATLANTECH web dashboard, or sign in with a Marine Pilot, Tug Master or CT Supervisor account.';

  @override
  String get accessDeniedBackHint =>
      'Return to your task list. Changes saved on this device are kept.';

  @override
  String get accessDeniedSignOutHint =>
      'Sign out, then sign in with a field account.';

  @override
  String get backToMyTasksAction => 'Back to My Tasks';

  @override
  String get signOutAction => 'Sign out';

  @override
  String get devMockAccessDenied => 'Simulate access denied (403)';

  @override
  String get errorBadRequest => 'The request could not be processed.';

  @override
  String get errorUnauthenticated => 'Your session has ended. Sign in again.';

  @override
  String get errorInvalidCredentials =>
      'The username or password is incorrect.';

  @override
  String get errorForbidden =>
      'Your role or terminal scope does not allow this.';

  @override
  String get errorAccountDisabled =>
      'This account is disabled. Contact your system administrator.';

  @override
  String get errorPasswordChangeRequired => 'Change your password to continue.';

  @override
  String get errorNotFound => 'This record no longer exists.';

  @override
  String get errorVersionConflict =>
      'This record was changed by someone else. The latest version is shown.';

  @override
  String get errorValidationFailed =>
      'Some of the data is not valid. Check the fields and try again.';

  @override
  String get errorIdempotencyKeyReused =>
      'This request was already sent with different data.';

  @override
  String get errorLicenseReadOnly =>
      'The port licence is read-only. New changes cannot be saved.';

  @override
  String get errorAppUpdateRequired =>
      'This version of the app is no longer supported. Update the app to continue.';

  @override
  String get errorTooManyAttempts =>
      'Too many attempts. Wait a moment, then try again.';

  @override
  String get errorServerError =>
      'The server had a problem. Try again in a moment.';

  @override
  String get errorServiceUnavailable =>
      'The server is not available right now. Try again in a moment.';

  @override
  String get errorNetwork =>
      'The port server cannot be reached. Check the port network and try again.';

  @override
  String get errorTimeout =>
      'The port server took too long to answer. Try again.';

  @override
  String get errorUntrustedServer =>
      'This network is not the port network. Connect to the port network and try again.';

  @override
  String get errorUnknown => 'Something went wrong. Try again in a moment.';
}
