import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'ATLANTECH'**
  String get appName;

  /// No description provided for @titlePortIdentification.
  ///
  /// In en, this message translates to:
  /// **'Port Identification'**
  String get titlePortIdentification;

  /// No description provided for @titleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get titleSignIn;

  /// No description provided for @titleMyTasks.
  ///
  /// In en, this message translates to:
  /// **'My Tasks'**
  String get titleMyTasks;

  /// No description provided for @titleTaskDetails.
  ///
  /// In en, this message translates to:
  /// **'Task Details'**
  String get titleTaskDetails;

  /// No description provided for @titleSyncOutbox.
  ///
  /// In en, this message translates to:
  /// **'Sync and Outbox'**
  String get titleSyncOutbox;

  /// No description provided for @titleNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get titleNotifications;

  /// No description provided for @titleAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'Access Denied'**
  String get titleAccessDenied;

  /// No description provided for @titleAppUpdateRequired.
  ///
  /// In en, this message translates to:
  /// **'App Update Required'**
  String get titleAppUpdateRequired;

  /// No description provided for @titleSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get titleSettings;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;

  /// No description provided for @confirmAction.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmAction;

  /// No description provided for @backAction.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backAction;

  /// Label of the language toggle. Shows the language it switches to.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get switchLanguage;

  /// No description provided for @connectionOnline.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get connectionOnline;

  /// No description provided for @connectionOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get connectionOffline;

  /// No description provided for @requiredMark.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredMark;

  /// No description provided for @roleMarinePilot.
  ///
  /// In en, this message translates to:
  /// **'Marine Pilot'**
  String get roleMarinePilot;

  /// No description provided for @roleTugMaster.
  ///
  /// In en, this message translates to:
  /// **'Tug Master'**
  String get roleTugMaster;

  /// No description provided for @roleCtSupervisor.
  ///
  /// In en, this message translates to:
  /// **'CT Supervisor'**
  String get roleCtSupervisor;

  /// No description provided for @roleNctSupervisor.
  ///
  /// In en, this message translates to:
  /// **'NCT Supervisor'**
  String get roleNctSupervisor;

  /// No description provided for @roleUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Unsupported role'**
  String get roleUnsupported;

  /// No description provided for @devMockSignIn.
  ///
  /// In en, this message translates to:
  /// **'Mock sign-in as Pilot'**
  String get devMockSignIn;

  /// No description provided for @devMockSignInUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Mock sign-in as unsupported role'**
  String get devMockSignInUnsupported;

  /// No description provided for @devMockSignOut.
  ///
  /// In en, this message translates to:
  /// **'Mock sign-out'**
  String get devMockSignOut;

  /// No description provided for @devOpenSampleTask.
  ///
  /// In en, this message translates to:
  /// **'Open sample task'**
  String get devOpenSampleTask;

  /// No description provided for @placeholderNote.
  ///
  /// In en, this message translates to:
  /// **'This screen will be built in a later task.'**
  String get placeholderNote;

  /// No description provided for @splashStatus.
  ///
  /// In en, this message translates to:
  /// **'Preparing your workspace'**
  String get splashStatus;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @retryAction.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retryAction;

  /// No description provided for @stateEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get stateEmptyTitle;

  /// No description provided for @stateEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'When there is something to show, it will appear here.'**
  String get stateEmptyMessage;

  /// No description provided for @stateErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get stateErrorTitle;

  /// No description provided for @stateErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'This page could not be loaded. Try again in a moment.'**
  String get stateErrorMessage;

  /// No description provided for @stateOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'You are offline'**
  String get stateOfflineTitle;

  /// No description provided for @stateOfflineMessage.
  ///
  /// In en, this message translates to:
  /// **'Nothing is saved on this device yet. Connect to the port network and try again.'**
  String get stateOfflineMessage;

  /// No description provided for @pageNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get pageNotFoundTitle;

  /// No description provided for @pageNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'This page does not exist or has moved.'**
  String get pageNotFoundMessage;

  /// No description provided for @backToStartAction.
  ///
  /// In en, this message translates to:
  /// **'Back to start'**
  String get backToStartAction;

  /// No description provided for @devPreviewStates.
  ///
  /// In en, this message translates to:
  /// **'Preview page states'**
  String get devPreviewStates;

  /// No description provided for @devStateEmpty.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get devStateEmpty;

  /// No description provided for @devStateError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get devStateError;

  /// No description provided for @devStateOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get devStateOffline;

  /// No description provided for @updateRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'App Update Required'**
  String get updateRequiredTitle;

  /// No description provided for @updateRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'This version of ATLANTECH is no longer supported. Update the app to continue.'**
  String get updateRequiredMessage;

  /// No description provided for @updateInstalledVersion.
  ///
  /// In en, this message translates to:
  /// **'Current installed version'**
  String get updateInstalledVersion;

  /// No description provided for @updateRequiredVersion.
  ///
  /// In en, this message translates to:
  /// **'Required version'**
  String get updateRequiredVersion;

  /// No description provided for @updateRequiredVersionUnknown.
  ///
  /// In en, this message translates to:
  /// **'Not sent by the server'**
  String get updateRequiredVersionUnknown;

  /// No description provided for @updateNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Install the new version'**
  String get updateNoticeTitle;

  /// No description provided for @updateNoticeMessage.
  ///
  /// In en, this message translates to:
  /// **'The update reaches the port as an APK file, or your administrator installs it on this tablet. App access stays blocked until it is installed.'**
  String get updateNoticeMessage;

  /// No description provided for @updateGuidance.
  ///
  /// In en, this message translates to:
  /// **'Administrator guidance required'**
  String get updateGuidance;

  /// No description provided for @updateBlocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked until the required update is installed.'**
  String get updateBlocked;

  /// No description provided for @updateOutboxNote.
  ///
  /// In en, this message translates to:
  /// **'The version check does not send or confirm Outbox items. Changes saved on this device are kept under the user who recorded them.'**
  String get updateOutboxNote;

  /// No description provided for @devMockUpdateRequired.
  ///
  /// In en, this message translates to:
  /// **'Simulate update required (426)'**
  String get devMockUpdateRequired;

  /// No description provided for @accessDeniedTitle.
  ///
  /// In en, this message translates to:
  /// **'Access Denied'**
  String get accessDeniedTitle;

  /// No description provided for @accessDeniedPermissionMessage.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission to access the requested page or action.'**
  String get accessDeniedPermissionMessage;

  /// No description provided for @accessDeniedRoleMessage.
  ///
  /// In en, this message translates to:
  /// **'This app is for field roles only.'**
  String get accessDeniedRoleMessage;

  /// No description provided for @accessDeniedReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get accessDeniedReasonLabel;

  /// No description provided for @accessDeniedReasonPermission.
  ///
  /// In en, this message translates to:
  /// **'Your role or terminal scope does not allow this page or action.'**
  String get accessDeniedReasonPermission;

  /// No description provided for @accessDeniedReasonRole.
  ///
  /// In en, this message translates to:
  /// **'Your role works on the web dashboard only.'**
  String get accessDeniedReasonRole;

  /// No description provided for @accessDeniedContact.
  ///
  /// In en, this message translates to:
  /// **'Contact your system administrator if you need access.'**
  String get accessDeniedContact;

  /// No description provided for @accessDeniedRoleContact.
  ///
  /// In en, this message translates to:
  /// **'Use the ATLANTECH web dashboard, or sign in with a Marine Pilot, Tug Master or CT Supervisor account.'**
  String get accessDeniedRoleContact;

  /// No description provided for @accessDeniedBackHint.
  ///
  /// In en, this message translates to:
  /// **'Return to your task list. Changes saved on this device are kept.'**
  String get accessDeniedBackHint;

  /// No description provided for @accessDeniedSignOutHint.
  ///
  /// In en, this message translates to:
  /// **'Sign out, then sign in with a field account.'**
  String get accessDeniedSignOutHint;

  /// No description provided for @backToMyTasksAction.
  ///
  /// In en, this message translates to:
  /// **'Back to My Tasks'**
  String get backToMyTasksAction;

  /// No description provided for @signOutAction.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOutAction;

  /// No description provided for @devMockAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'Simulate access denied (403)'**
  String get devMockAccessDenied;

  /// No description provided for @errorBadRequest.
  ///
  /// In en, this message translates to:
  /// **'The request could not be processed.'**
  String get errorBadRequest;

  /// No description provided for @errorUnauthenticated.
  ///
  /// In en, this message translates to:
  /// **'Your session has ended. Sign in again.'**
  String get errorUnauthenticated;

  /// No description provided for @errorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'The username or password is incorrect.'**
  String get errorInvalidCredentials;

  /// No description provided for @errorForbidden.
  ///
  /// In en, this message translates to:
  /// **'Your role or terminal scope does not allow this.'**
  String get errorForbidden;

  /// No description provided for @errorAccountDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account is disabled. Contact your system administrator.'**
  String get errorAccountDisabled;

  /// No description provided for @errorPasswordChangeRequired.
  ///
  /// In en, this message translates to:
  /// **'Change your password to continue.'**
  String get errorPasswordChangeRequired;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'This record no longer exists.'**
  String get errorNotFound;

  /// No description provided for @errorVersionConflict.
  ///
  /// In en, this message translates to:
  /// **'This record was changed by someone else. The latest version is shown.'**
  String get errorVersionConflict;

  /// No description provided for @errorValidationFailed.
  ///
  /// In en, this message translates to:
  /// **'Some of the data is not valid. Check the fields and try again.'**
  String get errorValidationFailed;

  /// No description provided for @errorIdempotencyKeyReused.
  ///
  /// In en, this message translates to:
  /// **'This request was already sent with different data.'**
  String get errorIdempotencyKeyReused;

  /// No description provided for @errorLicenseReadOnly.
  ///
  /// In en, this message translates to:
  /// **'The port licence is read-only. New changes cannot be saved.'**
  String get errorLicenseReadOnly;

  /// No description provided for @errorAppUpdateRequired.
  ///
  /// In en, this message translates to:
  /// **'This version of the app is no longer supported. Update the app to continue.'**
  String get errorAppUpdateRequired;

  /// No description provided for @errorTooManyAttempts.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Wait a moment, then try again.'**
  String get errorTooManyAttempts;

  /// No description provided for @errorServerError.
  ///
  /// In en, this message translates to:
  /// **'The server had a problem. Try again in a moment.'**
  String get errorServerError;

  /// No description provided for @errorServiceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The server is not available right now. Try again in a moment.'**
  String get errorServiceUnavailable;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'The port server cannot be reached. Check the port network and try again.'**
  String get errorNetwork;

  /// No description provided for @errorTimeout.
  ///
  /// In en, this message translates to:
  /// **'The port server took too long to answer. Try again.'**
  String get errorTimeout;

  /// No description provided for @errorUntrustedServer.
  ///
  /// In en, this message translates to:
  /// **'This network is not the port network. Connect to the port network and try again.'**
  String get errorUntrustedServer;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again in a moment.'**
  String get errorUnknown;

  /// No description provided for @connectionUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get connectionUnknown;

  /// No description provided for @portHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Field Operations · Port Identification'**
  String get portHeaderSubtitle;

  /// No description provided for @portLoading.
  ///
  /// In en, this message translates to:
  /// **'Contacting the port server'**
  String get portLoading;

  /// No description provided for @portTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Your Port'**
  String get portTitle;

  /// No description provided for @portIntro.
  ///
  /// In en, this message translates to:
  /// **'Port identity is retrieved from the server, not selected on this device.'**
  String get portIntro;

  /// No description provided for @portLoadedTitle.
  ///
  /// In en, this message translates to:
  /// **'Port identity received'**
  String get portLoadedTitle;

  /// No description provided for @portLoadedMessage.
  ///
  /// In en, this message translates to:
  /// **'Review the server-provided port name and identifier. Continue only if this is the port you expect to work in.'**
  String get portLoadedMessage;

  /// No description provided for @portUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Unable to connect to the server'**
  String get portUnavailableTitle;

  /// No description provided for @portUnavailableMessage.
  ///
  /// In en, this message translates to:
  /// **'Port identity and license status could not be retrieved. Restore the server connection and retry. Continue is unavailable.'**
  String get portUnavailableMessage;

  /// No description provided for @portFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Port identity could not be verified'**
  String get portFailedTitle;

  /// No description provided for @portFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'The server connection is online, but a valid port identity was not available. Retry verification; do not continue with an unverified port.'**
  String get portFailedMessage;

  /// No description provided for @portIncorrectTitle.
  ///
  /// In en, this message translates to:
  /// **'This connected port appears incorrect'**
  String get portIncorrectTitle;

  /// No description provided for @portIncorrectMessage.
  ///
  /// In en, this message translates to:
  /// **'Do not continue. Port identity cannot be edited here. Check the port network, then check again.'**
  String get portIncorrectMessage;

  /// No description provided for @portConnectedLabel.
  ///
  /// In en, this message translates to:
  /// **'Connected port'**
  String get portConnectedLabel;

  /// No description provided for @portSourceServer.
  ///
  /// In en, this message translates to:
  /// **'Server-provided identity'**
  String get portSourceServer;

  /// No description provided for @portSourceNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Not verified'**
  String get portSourceNotVerified;

  /// No description provided for @portSourceBlocked.
  ///
  /// In en, this message translates to:
  /// **'Server response · Review blocked'**
  String get portSourceBlocked;

  /// No description provided for @portNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Port name'**
  String get portNameLabel;

  /// No description provided for @portIdentifierLabel.
  ///
  /// In en, this message translates to:
  /// **'Port identifier'**
  String get portIdentifierLabel;

  /// No description provided for @portUnavailableValue.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get portUnavailableValue;

  /// No description provided for @portLicenseLabel.
  ///
  /// In en, this message translates to:
  /// **'License status'**
  String get portLicenseLabel;

  /// No description provided for @portLicenseActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get portLicenseActive;

  /// No description provided for @portLicenseUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown · Not retrieved'**
  String get portLicenseUnknown;

  /// No description provided for @portNoIdentityNote.
  ///
  /// In en, this message translates to:
  /// **'No verified identity or license is available. No local port selection is permitted.'**
  String get portNoIdentityNote;

  /// No description provided for @portNotMyPortAction.
  ///
  /// In en, this message translates to:
  /// **'This is not my port'**
  String get portNotMyPortAction;

  /// No description provided for @portContinueHint.
  ///
  /// In en, this message translates to:
  /// **'Continue to Sign In. Your role and task permissions still apply.'**
  String get portContinueHint;

  /// No description provided for @portBlockedHint.
  ///
  /// In en, this message translates to:
  /// **'Continuation is blocked until the server identity and license are verified.'**
  String get portBlockedHint;

  /// No description provided for @portIncorrectHint.
  ///
  /// In en, this message translates to:
  /// **'Continuation is blocked until the correct connected port is verified. No inline correction or port switching.'**
  String get portIncorrectHint;

  /// No description provided for @loginHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Field Operations · Sign In'**
  String get loginHeaderSubtitle;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign In to Field Operations'**
  String get loginTitle;

  /// No description provided for @loginAgainTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign In Again'**
  String get loginAgainTitle;

  /// No description provided for @loginChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Set a new password'**
  String get loginChangeTitle;

  /// No description provided for @loginPortLabel.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get loginPortLabel;

  /// No description provided for @loginPortNotConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Not yet confirmed'**
  String get loginPortNotConfirmed;

  /// No description provided for @loginPortNotConfirmedNote.
  ///
  /// In en, this message translates to:
  /// **'Port identity will be confirmed after connection.'**
  String get loginPortNotConfirmedNote;

  /// No description provided for @loginPortServerNote.
  ///
  /// In en, this message translates to:
  /// **'Server-provided port identity'**
  String get loginPortServerNote;

  /// No description provided for @loginAccountLabel.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get loginAccountLabel;

  /// No description provided for @loginFirstLogin.
  ///
  /// In en, this message translates to:
  /// **'First login'**
  String get loginFirstLogin;

  /// No description provided for @loginFirstLoginNote.
  ///
  /// In en, this message translates to:
  /// **'A temporary password was used. Choose a new password to continue.'**
  String get loginFirstLoginNote;

  /// No description provided for @loginAccountDisabled.
  ///
  /// In en, this message translates to:
  /// **'Account disabled'**
  String get loginAccountDisabled;

  /// No description provided for @loginAccountDisabledNote.
  ///
  /// In en, this message translates to:
  /// **'This account is disabled. Contact your Port Admin.'**
  String get loginAccountDisabledNote;

  /// No description provided for @loginUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get loginUsername;

  /// No description provided for @loginUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get loginUsernameHint;

  /// No description provided for @loginUsernameFixed.
  ///
  /// In en, this message translates to:
  /// **'Owner of the unsent events · fixed'**
  String get loginUsernameFixed;

  /// No description provided for @loginUsernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Username is required.'**
  String get loginUsernameRequired;

  /// No description provided for @loginPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPassword;

  /// No description provided for @loginPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get loginPasswordHint;

  /// No description provided for @loginPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required.'**
  String get loginPasswordRequired;

  /// No description provided for @loginShowPassword.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get loginShowPassword;

  /// No description provided for @loginHidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get loginHidePassword;

  /// No description provided for @loginAction.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get loginAction;

  /// No description provided for @loginSigningInAction.
  ///
  /// In en, this message translates to:
  /// **'Signing In…'**
  String get loginSigningInAction;

  /// No description provided for @loginNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get loginNewPassword;

  /// No description provided for @loginNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get loginNewPasswordHint;

  /// No description provided for @loginPasswordRule.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters, with letters and numbers.'**
  String get loginPasswordRule;

  /// No description provided for @loginConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get loginConfirmPassword;

  /// No description provided for @loginConfirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Repeat new password'**
  String get loginConfirmPasswordHint;

  /// No description provided for @loginNewPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get loginNewPasswordRequired;

  /// No description provided for @loginPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters.'**
  String get loginPasswordTooShort;

  /// No description provided for @loginPasswordLettersNumbers.
  ///
  /// In en, this message translates to:
  /// **'Use both letters and numbers.'**
  String get loginPasswordLettersNumbers;

  /// No description provided for @loginPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'The passwords do not match.'**
  String get loginPasswordMismatch;

  /// No description provided for @loginChangeAction.
  ///
  /// In en, this message translates to:
  /// **'Save and continue'**
  String get loginChangeAction;

  /// No description provided for @loginSigningInTitle.
  ///
  /// In en, this message translates to:
  /// **'Signing in…'**
  String get loginSigningInTitle;

  /// No description provided for @loginSigningInMessage.
  ///
  /// In en, this message translates to:
  /// **'Verifying credentials with the server. Please wait; sign-in is not yet complete.'**
  String get loginSigningInMessage;

  /// No description provided for @loginInvalidTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign-in unsuccessful'**
  String get loginInvalidTitle;

  /// No description provided for @loginInvalidMessage.
  ///
  /// In en, this message translates to:
  /// **'Username or password is incorrect. Check your credentials and try again.'**
  String get loginInvalidMessage;

  /// No description provided for @loginExpiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Session expired · Sync paused'**
  String get loginExpiredTitle;

  /// No description provided for @loginExpiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Reconnect and sign in as the same user before sending pending events. Cached work and {count, plural, =0{the Outbox are} =1{1 Outbox event are} other{{count} Outbox events are}} preserved.'**
  String loginExpiredMessage(int count);

  /// No description provided for @loginReauthTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in again before syncing'**
  String get loginReauthTitle;

  /// No description provided for @loginReauthMessage.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Unsent events belong} =1{1 Outbox event belongs} other{{count} Outbox events belong}} to {username}. Sign in as this user to send {count, plural, =1{it} other{them}}; another user cannot send these events.'**
  String loginReauthMessage(int count, String username);

  /// No description provided for @loginOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'Server connection required'**
  String get loginOfflineTitle;

  /// No description provided for @loginOfflineMessage.
  ///
  /// In en, this message translates to:
  /// **'Sign-in cannot complete offline. {count, plural, =0{Cached work remains on this device.} =1{Cached work and 1 Outbox event remain on this device; nothing has been sent.} other{Cached work and {count} Outbox events remain on this device; nothing has been sent.}}'**
  String loginOfflineMessage(int count);

  /// No description provided for @loginTooManyTitle.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts'**
  String get loginTooManyTitle;

  /// No description provided for @loginServerErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign-in could not complete'**
  String get loginServerErrorTitle;

  /// No description provided for @loginFootnote.
  ///
  /// In en, this message translates to:
  /// **'Your session is linked to this device after sign-in.'**
  String get loginFootnote;

  /// No description provided for @loginOutboxFootnote.
  ///
  /// In en, this message translates to:
  /// **'Outbox kept · Owner: {username}\nSigning in again does not discard or reassign pending events.'**
  String loginOutboxFootnote(String username);

  /// No description provided for @loginChangeFootnote.
  ///
  /// In en, this message translates to:
  /// **'Required once, before any task can be opened.'**
  String get loginChangeFootnote;

  /// No description provided for @loginDisabledFootnote.
  ///
  /// In en, this message translates to:
  /// **'No tasks can be opened for a disabled account.'**
  String get loginDisabledFootnote;

  /// No description provided for @taskTypePilotage.
  ///
  /// In en, this message translates to:
  /// **'Pilotage'**
  String get taskTypePilotage;

  /// No description provided for @taskTypeTug.
  ///
  /// In en, this message translates to:
  /// **'Tug assistance'**
  String get taskTypeTug;

  /// No description provided for @taskTypeTerminal.
  ///
  /// In en, this message translates to:
  /// **'Terminal operation · actual reporting'**
  String get taskTypeTerminal;

  /// No description provided for @taskStatusAssigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get taskStatusAssigned;

  /// No description provided for @taskStatusStarted.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get taskStatusStarted;

  /// No description provided for @taskStatusDone.
  ///
  /// In en, this message translates to:
  /// **'Executed'**
  String get taskStatusDone;

  /// No description provided for @systemLabelUpdated.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get systemLabelUpdated;

  /// No description provided for @systemLabelOverridden.
  ///
  /// In en, this message translates to:
  /// **'Overridden'**
  String get systemLabelOverridden;

  /// No description provided for @systemLabelCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get systemLabelCancelled;

  /// No description provided for @outboxStatusPending.
  ///
  /// In en, this message translates to:
  /// **'PENDING'**
  String get outboxStatusPending;

  /// No description provided for @outboxStatusSending.
  ///
  /// In en, this message translates to:
  /// **'SENDING'**
  String get outboxStatusSending;

  /// No description provided for @outboxStatusDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get outboxStatusDone;

  /// No description provided for @outboxStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'REJECTED'**
  String get outboxStatusRejected;

  /// No description provided for @rejectPlanCancelled.
  ///
  /// In en, this message translates to:
  /// **'This update was rejected because the plan was cancelled.'**
  String get rejectPlanCancelled;

  /// No description provided for @rejectIllegalTransition.
  ///
  /// In en, this message translates to:
  /// **'The task status had already changed, so this update could not be applied.'**
  String get rejectIllegalTransition;

  /// No description provided for @rejectNotAssigned.
  ///
  /// In en, this message translates to:
  /// **'This task is no longer assigned to you.'**
  String get rejectNotAssigned;

  /// No description provided for @rejectNotFound.
  ///
  /// In en, this message translates to:
  /// **'This task no longer exists.'**
  String get rejectNotFound;

  /// No description provided for @rejectInvalidEvent.
  ///
  /// In en, this message translates to:
  /// **'The server could not accept this update.'**
  String get rejectInvalidEvent;

  /// No description provided for @rejectUnknown.
  ///
  /// In en, this message translates to:
  /// **'The server rejected this update.'**
  String get rejectUnknown;

  /// No description provided for @notificationTypeAssignment.
  ///
  /// In en, this message translates to:
  /// **'Task assignment'**
  String get notificationTypeAssignment;

  /// No description provided for @notificationTypeReminder.
  ///
  /// In en, this message translates to:
  /// **'Pre-execution reminder'**
  String get notificationTypeReminder;

  /// No description provided for @notificationTypeCancelled.
  ///
  /// In en, this message translates to:
  /// **'Plan cancelled'**
  String get notificationTypeCancelled;

  /// No description provided for @notificationStatusSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get notificationStatusSent;

  /// No description provided for @notificationStatusFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get notificationStatusFailed;

  /// No description provided for @notificationStatusAcknowledged.
  ///
  /// In en, this message translates to:
  /// **'Acknowledged'**
  String get notificationStatusAcknowledged;

  /// No description provided for @eventAcknowledgement.
  ///
  /// In en, this message translates to:
  /// **'Acknowledgement'**
  String get eventAcknowledgement;

  /// No description provided for @eventDeviceLabel.
  ///
  /// In en, this message translates to:
  /// **'Device record'**
  String get eventDeviceLabel;

  /// No description provided for @eventDispatchLabel.
  ///
  /// In en, this message translates to:
  /// **'Dispatch'**
  String get eventDispatchLabel;

  /// No description provided for @eventAcceptanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Server acceptance'**
  String get eventAcceptanceLabel;

  /// No description provided for @eventDeviceNone.
  ///
  /// In en, this message translates to:
  /// **'No local status update saved'**
  String get eventDeviceNone;

  /// No description provided for @eventDeviceSaved.
  ///
  /// In en, this message translates to:
  /// **'{action} saved · {time}'**
  String eventDeviceSaved(String action, String time);

  /// No description provided for @eventDispatchNone.
  ///
  /// In en, this message translates to:
  /// **'No status update submitted'**
  String get eventDispatchNone;

  /// No description provided for @eventDispatchWaiting.
  ///
  /// In en, this message translates to:
  /// **'Not dispatched · Pending'**
  String get eventDispatchWaiting;

  /// No description provided for @eventDispatchFailed.
  ///
  /// In en, this message translates to:
  /// **'Attempt failed · retained'**
  String get eventDispatchFailed;

  /// No description provided for @eventDispatchSending.
  ///
  /// In en, this message translates to:
  /// **'Sending · response awaited'**
  String get eventDispatchSending;

  /// No description provided for @eventDispatchDone.
  ///
  /// In en, this message translates to:
  /// **'Dispatched · {time}'**
  String eventDispatchDone(String time);

  /// No description provided for @eventAcceptanceNone.
  ///
  /// In en, this message translates to:
  /// **'No new update awaiting acceptance'**
  String get eventAcceptanceNone;

  /// No description provided for @eventAcceptanceWaiting.
  ///
  /// In en, this message translates to:
  /// **'{action} not confirmed'**
  String eventAcceptanceWaiting(String action);

  /// No description provided for @eventAcceptanceDone.
  ///
  /// In en, this message translates to:
  /// **'{action} accepted · {time}'**
  String eventAcceptanceDone(String action, String time);

  /// No description provided for @eventAcceptanceRejected.
  ///
  /// In en, this message translates to:
  /// **'{action} rejected · retained'**
  String eventAcceptanceRejected(String action);

  /// No description provided for @outboxAction.
  ///
  /// In en, this message translates to:
  /// **'Outbox'**
  String get outboxAction;

  /// No description provided for @tasksListTitle.
  ///
  /// In en, this message translates to:
  /// **'My assignments'**
  String get tasksListTitle;

  /// No description provided for @tasksListTitleCount.
  ///
  /// In en, this message translates to:
  /// **'My assignments · {count, plural, =1{1 task} other{{count} tasks}}'**
  String tasksListTitleCount(int count);

  /// No description provided for @tasksListTitleCt.
  ///
  /// In en, this message translates to:
  /// **'Terminal A · Actual reporting'**
  String get tasksListTitleCt;

  /// No description provided for @tasksListTitleCtCount.
  ///
  /// In en, this message translates to:
  /// **'Terminal A · Actual reporting · {count, plural, =1{1 task} other{{count} tasks}}'**
  String tasksListTitleCtCount(int count);

  /// No description provided for @tasksRefreshAction.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get tasksRefreshAction;

  /// No description provided for @tasksRefreshing.
  ///
  /// In en, this message translates to:
  /// **'Refreshing…'**
  String get tasksRefreshing;

  /// No description provided for @tasksSyncLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading assignments · sync separate'**
  String get tasksSyncLoading;

  /// No description provided for @tasksSyncPending.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 pending event} other{{count} pending events}} · not server-confirmed'**
  String tasksSyncPending(int count);

  /// No description provided for @tasksSyncNone.
  ///
  /// In en, this message translates to:
  /// **'No queued execution updates'**
  String get tasksSyncNone;

  /// No description provided for @tasksFeedOnline.
  ///
  /// In en, this message translates to:
  /// **'Live assignment updates on · Connection is not sync confirmation'**
  String get tasksFeedOnline;

  /// No description provided for @tasksFeedOffline.
  ///
  /// In en, this message translates to:
  /// **'Assignment feed disconnected · Reconnect for current assignments'**
  String get tasksFeedOffline;

  /// No description provided for @tasksLoadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Loading My Tasks…'**
  String get tasksLoadingMessage;

  /// No description provided for @tasksEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No tasks assigned'**
  String get tasksEmptyTitle;

  /// No description provided for @tasksEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'New assignments will appear through the live update feed. You can also refresh the list.'**
  String get tasksEmptyMessage;

  /// No description provided for @tasksErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'The request failed. Retry to request your assigned tasks again.'**
  String get tasksErrorMessage;

  /// No description provided for @tasksErrorNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Assignment list unavailable'**
  String get tasksErrorNoticeTitle;

  /// No description provided for @tasksErrorNoticeMessage.
  ///
  /// In en, this message translates to:
  /// **'The assigned-task list could not be loaded. This does not mean you have no tasks, and no task or update was changed.'**
  String get tasksErrorNoticeMessage;

  /// No description provided for @tasksLoadingNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Loading your assigned tasks'**
  String get tasksLoadingNoticeTitle;

  /// No description provided for @tasksLoadingNoticeMessage.
  ///
  /// In en, this message translates to:
  /// **'Request in progress. Loading does not mean there are no tasks.'**
  String get tasksLoadingNoticeMessage;

  /// No description provided for @tasksOfflineEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Offline · no cached tasks'**
  String get tasksOfflineEmptyTitle;

  /// No description provided for @tasksOfflineEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'This device has no cached assigned tasks for {name}. Connect to load tasks.'**
  String tasksOfflineEmptyMessage(String name);

  /// No description provided for @tasksOfflineCachedTitle.
  ///
  /// In en, this message translates to:
  /// **'Offline · cached tasks may be stale'**
  String get tasksOfflineCachedTitle;

  /// No description provided for @tasksOfflineCachedMessage.
  ///
  /// In en, this message translates to:
  /// **'Last cached: {time}. Open a cached task to record actual execution; unsent updates remain on this device.'**
  String tasksOfflineCachedMessage(String time);

  /// No description provided for @tasksOfflineCachedMessageNoTime.
  ///
  /// In en, this message translates to:
  /// **'Open a cached task to record actual execution; unsent updates remain on this device.'**
  String get tasksOfflineCachedMessageNoTime;

  /// No description provided for @tasksUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'Assignment update received'**
  String get tasksUpdateTitle;

  /// No description provided for @tasksUpdateMessage.
  ///
  /// In en, this message translates to:
  /// **'Update received for {reference}. Review it in Task Details. Your pending updates are not replaced.'**
  String tasksUpdateMessage(String reference);

  /// No description provided for @tasksLockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Task changed by the planner'**
  String get tasksLockedTitle;

  /// No description provided for @tasksLockedMessage.
  ///
  /// In en, this message translates to:
  /// **'{reference} was cancelled or replaced by a newer plan. Its actions are stopped.'**
  String tasksLockedMessage(String reference);

  /// No description provided for @tasksPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 local update awaiting acceptance} other{{count} local updates awaiting acceptance}}'**
  String tasksPendingTitle(int count);

  /// No description provided for @tasksPendingMessage.
  ///
  /// In en, this message translates to:
  /// **'{action} was saved on this device at {time}. The server-confirmed status stays as it is until acceptance.'**
  String tasksPendingMessage(String action, String time);

  /// No description provided for @tasksEmptyNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Assignment list received'**
  String get tasksEmptyNoticeTitle;

  /// No description provided for @tasksEmptyNoticeMessage.
  ///
  /// In en, this message translates to:
  /// **'No tasks are assigned to {name} in the current server result.'**
  String tasksEmptyNoticeMessage(String name);

  /// No description provided for @tasksScopeTitle.
  ///
  /// In en, this message translates to:
  /// **'Your assigned tasks only'**
  String get tasksScopeTitle;

  /// No description provided for @tasksScopeMessage.
  ///
  /// In en, this message translates to:
  /// **'Signed in as {name}. Open an assigned task to acknowledge it and record actual execution in Task Details.'**
  String tasksScopeMessage(String name);

  /// No description provided for @tasksScopeTugTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Tug Master assignments'**
  String get tasksScopeTugTitle;

  /// No description provided for @tasksScopeCtTitle.
  ///
  /// In en, this message translates to:
  /// **'Your terminal scope'**
  String get tasksScopeCtTitle;

  /// No description provided for @tasksScopeCtMessage.
  ///
  /// In en, this message translates to:
  /// **'Signed in as {name}. Terminal operations that need actual-status reporting. No other terminal records are shown.'**
  String tasksScopeCtMessage(String name);

  /// No description provided for @taskTugRef.
  ///
  /// In en, this message translates to:
  /// **'Tug {tug}'**
  String taskTugRef(String tug);

  /// No description provided for @taskCached.
  ///
  /// In en, this message translates to:
  /// **'Cached'**
  String get taskCached;

  /// No description provided for @taskBerth.
  ///
  /// In en, this message translates to:
  /// **'Berth'**
  String get taskBerth;

  /// No description provided for @taskScheduledTime.
  ///
  /// In en, this message translates to:
  /// **'Scheduled time'**
  String get taskScheduledTime;

  /// No description provided for @taskType.
  ///
  /// In en, this message translates to:
  /// **'Task type'**
  String get taskType;

  /// No description provided for @taskLocalUpdate.
  ///
  /// In en, this message translates to:
  /// **'Local execution update'**
  String get taskLocalUpdate;

  /// No description provided for @taskLocalSaved.
  ///
  /// In en, this message translates to:
  /// **'{action} · saved on device'**
  String taskLocalSaved(String action);

  /// No description provided for @taskLocalNone.
  ///
  /// In en, this message translates to:
  /// **'None saved'**
  String get taskLocalNone;

  /// No description provided for @taskSynchronization.
  ///
  /// In en, this message translates to:
  /// **'Synchronization'**
  String get taskSynchronization;

  /// No description provided for @taskSyncPending.
  ///
  /// In en, this message translates to:
  /// **'Pending · not server-confirmed'**
  String get taskSyncPending;

  /// No description provided for @taskSyncSending.
  ///
  /// In en, this message translates to:
  /// **'Sending · response awaited'**
  String get taskSyncSending;

  /// No description provided for @taskSyncRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected · see Outbox'**
  String get taskSyncRejected;

  /// No description provided for @taskSyncNone.
  ///
  /// In en, this message translates to:
  /// **'No queued update for this task'**
  String get taskSyncNone;

  /// No description provided for @taskOpenAction.
  ///
  /// In en, this message translates to:
  /// **'Open Task'**
  String get taskOpenAction;

  /// No description provided for @taskServer.
  ///
  /// In en, this message translates to:
  /// **'Server'**
  String get taskServer;

  /// No description provided for @taskServerCached.
  ///
  /// In en, this message translates to:
  /// **'Server · cached'**
  String get taskServerCached;

  /// No description provided for @taskServerNoUpdate.
  ///
  /// In en, this message translates to:
  /// **'No execution update recorded'**
  String get taskServerNoUpdate;

  /// No description provided for @taskDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Task Details & Status Update'**
  String get taskDetailsTitle;

  /// No description provided for @taskDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Task {reference} · {type}'**
  String taskDetailsSubtitle(String reference, String type);

  /// No description provided for @taskDetailsSubtitleEmpty.
  ///
  /// In en, this message translates to:
  /// **'Field execution'**
  String get taskDetailsSubtitleEmpty;

  /// No description provided for @taskLoadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Loading task details…'**
  String get taskLoadingTitle;

  /// No description provided for @taskLoadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Retrieving the assigned task from the server. Cached data stays visible if it exists.'**
  String get taskLoadingMessage;

  /// No description provided for @taskLoadingData.
  ///
  /// In en, this message translates to:
  /// **'Loading task data…'**
  String get taskLoadingData;

  /// No description provided for @taskNoDataNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Task data unavailable'**
  String get taskNoDataNoticeTitle;

  /// No description provided for @taskNoDataNoticeMessage.
  ///
  /// In en, this message translates to:
  /// **'There is no task record to display. This does not mean the task is completed.'**
  String get taskNoDataNoticeMessage;

  /// No description provided for @taskNoDataTitle.
  ///
  /// In en, this message translates to:
  /// **'No task data available'**
  String get taskNoDataTitle;

  /// No description provided for @taskNoDataMessage.
  ///
  /// In en, this message translates to:
  /// **'Task details are unavailable on this device. Return to My Tasks to review your assigned work.'**
  String get taskNoDataMessage;

  /// No description provided for @taskCancelledTitle.
  ///
  /// In en, this message translates to:
  /// **'Task cancelled by the planner'**
  String get taskCancelledTitle;

  /// No description provided for @taskCancelledMessage.
  ///
  /// In en, this message translates to:
  /// **'This task was cancelled. Actions are stopped; any local update is kept in the Outbox but cannot be applied.'**
  String get taskCancelledMessage;

  /// No description provided for @taskOverriddenTitle.
  ///
  /// In en, this message translates to:
  /// **'Overridden by a newer plan'**
  String get taskOverriddenTitle;

  /// No description provided for @taskOverriddenMessage.
  ///
  /// In en, this message translates to:
  /// **'A newer plan version replaced this assignment. Actions are stopped; any local update is kept for review and is not applied.'**
  String get taskOverriddenMessage;

  /// No description provided for @taskRejectedTitle.
  ///
  /// In en, this message translates to:
  /// **'Rejected by server · update kept'**
  String get taskRejectedTitle;

  /// No description provided for @taskSyncFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Synchronization failed · update kept'**
  String get taskSyncFailedTitle;

  /// No description provided for @taskSyncFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'{action} has not been accepted by the server. Your local update and cached task data remain available.'**
  String taskSyncFailedMessage(String action);

  /// No description provided for @taskOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'Offline · using cached task data'**
  String get taskOfflineTitle;

  /// No description provided for @taskOfflineMessage.
  ///
  /// In en, this message translates to:
  /// **'You can still record actual execution. Saved updates remain on this device and in the Outbox until server acceptance.'**
  String get taskOfflineMessage;

  /// No description provided for @taskUpdatedTitle.
  ///
  /// In en, this message translates to:
  /// **'Received plan change · review assignment'**
  String get taskUpdatedTitle;

  /// No description provided for @taskUpdatedMessage.
  ///
  /// In en, this message translates to:
  /// **'The planner updated this task. Review the details below; your local updates are kept.'**
  String get taskUpdatedMessage;

  /// No description provided for @taskPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Local update awaiting synchronization'**
  String get taskPendingTitle;

  /// No description provided for @taskPendingMessage.
  ///
  /// In en, this message translates to:
  /// **'{action} is saved on this device and waiting to be sent. Online does not mean the server has accepted it.'**
  String taskPendingMessage(String action);

  /// No description provided for @taskConfirmedTitle.
  ///
  /// In en, this message translates to:
  /// **'Execution update confirmed by server'**
  String get taskConfirmedTitle;

  /// No description provided for @taskConfirmedMessage.
  ///
  /// In en, this message translates to:
  /// **'The server accepted {action} at {time}. That update has left the Outbox queue.'**
  String taskConfirmedMessage(String action, String time);

  /// No description provided for @taskAcknowledgedTitle.
  ///
  /// In en, this message translates to:
  /// **'Task acknowledged'**
  String get taskAcknowledgedTitle;

  /// No description provided for @taskAcknowledgedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your acknowledgment is recorded. It does not record In progress or Executed; save the execution status separately.'**
  String get taskAcknowledgedMessage;

  /// No description provided for @taskNotAcknowledgedTitle.
  ///
  /// In en, this message translates to:
  /// **'Not yet acknowledged'**
  String get taskNotAcknowledgedTitle;

  /// No description provided for @taskNotAcknowledgedMessage.
  ///
  /// In en, this message translates to:
  /// **'Opening this task does not acknowledge it. Use Acknowledge; execution updates remain available.'**
  String get taskNotAcknowledgedMessage;

  /// No description provided for @taskInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Task information'**
  String get taskInfoTitle;

  /// No description provided for @taskInfoTitleCached.
  ///
  /// In en, this message translates to:
  /// **'Task information · cached'**
  String get taskInfoTitleCached;

  /// No description provided for @taskVesselName.
  ///
  /// In en, this message translates to:
  /// **'Vessel Name'**
  String get taskVesselName;

  /// No description provided for @taskPlannedTime.
  ///
  /// In en, this message translates to:
  /// **'Planned Time'**
  String get taskPlannedTime;

  /// No description provided for @taskAssignedBerth.
  ///
  /// In en, this message translates to:
  /// **'Assigned Berth'**
  String get taskAssignedBerth;

  /// No description provided for @taskAssignedTugs.
  ///
  /// In en, this message translates to:
  /// **'Assigned Tug(s)'**
  String get taskAssignedTugs;

  /// No description provided for @taskAssignedPilot.
  ///
  /// In en, this message translates to:
  /// **'Assigned Marine Pilot'**
  String get taskAssignedPilot;

  /// No description provided for @taskPlanReference.
  ///
  /// In en, this message translates to:
  /// **'Plan / assignment reference'**
  String get taskPlanReference;

  /// No description provided for @taskAckTitle.
  ///
  /// In en, this message translates to:
  /// **'Acknowledge Task'**
  String get taskAckTitle;

  /// No description provided for @taskAckNotYet.
  ///
  /// In en, this message translates to:
  /// **'Not yet acknowledged'**
  String get taskAckNotYet;

  /// No description provided for @taskAckDone.
  ///
  /// In en, this message translates to:
  /// **'Acknowledged by you · {time}'**
  String taskAckDone(String time);

  /// No description provided for @taskAckSaved.
  ///
  /// In en, this message translates to:
  /// **'Acknowledged · saved on device {time}'**
  String taskAckSaved(String time);

  /// No description provided for @taskAcknowledgeAction.
  ///
  /// In en, this message translates to:
  /// **'Acknowledge'**
  String get taskAcknowledgeAction;

  /// No description provided for @taskAcknowledgedBadge.
  ///
  /// In en, this message translates to:
  /// **'Acknowledged'**
  String get taskAcknowledgedBadge;

  /// No description provided for @taskUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Task Status'**
  String get taskUpdateTitle;

  /// No description provided for @taskServerConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Server-confirmed status: {status}'**
  String taskServerConfirmed(String status);

  /// No description provided for @taskLatestLocal.
  ///
  /// In en, this message translates to:
  /// **'Latest local update: {status}'**
  String taskLatestLocal(String status);

  /// No description provided for @taskSelectionNote.
  ///
  /// In en, this message translates to:
  /// **'Choose the status, then save. A selection alone is not saved.'**
  String get taskSelectionNote;

  /// No description provided for @taskSaveAction.
  ///
  /// In en, this message translates to:
  /// **'Save Status Update'**
  String get taskSaveAction;

  /// No description provided for @taskSaveSyncLabel.
  ///
  /// In en, this message translates to:
  /// **'Save & Synchronization'**
  String get taskSaveSyncLabel;

  /// No description provided for @taskSyncNoTask.
  ///
  /// In en, this message translates to:
  /// **'No task record on device'**
  String get taskSyncNoTask;

  /// No description provided for @taskSyncNoTaskNote.
  ///
  /// In en, this message translates to:
  /// **'Online connection does not confirm task availability.'**
  String get taskSyncNoTaskNote;

  /// No description provided for @taskSyncAckSeparate.
  ///
  /// In en, this message translates to:
  /// **'Acknowledgment is separate from execution status.'**
  String get taskSyncAckSeparate;

  /// No description provided for @taskSyncRejectedTitle.
  ///
  /// In en, this message translates to:
  /// **'Rejected by server'**
  String get taskSyncRejectedTitle;

  /// No description provided for @taskSyncRejectedNote.
  ///
  /// In en, this message translates to:
  /// **'Kept in the Outbox as Rejected.'**
  String get taskSyncRejectedNote;

  /// No description provided for @taskSyncFailedShort.
  ///
  /// In en, this message translates to:
  /// **'Synchronization failed'**
  String get taskSyncFailedShort;

  /// No description provided for @taskSyncFailedNote.
  ///
  /// In en, this message translates to:
  /// **'Not accepted yet · kept in the Outbox as Pending.'**
  String get taskSyncFailedNote;

  /// No description provided for @taskSyncPendingOffline.
  ///
  /// In en, this message translates to:
  /// **'Pending Sync · Offline'**
  String get taskSyncPendingOffline;

  /// No description provided for @taskSyncCachedAt.
  ///
  /// In en, this message translates to:
  /// **'Task last cached: {time}'**
  String taskSyncCachedAt(String time);

  /// No description provided for @taskSyncPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Pending Sync'**
  String get taskSyncPendingTitle;

  /// No description provided for @taskSyncSendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Sending'**
  String get taskSyncSendingTitle;

  /// No description provided for @taskSyncWaitingNote.
  ///
  /// In en, this message translates to:
  /// **'Waiting to be sent; server acceptance not confirmed.'**
  String get taskSyncWaitingNote;

  /// No description provided for @taskSyncDoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Done · confirmed by server'**
  String get taskSyncDoneTitle;

  /// No description provided for @taskSyncDoneNote.
  ///
  /// In en, this message translates to:
  /// **'Device save: {saved} · Acceptance: {accepted}'**
  String taskSyncDoneNote(String saved, String accepted);

  /// No description provided for @taskOutboxLabel.
  ///
  /// In en, this message translates to:
  /// **'Outbox'**
  String get taskOutboxLabel;

  /// No description provided for @taskOutboxRetained.
  ///
  /// In en, this message translates to:
  /// **'Outbox · {count, plural, =1{1 update kept} other{{count} updates kept}}'**
  String taskOutboxRetained(int count);

  /// No description provided for @taskOutboxWaiting.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 update awaiting sync} other{{count} updates awaiting sync}}'**
  String taskOutboxWaiting(int count);

  /// No description provided for @taskOutboxEmpty.
  ///
  /// In en, this message translates to:
  /// **'No queued updates'**
  String get taskOutboxEmpty;

  /// No description provided for @taskRetrySyncAction.
  ///
  /// In en, this message translates to:
  /// **'Retry Sync'**
  String get taskRetrySyncAction;

  /// No description provided for @syncTitle.
  ///
  /// In en, this message translates to:
  /// **'Sync Status & Outbox'**
  String get syncTitle;

  /// No description provided for @syncStripSending.
  ///
  /// In en, this message translates to:
  /// **'SENDING · awaiting server response'**
  String get syncStripSending;

  /// No description provided for @syncStripFailed.
  ///
  /// In en, this message translates to:
  /// **'Sync failure · {count, plural, =1{1 Pending kept} other{{count} Pending kept}}'**
  String syncStripFailed(int count);

  /// No description provided for @syncStripOffline.
  ///
  /// In en, this message translates to:
  /// **'Pending · sending paused offline'**
  String get syncStripOffline;

  /// No description provided for @syncStripRejected.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 Rejected event · kept} other{{count} Rejected events · kept}}'**
  String syncStripRejected(int count);

  /// No description provided for @syncStripConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Synchronization confirmed'**
  String get syncStripConfirmed;

  /// No description provided for @syncStripNone.
  ///
  /// In en, this message translates to:
  /// **'No pending events'**
  String get syncStripNone;

  /// No description provided for @syncStripCaption.
  ///
  /// In en, this message translates to:
  /// **'Device save → dispatch → server acceptance are separate steps'**
  String get syncStripCaption;

  /// No description provided for @syncSendingAction.
  ///
  /// In en, this message translates to:
  /// **'Sending…'**
  String get syncSendingAction;

  /// No description provided for @syncRetryAction.
  ///
  /// In en, this message translates to:
  /// **'Retry now'**
  String get syncRetryAction;

  /// No description provided for @syncRefreshAction.
  ///
  /// In en, this message translates to:
  /// **'Refresh status'**
  String get syncRefreshAction;

  /// No description provided for @syncCountPending.
  ///
  /// In en, this message translates to:
  /// **'Pending events'**
  String get syncCountPending;

  /// No description provided for @syncCountDone.
  ///
  /// In en, this message translates to:
  /// **'Done events'**
  String get syncCountDone;

  /// No description provided for @syncCountRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected events'**
  String get syncCountRejected;

  /// No description provided for @syncListTitle.
  ///
  /// In en, this message translates to:
  /// **'Device events · {count, plural, =0{none} =1{1 kept record} other{{count} kept records}}'**
  String syncListTitle(int count);

  /// No description provided for @syncEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No events on this device'**
  String get syncEmptyTitle;

  /// No description provided for @syncEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Acknowledgements and status updates you save will appear here until the server confirms them.'**
  String get syncEmptyMessage;

  /// No description provided for @syncOwnership.
  ///
  /// In en, this message translates to:
  /// **'Recorded by: {username} · Events stay on this device'**
  String syncOwnership(String username);

  /// No description provided for @syncOwnershipNote.
  ///
  /// In en, this message translates to:
  /// **'No silent deletion or reassignment. Going offline or signing in again does not change who owns an event.'**
  String get syncOwnershipNote;

  /// No description provided for @syncWipedTitle.
  ///
  /// In en, this message translates to:
  /// **'Device wiped'**
  String get syncWipedTitle;

  /// No description provided for @syncWipedMessage.
  ///
  /// In en, this message translates to:
  /// **'Events still PENDING on a wiped or reinstalled device are lost. Done events are removed after 30 days.'**
  String get syncWipedMessage;

  /// No description provided for @syncSendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Dispatch in progress'**
  String get syncSendingTitle;

  /// No description provided for @syncSendingMessage.
  ///
  /// In en, this message translates to:
  /// **'Events are SENDING while the request is in flight and return to PENDING if sending fails. Sending is not server acceptance.'**
  String get syncSendingMessage;

  /// No description provided for @syncFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Send failed · can be retried'**
  String get syncFailedTitle;

  /// No description provided for @syncFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'The send attempt failed before the server answered. Saved events stay PENDING and are retried automatically. Events never sent are lost if the device is wiped.'**
  String get syncFailedMessage;

  /// No description provided for @syncOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved here; not sent'**
  String get syncOfflineTitle;

  /// No description provided for @syncOfflineMessage.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 event remains} other{{count} events remain}} on this device. Reconnect to send under the user who recorded {count, plural, =1{it} other{them}}; saving offline is not server acceptance.'**
  String syncOfflineMessage(int count);

  /// No description provided for @syncRejectedTitle.
  ///
  /// In en, this message translates to:
  /// **'Final rejection by the server'**
  String get syncRejectedTitle;

  /// No description provided for @syncRejectedMessage.
  ///
  /// In en, this message translates to:
  /// **'A rejected event stays visible with its reason. Retrying cannot bypass a rejection.'**
  String get syncRejectedMessage;

  /// No description provided for @syncWaitingTitle.
  ///
  /// In en, this message translates to:
  /// **'Waiting to send'**
  String get syncWaitingTitle;

  /// No description provided for @syncWaitingMessage.
  ///
  /// In en, this message translates to:
  /// **'Saved events are sent in order as soon as the server can be reached.'**
  String get syncWaitingMessage;

  /// No description provided for @syncConfirmedTitle.
  ///
  /// In en, this message translates to:
  /// **'Server receipt confirmed'**
  String get syncConfirmedTitle;

  /// No description provided for @syncConfirmedMessage.
  ///
  /// In en, this message translates to:
  /// **'An event is Done only after the server accepts it. Confirmed history stays visible.'**
  String get syncConfirmedMessage;

  /// No description provided for @syncEventLabel.
  ///
  /// In en, this message translates to:
  /// **'Event / status update'**
  String get syncEventLabel;

  /// No description provided for @syncEventStatus.
  ///
  /// In en, this message translates to:
  /// **'Actual execution: {status}'**
  String syncEventStatus(String status);

  /// No description provided for @syncRecordedLabel.
  ///
  /// In en, this message translates to:
  /// **'Recorded on device'**
  String get syncRecordedLabel;

  /// No description provided for @syncRelatedLabel.
  ///
  /// In en, this message translates to:
  /// **'Related assignment'**
  String get syncRelatedLabel;

  /// No description provided for @syncRelatedValue.
  ///
  /// In en, this message translates to:
  /// **'{terminal} · Berth {berth}'**
  String syncRelatedValue(String terminal, String berth);

  /// No description provided for @syncDeviceSaveLabel.
  ///
  /// In en, this message translates to:
  /// **'Device save'**
  String get syncDeviceSaveLabel;

  /// No description provided for @syncDeviceSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved on Device · kept'**
  String get syncDeviceSaved;

  /// No description provided for @syncDispatchOffline.
  ///
  /// In en, this message translates to:
  /// **'Not dispatched · offline'**
  String get syncDispatchOffline;

  /// No description provided for @syncEventPendingNote.
  ///
  /// In en, this message translates to:
  /// **'Pending is not Done: the server has not confirmed this update.'**
  String get syncEventPendingNote;

  /// No description provided for @syncEventFailedNote.
  ///
  /// In en, this message translates to:
  /// **'The previous send failed. It stays Pending until the server accepts it.'**
  String get syncEventFailedNote;

  /// No description provided for @syncEventRejectedNote.
  ///
  /// In en, this message translates to:
  /// **'Rejection reason: {reason}'**
  String syncEventRejectedNote(String reason);

  /// No description provided for @syncEventDoneNote.
  ///
  /// In en, this message translates to:
  /// **'Confirmed history · Done events stay on the device for 30 days, then are removed.'**
  String get syncEventDoneNote;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings & Session'**
  String get settingsTitle;

  /// No description provided for @settingsLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading settings…'**
  String get settingsLoading;

  /// No description provided for @settingsStripNoEvents.
  ///
  /// In en, this message translates to:
  /// **'No pending execution events'**
  String get settingsStripNoEvents;

  /// No description provided for @settingsStripNone.
  ///
  /// In en, this message translates to:
  /// **'Device: no queued update · Dispatch: none · Server: no new acceptance claimed'**
  String get settingsStripNone;

  /// No description provided for @settingsStripUnknown.
  ///
  /// In en, this message translates to:
  /// **'Connection status unavailable · sync not verified'**
  String get settingsStripUnknown;

  /// No description provided for @settingsStripPending.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 Pending event} other{{count} Pending events}} · preserved on device'**
  String settingsStripPending(int count);

  /// No description provided for @settingsStripPendingCaption.
  ///
  /// In en, this message translates to:
  /// **'Device: saved · Dispatch: not sent · Server: {action} not confirmed'**
  String settingsStripPendingCaption(String action);

  /// No description provided for @settingsReadOnlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Read-only information'**
  String get settingsReadOnlyTitle;

  /// No description provided for @settingsReadOnlyMessage.
  ///
  /// In en, this message translates to:
  /// **'Current authenticated user and current device only. Account, port, and application information cannot be edited here.'**
  String get settingsReadOnlyMessage;

  /// No description provided for @settingsPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Review unsent updates before logout'**
  String get settingsPendingTitle;

  /// No description provided for @settingsPendingMessage.
  ///
  /// In en, this message translates to:
  /// **'Logging out does not clear or transfer pending events. Review Outbox now; same-user reauthentication is required for sending.'**
  String get settingsPendingMessage;

  /// No description provided for @settingsUnknownTitle.
  ///
  /// In en, this message translates to:
  /// **'Unknown is not Offline'**
  String get settingsUnknownTitle;

  /// No description provided for @settingsUnknownMessage.
  ///
  /// In en, this message translates to:
  /// **'The app cannot determine the current connection. No Offline or sync-success claim is made; available account information stays read-only.'**
  String get settingsUnknownMessage;

  /// No description provided for @settingsAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsAccountTitle;

  /// No description provided for @settingsAccountName.
  ///
  /// In en, this message translates to:
  /// **'Account name'**
  String get settingsAccountName;

  /// No description provided for @settingsUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get settingsUsername;

  /// No description provided for @settingsRole.
  ///
  /// In en, this message translates to:
  /// **'Assigned role'**
  String get settingsRole;

  /// No description provided for @settingsPortTitle.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get settingsPortTitle;

  /// No description provided for @settingsPortName.
  ///
  /// In en, this message translates to:
  /// **'Port name'**
  String get settingsPortName;

  /// No description provided for @settingsPortId.
  ///
  /// In en, this message translates to:
  /// **'Port identifier'**
  String get settingsPortId;

  /// No description provided for @settingsPortNote.
  ///
  /// In en, this message translates to:
  /// **'Server-provided port context'**
  String get settingsPortNote;

  /// No description provided for @settingsNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get settingsNotAvailable;

  /// No description provided for @settingsAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Application & Device'**
  String get settingsAppTitle;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Installed version'**
  String get settingsVersion;

  /// No description provided for @settingsDevice.
  ///
  /// In en, this message translates to:
  /// **'Device information'**
  String get settingsDevice;

  /// No description provided for @settingsConnection.
  ///
  /// In en, this message translates to:
  /// **'Current connection'**
  String get settingsConnection;

  /// No description provided for @settingsAppNote.
  ///
  /// In en, this message translates to:
  /// **'Only information available to this app is shown. Language: English or Arabic (RTL layout). Pending updates stay on the device when the token expires.'**
  String get settingsAppNote;

  /// No description provided for @settingsSessionTitle.
  ///
  /// In en, this message translates to:
  /// **'Session'**
  String get settingsSessionTitle;

  /// No description provided for @settingsSessionMessage.
  ///
  /// In en, this message translates to:
  /// **'Log Out ends the session on this device.'**
  String get settingsSessionMessage;

  /// No description provided for @settingsSessionPending.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 Pending event} other{{count} Pending events}} · original-user ownership retained'**
  String settingsSessionPending(int count);

  /// No description provided for @settingsReviewOutbox.
  ///
  /// In en, this message translates to:
  /// **'Review Outbox'**
  String get settingsReviewOutbox;

  /// No description provided for @settingsLogOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get settingsLogOut;

  /// No description provided for @logoutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out of this device?'**
  String get logoutDialogTitle;

  /// No description provided for @logoutDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Your current session will end.'**
  String get logoutDialogMessage;

  /// No description provided for @logoutDialogMessagePending.
  ///
  /// In en, this message translates to:
  /// **'Your current session will end. {count, plural, =1{1 unsent update remains} other{{count} unsent updates remain}} Pending on this device and may require reauthentication.'**
  String logoutDialogMessagePending(int count);

  /// No description provided for @logoutRetainedTitle.
  ///
  /// In en, this message translates to:
  /// **'{action} · Saved on Device · not dispatched or accepted'**
  String logoutRetainedTitle(String action);

  /// No description provided for @logoutRetainedMessage.
  ///
  /// In en, this message translates to:
  /// **'Owner: {username}. Sign in again as this same user to sync. Events are never discarded or reassigned at logout.'**
  String logoutRetainedMessage(String username);

  /// No description provided for @logoutReviewPending.
  ///
  /// In en, this message translates to:
  /// **'Review Pending Events'**
  String get logoutReviewPending;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm Log Out'**
  String get logoutConfirm;

  /// No description provided for @signedOutHeader.
  ///
  /// In en, this message translates to:
  /// **'Field Operations · Signed Out'**
  String get signedOutHeader;

  /// No description provided for @signedOutTitle.
  ///
  /// In en, this message translates to:
  /// **'You’re signed out'**
  String get signedOutTitle;

  /// No description provided for @signedOutMessage.
  ///
  /// In en, this message translates to:
  /// **'The current device session has ended. Sign in again through Sign In to return to the authenticated application.'**
  String get signedOutMessage;

  /// No description provided for @signedOutPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 unsent update remains} other{{count} unsent updates remain}} Pending on this device'**
  String signedOutPendingTitle(int count);

  /// No description provided for @signedOutPendingMessage.
  ///
  /// In en, this message translates to:
  /// **'Original recording user: {username}. Reauthenticate as this same user before sync; another user cannot send this event.'**
  String signedOutPendingMessage(String username);

  /// No description provided for @signedOutDeviceRecord.
  ///
  /// In en, this message translates to:
  /// **'Device record'**
  String get signedOutDeviceRecord;

  /// No description provided for @signedOutDeviceRecordValue.
  ///
  /// In en, this message translates to:
  /// **'{action} · saved at {time} · retained'**
  String signedOutDeviceRecordValue(String action, String time);

  /// No description provided for @signedOutDispatchValue.
  ///
  /// In en, this message translates to:
  /// **'Paused · no active session'**
  String get signedOutDispatchValue;

  /// No description provided for @signedOutFootnote.
  ///
  /// In en, this message translates to:
  /// **'Logout did not send, clear, discard, or transfer pending events. No authenticated account settings are exposed here.'**
  String get signedOutFootnote;

  /// No description provided for @notifStripLoading.
  ///
  /// In en, this message translates to:
  /// **'Receiving notifications…'**
  String get notifStripLoading;

  /// No description provided for @notifStripLoadingCaption.
  ///
  /// In en, this message translates to:
  /// **'Synchronization not yet confirmed'**
  String get notifStripLoadingCaption;

  /// No description provided for @notifStripError.
  ///
  /// In en, this message translates to:
  /// **'Refresh unavailable'**
  String get notifStripError;

  /// No description provided for @notifStripOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline · showing saved notifications'**
  String get notifStripOffline;

  /// No description provided for @notifStripReceived.
  ///
  /// In en, this message translates to:
  /// **'Updates received from the port server'**
  String get notifStripReceived;

  /// No description provided for @notifLastSync.
  ///
  /// In en, this message translates to:
  /// **'Last list sync: {time}'**
  String notifLastSync(String time);

  /// No description provided for @notifCachedCaption.
  ///
  /// In en, this message translates to:
  /// **'Saved on this device; new notifications arrive after reconnecting'**
  String get notifCachedCaption;

  /// No description provided for @notifErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Unable to refresh notifications'**
  String get notifErrorTitle;

  /// No description provided for @notifErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'The connection to the port server is unavailable. This is a list-loading error, not a Failed notification status.'**
  String get notifErrorMessage;

  /// No description provided for @notifOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get notifOfflineTitle;

  /// No description provided for @notifOfflineMessage.
  ///
  /// In en, this message translates to:
  /// **'Acknowledgements you make now are saved on the device and sent when the connection is back.'**
  String get notifOfflineMessage;

  /// No description provided for @notifFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'A notification could not be delivered'**
  String get notifFailedTitle;

  /// No description provided for @notifFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed means the system could not distribute it. Acknowledging does not fix it, and there is no manual resend. Open the task to check it.'**
  String get notifFailedMessage;

  /// No description provided for @notifFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get notifFilterAll;

  /// No description provided for @notifListTitle.
  ///
  /// In en, this message translates to:
  /// **'My notifications'**
  String get notifListTitle;

  /// No description provided for @notifListTitleCount.
  ///
  /// In en, this message translates to:
  /// **'My notifications · {count, plural, =0{none} =1{1} other{{count}}} · newest first'**
  String notifListTitleCount(int count);

  /// No description provided for @notifLoadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Loading notifications…'**
  String get notifLoadingMessage;

  /// No description provided for @notifEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get notifEmptyTitle;

  /// No description provided for @notifEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'New assignments, reminders and cancelled plans will appear here.'**
  String get notifEmptyMessage;

  /// No description provided for @notifErrorListMessage.
  ///
  /// In en, this message translates to:
  /// **'New notifications and current statuses could not be loaded.'**
  String get notifErrorListMessage;

  /// No description provided for @notifFilteredEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No notifications match your filter'**
  String get notifFilteredEmptyTitle;

  /// No description provided for @notifFilteredEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Nothing with status “{status}”. Clear the filter to see all your notifications.'**
  String notifFilteredEmptyMessage(String status);

  /// No description provided for @notifClearFilter.
  ///
  /// In en, this message translates to:
  /// **'Clear filter'**
  String get notifClearFilter;

  /// No description provided for @notifExplainTitle.
  ///
  /// In en, this message translates to:
  /// **'Understanding status and delivery'**
  String get notifExplainTitle;

  /// No description provided for @notifExplainStatus.
  ///
  /// In en, this message translates to:
  /// **'Sent = dispatched by the system, not device delivery. Failed = distribution failure. Acknowledged = user acknowledgement, not proof of device synchronization.'**
  String get notifExplainStatus;

  /// No description provided for @notifExplainOffline.
  ///
  /// In en, this message translates to:
  /// **'Acknowledgements made offline wait in the Outbox until the server accepts them.'**
  String get notifExplainOffline;

  /// No description provided for @notifMessageAssignment.
  ///
  /// In en, this message translates to:
  /// **'You have been assigned to this task.'**
  String get notifMessageAssignment;

  /// No description provided for @notifMessageReminder.
  ///
  /// In en, this message translates to:
  /// **'This task starts soon.'**
  String get notifMessageReminder;

  /// No description provided for @notifMessageCancelled.
  ///
  /// In en, this message translates to:
  /// **'The plan for this task was cancelled. No more actions are possible.'**
  String get notifMessageCancelled;

  /// No description provided for @notifNoteSent.
  ///
  /// In en, this message translates to:
  /// **'System dispatch confirmed. Acknowledge to confirm you have seen it.'**
  String get notifNoteSent;

  /// No description provided for @notifNoteAckPending.
  ///
  /// In en, this message translates to:
  /// **'Acknowledgement saved on device · waiting for server acceptance.'**
  String get notifNoteAckPending;

  /// No description provided for @notifNoteFailed.
  ///
  /// In en, this message translates to:
  /// **'Distribution failed. Not resolved by acknowledgement; no manual resend.'**
  String get notifNoteFailed;

  /// No description provided for @notifNoteAcknowledged.
  ///
  /// In en, this message translates to:
  /// **'Acknowledged at {time}. User acknowledgement only.'**
  String notifNoteAcknowledged(String time);

  /// No description provided for @notifRelatedTask.
  ///
  /// In en, this message translates to:
  /// **'Related task'**
  String get notifRelatedTask;

  /// No description provided for @notifTimestamp.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get notifTimestamp;

  /// No description provided for @notifOpenTask.
  ///
  /// In en, this message translates to:
  /// **'Open task'**
  String get notifOpenTask;

  /// No description provided for @notifAcknowledge.
  ///
  /// In en, this message translates to:
  /// **'Acknowledge'**
  String get notifAcknowledge;

  /// No description provided for @notifAckSavedAction.
  ///
  /// In en, this message translates to:
  /// **'Saved · pending sync'**
  String get notifAckSavedAction;

  /// No description provided for @notifAckSavedBadge.
  ///
  /// In en, this message translates to:
  /// **'Ack pending'**
  String get notifAckSavedBadge;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
