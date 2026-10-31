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
