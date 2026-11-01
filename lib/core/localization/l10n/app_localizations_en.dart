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

  @override
  String get connectionUnknown => 'Unknown';

  @override
  String get portHeaderSubtitle => 'Field Operations · Port Identification';

  @override
  String get portLoading => 'Contacting the port server';

  @override
  String get portTitle => 'Confirm Your Port';

  @override
  String get portIntro =>
      'Port identity is retrieved from the server, not selected on this device.';

  @override
  String get portLoadedTitle => 'Port identity received';

  @override
  String get portLoadedMessage =>
      'Review the server-provided port name and identifier. Continue only if this is the port you expect to work in.';

  @override
  String get portUnavailableTitle => 'Unable to connect to the server';

  @override
  String get portUnavailableMessage =>
      'Port identity and license status could not be retrieved. Restore the server connection and retry. Continue is unavailable.';

  @override
  String get portFailedTitle => 'Port identity could not be verified';

  @override
  String get portFailedMessage =>
      'The server connection is online, but a valid port identity was not available. Retry verification; do not continue with an unverified port.';

  @override
  String get portIncorrectTitle => 'This connected port appears incorrect';

  @override
  String get portIncorrectMessage =>
      'Do not continue. Port identity cannot be edited here. Check the port network, then check again.';

  @override
  String get portConnectedLabel => 'Connected port';

  @override
  String get portSourceServer => 'Server-provided identity';

  @override
  String get portSourceNotVerified => 'Not verified';

  @override
  String get portSourceBlocked => 'Server response · Review blocked';

  @override
  String get portNameLabel => 'Port name';

  @override
  String get portIdentifierLabel => 'Port identifier';

  @override
  String get portUnavailableValue => 'Unavailable';

  @override
  String get portLicenseLabel => 'License status';

  @override
  String get portLicenseActive => 'Active';

  @override
  String get portLicenseUnknown => 'Unknown · Not retrieved';

  @override
  String get portNoIdentityNote =>
      'No verified identity or license is available. No local port selection is permitted.';

  @override
  String get portNotMyPortAction => 'This is not my port';

  @override
  String get portContinueHint =>
      'Continue to Sign In. Your role and task permissions still apply.';

  @override
  String get portBlockedHint =>
      'Continuation is blocked until the server identity and license are verified.';

  @override
  String get portIncorrectHint =>
      'Continuation is blocked until the correct connected port is verified. No inline correction or port switching.';

  @override
  String get loginHeaderSubtitle => 'Field Operations · Sign In';

  @override
  String get loginTitle => 'Sign In to Field Operations';

  @override
  String get loginAgainTitle => 'Sign In Again';

  @override
  String get loginChangeTitle => 'Set a new password';

  @override
  String get loginPortLabel => 'Port';

  @override
  String get loginPortNotConfirmed => 'Not yet confirmed';

  @override
  String get loginPortNotConfirmedNote =>
      'Port identity will be confirmed after connection.';

  @override
  String get loginPortServerNote => 'Server-provided port identity';

  @override
  String get loginAccountLabel => 'Account';

  @override
  String get loginFirstLogin => 'First login';

  @override
  String get loginFirstLoginNote =>
      'A temporary password was used. Choose a new password to continue.';

  @override
  String get loginAccountDisabled => 'Account disabled';

  @override
  String get loginAccountDisabledNote =>
      'This account is disabled. Contact your Port Admin.';

  @override
  String get loginUsername => 'Username';

  @override
  String get loginUsernameHint => 'Enter your username';

  @override
  String get loginUsernameFixed => 'Owner of the unsent events · fixed';

  @override
  String get loginUsernameRequired => 'Username is required.';

  @override
  String get loginPassword => 'Password';

  @override
  String get loginPasswordHint => 'Enter your password';

  @override
  String get loginPasswordRequired => 'Password is required.';

  @override
  String get loginShowPassword => 'Show';

  @override
  String get loginHidePassword => 'Hide';

  @override
  String get loginAction => 'Sign In';

  @override
  String get loginSigningInAction => 'Signing In…';

  @override
  String get loginNewPassword => 'New password';

  @override
  String get loginNewPasswordHint => 'Enter new password';

  @override
  String get loginPasswordRule =>
      'At least 8 characters, with letters and numbers.';

  @override
  String get loginConfirmPassword => 'Confirm new password';

  @override
  String get loginConfirmPasswordHint => 'Repeat new password';

  @override
  String get loginNewPasswordRequired => 'This field is required.';

  @override
  String get loginPasswordTooShort => 'Use at least 8 characters.';

  @override
  String get loginPasswordLettersNumbers => 'Use both letters and numbers.';

  @override
  String get loginPasswordMismatch => 'The passwords do not match.';

  @override
  String get loginChangeAction => 'Save and continue';

  @override
  String get loginSigningInTitle => 'Signing in…';

  @override
  String get loginSigningInMessage =>
      'Verifying credentials with the server. Please wait; sign-in is not yet complete.';

  @override
  String get loginInvalidTitle => 'Sign-in unsuccessful';

  @override
  String get loginInvalidMessage =>
      'Username or password is incorrect. Check your credentials and try again.';

  @override
  String get loginExpiredTitle => 'Session expired · Sync paused';

  @override
  String loginExpiredMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Outbox events are',
      one: '1 Outbox event are',
      zero: 'the Outbox are',
    );
    return 'Reconnect and sign in as the same user before sending pending events. Cached work and $_temp0 preserved.';
  }

  @override
  String get loginReauthTitle => 'Sign in again before syncing';

  @override
  String loginReauthMessage(int count, String username) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Outbox events belong',
      one: '1 Outbox event belongs',
      zero: 'Unsent events belong',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'them',
      one: 'it',
    );
    return '$_temp0 to $username. Sign in as this user to send $_temp1; another user cannot send these events.';
  }

  @override
  String get loginOfflineTitle => 'Server connection required';

  @override
  String loginOfflineMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Cached work and $count Outbox events remain on this device; nothing has been sent.',
      one:
          'Cached work and 1 Outbox event remain on this device; nothing has been sent.',
      zero: 'Cached work remains on this device.',
    );
    return 'Sign-in cannot complete offline. $_temp0';
  }

  @override
  String get loginTooManyTitle => 'Too many attempts';

  @override
  String get loginServerErrorTitle => 'Sign-in could not complete';

  @override
  String get loginFootnote =>
      'Your session is linked to this device after sign-in.';

  @override
  String loginOutboxFootnote(String username) {
    return 'Outbox kept · Owner: $username\nSigning in again does not discard or reassign pending events.';
  }

  @override
  String get loginChangeFootnote =>
      'Required once, before any task can be opened.';

  @override
  String get loginDisabledFootnote =>
      'No tasks can be opened for a disabled account.';

  @override
  String get taskTypePilotage => 'Pilotage';

  @override
  String get taskTypeTug => 'Tug assistance';

  @override
  String get taskTypeTerminal => 'Terminal operation · actual reporting';

  @override
  String get taskStatusAssigned => 'Assigned';

  @override
  String get taskStatusStarted => 'In progress';

  @override
  String get taskStatusDone => 'Executed';

  @override
  String get systemLabelUpdated => 'Updated';

  @override
  String get systemLabelOverridden => 'Overridden';

  @override
  String get systemLabelCancelled => 'Cancelled';

  @override
  String get outboxStatusPending => 'PENDING';

  @override
  String get outboxStatusSending => 'SENDING';

  @override
  String get outboxStatusDone => 'Done';

  @override
  String get outboxStatusRejected => 'REJECTED';

  @override
  String get rejectPlanCancelled =>
      'This update was rejected because the plan was cancelled.';

  @override
  String get rejectIllegalTransition =>
      'The task status had already changed, so this update could not be applied.';

  @override
  String get rejectNotAssigned => 'This task is no longer assigned to you.';

  @override
  String get rejectNotFound => 'This task no longer exists.';

  @override
  String get rejectInvalidEvent => 'The server could not accept this update.';

  @override
  String get rejectUnknown => 'The server rejected this update.';

  @override
  String get notificationTypeAssignment => 'Task assignment';

  @override
  String get notificationTypeReminder => 'Pre-execution reminder';

  @override
  String get notificationTypeCancelled => 'Plan cancelled';

  @override
  String get notificationStatusSent => 'Sent';

  @override
  String get notificationStatusFailed => 'Failed';

  @override
  String get notificationStatusAcknowledged => 'Acknowledged';

  @override
  String get eventAcknowledgement => 'Acknowledgement';

  @override
  String get eventDeviceLabel => 'Device record';

  @override
  String get eventDispatchLabel => 'Dispatch';

  @override
  String get eventAcceptanceLabel => 'Server acceptance';

  @override
  String get eventDeviceNone => 'No local status update saved';

  @override
  String eventDeviceSaved(String action, String time) {
    return '$action saved · $time';
  }

  @override
  String get eventDispatchNone => 'No status update submitted';

  @override
  String get eventDispatchWaiting => 'Not dispatched · Pending';

  @override
  String get eventDispatchFailed => 'Attempt failed · retained';

  @override
  String get eventDispatchSending => 'Sending · response awaited';

  @override
  String eventDispatchDone(String time) {
    return 'Dispatched · $time';
  }

  @override
  String get eventAcceptanceNone => 'No new update awaiting acceptance';

  @override
  String eventAcceptanceWaiting(String action) {
    return '$action not confirmed';
  }

  @override
  String eventAcceptanceDone(String action, String time) {
    return '$action accepted · $time';
  }

  @override
  String eventAcceptanceRejected(String action) {
    return '$action rejected · retained';
  }

  @override
  String get outboxAction => 'Outbox';

  @override
  String get tasksListTitle => 'My assignments';

  @override
  String tasksListTitleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tasks',
      one: '1 task',
    );
    return 'My assignments · $_temp0';
  }

  @override
  String get tasksListTitleCt => 'Terminal A · Actual reporting';

  @override
  String tasksListTitleCtCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tasks',
      one: '1 task',
    );
    return 'Terminal A · Actual reporting · $_temp0';
  }

  @override
  String get tasksRefreshAction => 'Refresh';

  @override
  String get tasksRefreshing => 'Refreshing…';

  @override
  String get tasksSyncLoading => 'Loading assignments · sync separate';

  @override
  String tasksSyncPending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pending events',
      one: '1 pending event',
    );
    return '$_temp0 · not server-confirmed';
  }

  @override
  String get tasksSyncNone => 'No queued execution updates';

  @override
  String get tasksFeedOnline =>
      'Live assignment updates on · Connection is not sync confirmation';

  @override
  String get tasksFeedOffline =>
      'Assignment feed disconnected · Reconnect for current assignments';

  @override
  String get tasksLoadingMessage => 'Loading My Tasks…';

  @override
  String get tasksEmptyTitle => 'No tasks assigned';

  @override
  String get tasksEmptyMessage =>
      'New assignments will appear through the live update feed. You can also refresh the list.';

  @override
  String get tasksErrorMessage =>
      'The request failed. Retry to request your assigned tasks again.';

  @override
  String get tasksErrorNoticeTitle => 'Assignment list unavailable';

  @override
  String get tasksErrorNoticeMessage =>
      'The assigned-task list could not be loaded. This does not mean you have no tasks, and no task or update was changed.';

  @override
  String get tasksLoadingNoticeTitle => 'Loading your assigned tasks';

  @override
  String get tasksLoadingNoticeMessage =>
      'Request in progress. Loading does not mean there are no tasks.';

  @override
  String get tasksOfflineEmptyTitle => 'Offline · no cached tasks';

  @override
  String tasksOfflineEmptyMessage(String name) {
    return 'This device has no cached assigned tasks for $name. Connect to load tasks.';
  }

  @override
  String get tasksOfflineCachedTitle => 'Offline · cached tasks may be stale';

  @override
  String tasksOfflineCachedMessage(String time) {
    return 'Last cached: $time. Open a cached task to record actual execution; unsent updates remain on this device.';
  }

  @override
  String get tasksOfflineCachedMessageNoTime =>
      'Open a cached task to record actual execution; unsent updates remain on this device.';

  @override
  String get tasksUpdateTitle => 'Assignment update received';

  @override
  String tasksUpdateMessage(String reference) {
    return 'Update received for $reference. Review it in Task Details. Your pending updates are not replaced.';
  }

  @override
  String get tasksLockedTitle => 'Task changed by the planner';

  @override
  String tasksLockedMessage(String reference) {
    return '$reference was cancelled or replaced by a newer plan. Its actions are stopped.';
  }

  @override
  String tasksPendingTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count local updates awaiting acceptance',
      one: '1 local update awaiting acceptance',
    );
    return '$_temp0';
  }

  @override
  String tasksPendingMessage(String action, String time) {
    return '$action was saved on this device at $time. The server-confirmed status stays as it is until acceptance.';
  }

  @override
  String get tasksEmptyNoticeTitle => 'Assignment list received';

  @override
  String tasksEmptyNoticeMessage(String name) {
    return 'No tasks are assigned to $name in the current server result.';
  }

  @override
  String get tasksScopeTitle => 'Your assigned tasks only';

  @override
  String tasksScopeMessage(String name) {
    return 'Signed in as $name. Open an assigned task to acknowledge it and record actual execution in Task Details.';
  }

  @override
  String get tasksScopeTugTitle => 'Your Tug Master assignments';

  @override
  String get tasksScopeCtTitle => 'Your terminal scope';

  @override
  String tasksScopeCtMessage(String name) {
    return 'Signed in as $name. Terminal operations that need actual-status reporting. No other terminal records are shown.';
  }

  @override
  String taskTugRef(String tug) {
    return 'Tug $tug';
  }

  @override
  String get taskCached => 'Cached';

  @override
  String get taskBerth => 'Berth';

  @override
  String get taskScheduledTime => 'Scheduled time';

  @override
  String get taskType => 'Task type';

  @override
  String get taskLocalUpdate => 'Local execution update';

  @override
  String taskLocalSaved(String action) {
    return '$action · saved on device';
  }

  @override
  String get taskLocalNone => 'None saved';

  @override
  String get taskSynchronization => 'Synchronization';

  @override
  String get taskSyncPending => 'Pending · not server-confirmed';

  @override
  String get taskSyncSending => 'Sending · response awaited';

  @override
  String get taskSyncRejected => 'Rejected · see Outbox';

  @override
  String get taskSyncNone => 'No queued update for this task';

  @override
  String get taskOpenAction => 'Open Task';

  @override
  String get taskServer => 'Server';

  @override
  String get taskServerCached => 'Server · cached';

  @override
  String get taskServerNoUpdate => 'No execution update recorded';

  @override
  String get taskDetailsTitle => 'Task Details & Status Update';

  @override
  String taskDetailsSubtitle(String reference, String type) {
    return 'Task $reference · $type';
  }

  @override
  String get taskDetailsSubtitleEmpty => 'Field execution';

  @override
  String get taskLoadingTitle => 'Loading task details…';

  @override
  String get taskLoadingMessage =>
      'Retrieving the assigned task from the server. Cached data stays visible if it exists.';

  @override
  String get taskLoadingData => 'Loading task data…';

  @override
  String get taskNoDataNoticeTitle => 'Task data unavailable';

  @override
  String get taskNoDataNoticeMessage =>
      'There is no task record to display. This does not mean the task is completed.';

  @override
  String get taskNoDataTitle => 'No task data available';

  @override
  String get taskNoDataMessage =>
      'Task details are unavailable on this device. Return to My Tasks to review your assigned work.';

  @override
  String get taskCancelledTitle => 'Task cancelled by the planner';

  @override
  String get taskCancelledMessage =>
      'This task was cancelled. Actions are stopped; any local update is kept in the Outbox but cannot be applied.';

  @override
  String get taskOverriddenTitle => 'Overridden by a newer plan';

  @override
  String get taskOverriddenMessage =>
      'A newer plan version replaced this assignment. Actions are stopped; any local update is kept for review and is not applied.';

  @override
  String get taskRejectedTitle => 'Rejected by server · update kept';

  @override
  String get taskSyncFailedTitle => 'Synchronization failed · update kept';

  @override
  String taskSyncFailedMessage(String action) {
    return '$action has not been accepted by the server. Your local update and cached task data remain available.';
  }

  @override
  String get taskOfflineTitle => 'Offline · using cached task data';

  @override
  String get taskOfflineMessage =>
      'You can still record actual execution. Saved updates remain on this device and in the Outbox until server acceptance.';

  @override
  String get taskUpdatedTitle => 'Received plan change · review assignment';

  @override
  String get taskUpdatedMessage =>
      'The planner updated this task. Review the details below; your local updates are kept.';

  @override
  String get taskPendingTitle => 'Local update awaiting synchronization';

  @override
  String taskPendingMessage(String action) {
    return '$action is saved on this device and waiting to be sent. Online does not mean the server has accepted it.';
  }

  @override
  String get taskConfirmedTitle => 'Execution update confirmed by server';

  @override
  String taskConfirmedMessage(String action, String time) {
    return 'The server accepted $action at $time. That update has left the Outbox queue.';
  }

  @override
  String get taskAcknowledgedTitle => 'Task acknowledged';

  @override
  String get taskAcknowledgedMessage =>
      'Your acknowledgment is recorded. It does not record In progress or Executed; save the execution status separately.';

  @override
  String get taskNotAcknowledgedTitle => 'Not yet acknowledged';

  @override
  String get taskNotAcknowledgedMessage =>
      'Opening this task does not acknowledge it. Use Acknowledge; execution updates remain available.';

  @override
  String get taskInfoTitle => 'Task information';

  @override
  String get taskInfoTitleCached => 'Task information · cached';

  @override
  String get taskVesselName => 'Vessel Name';

  @override
  String get taskPlannedTime => 'Planned Time';

  @override
  String get taskAssignedBerth => 'Assigned Berth';

  @override
  String get taskAssignedTugs => 'Assigned Tug(s)';

  @override
  String get taskAssignedPilot => 'Assigned Marine Pilot';

  @override
  String get taskPlanReference => 'Plan / assignment reference';

  @override
  String get taskAckTitle => 'Acknowledge Task';

  @override
  String get taskAckNotYet => 'Not yet acknowledged';

  @override
  String taskAckDone(String time) {
    return 'Acknowledged by you · $time';
  }

  @override
  String taskAckSaved(String time) {
    return 'Acknowledged · saved on device $time';
  }

  @override
  String get taskAcknowledgeAction => 'Acknowledge';

  @override
  String get taskAcknowledgedBadge => 'Acknowledged';

  @override
  String get taskUpdateTitle => 'Update Task Status';

  @override
  String taskServerConfirmed(String status) {
    return 'Server-confirmed status: $status';
  }

  @override
  String taskLatestLocal(String status) {
    return 'Latest local update: $status';
  }

  @override
  String get taskSelectionNote =>
      'Choose the status, then save. A selection alone is not saved.';

  @override
  String get taskSaveAction => 'Save Status Update';

  @override
  String get taskSaveSyncLabel => 'Save & Synchronization';

  @override
  String get taskSyncNoTask => 'No task record on device';

  @override
  String get taskSyncNoTaskNote =>
      'Online connection does not confirm task availability.';

  @override
  String get taskSyncAckSeparate =>
      'Acknowledgment is separate from execution status.';

  @override
  String get taskSyncRejectedTitle => 'Rejected by server';

  @override
  String get taskSyncRejectedNote => 'Kept in the Outbox as Rejected.';

  @override
  String get taskSyncFailedShort => 'Synchronization failed';

  @override
  String get taskSyncFailedNote =>
      'Not accepted yet · kept in the Outbox as Pending.';

  @override
  String get taskSyncPendingOffline => 'Pending Sync · Offline';

  @override
  String taskSyncCachedAt(String time) {
    return 'Task last cached: $time';
  }

  @override
  String get taskSyncPendingTitle => 'Pending Sync';

  @override
  String get taskSyncSendingTitle => 'Sending';

  @override
  String get taskSyncWaitingNote =>
      'Waiting to be sent; server acceptance not confirmed.';

  @override
  String get taskSyncDoneTitle => 'Done · confirmed by server';

  @override
  String taskSyncDoneNote(String saved, String accepted) {
    return 'Device save: $saved · Acceptance: $accepted';
  }

  @override
  String get taskOutboxLabel => 'Outbox';

  @override
  String taskOutboxRetained(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count updates kept',
      one: '1 update kept',
    );
    return 'Outbox · $_temp0';
  }

  @override
  String taskOutboxWaiting(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count updates awaiting sync',
      one: '1 update awaiting sync',
    );
    return '$_temp0';
  }

  @override
  String get taskOutboxEmpty => 'No queued updates';

  @override
  String get taskRetrySyncAction => 'Retry Sync';

  @override
  String get syncTitle => 'Sync Status & Outbox';

  @override
  String get syncStripSending => 'SENDING · awaiting server response';

  @override
  String syncStripFailed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Pending kept',
      one: '1 Pending kept',
    );
    return 'Sync failure · $_temp0';
  }

  @override
  String get syncStripOffline => 'Pending · sending paused offline';

  @override
  String syncStripRejected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Rejected events · kept',
      one: '1 Rejected event · kept',
    );
    return '$_temp0';
  }

  @override
  String get syncStripConfirmed => 'Synchronization confirmed';

  @override
  String get syncStripNone => 'No pending events';

  @override
  String get syncStripCaption =>
      'Device save → dispatch → server acceptance are separate steps';

  @override
  String get syncSendingAction => 'Sending…';

  @override
  String get syncRetryAction => 'Retry now';

  @override
  String get syncRefreshAction => 'Refresh status';

  @override
  String get syncCountPending => 'Pending events';

  @override
  String get syncCountDone => 'Done events';

  @override
  String get syncCountRejected => 'Rejected events';

  @override
  String syncListTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kept records',
      one: '1 kept record',
      zero: 'none',
    );
    return 'Device events · $_temp0';
  }

  @override
  String get syncEmptyTitle => 'No events on this device';

  @override
  String get syncEmptyMessage =>
      'Acknowledgements and status updates you save will appear here until the server confirms them.';

  @override
  String syncOwnership(String username) {
    return 'Recorded by: $username · Events stay on this device';
  }

  @override
  String get syncOwnershipNote =>
      'No silent deletion or reassignment. Going offline or signing in again does not change who owns an event.';

  @override
  String get syncWipedTitle => 'Device wiped';

  @override
  String get syncWipedMessage =>
      'Events still PENDING on a wiped or reinstalled device are lost. Done events are removed after 30 days.';

  @override
  String get syncSendingTitle => 'Dispatch in progress';

  @override
  String get syncSendingMessage =>
      'Events are SENDING while the request is in flight and return to PENDING if sending fails. Sending is not server acceptance.';

  @override
  String get syncFailedTitle => 'Send failed · can be retried';

  @override
  String get syncFailedMessage =>
      'The send attempt failed before the server answered. Saved events stay PENDING and are retried automatically. Events never sent are lost if the device is wiped.';

  @override
  String get syncOfflineTitle => 'Saved here; not sent';

  @override
  String syncOfflineMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count events remain',
      one: '1 event remains',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'them',
      one: 'it',
    );
    return '$_temp0 on this device. Reconnect to send under the user who recorded $_temp1; saving offline is not server acceptance.';
  }

  @override
  String get syncRejectedTitle => 'Final rejection by the server';

  @override
  String get syncRejectedMessage =>
      'A rejected event stays visible with its reason. Retrying cannot bypass a rejection.';

  @override
  String get syncWaitingTitle => 'Waiting to send';

  @override
  String get syncWaitingMessage =>
      'Saved events are sent in order as soon as the server can be reached.';

  @override
  String get syncConfirmedTitle => 'Server receipt confirmed';

  @override
  String get syncConfirmedMessage =>
      'An event is Done only after the server accepts it. Confirmed history stays visible.';

  @override
  String get syncEventLabel => 'Event / status update';

  @override
  String syncEventStatus(String status) {
    return 'Actual execution: $status';
  }

  @override
  String get syncRecordedLabel => 'Recorded on device';

  @override
  String get syncRelatedLabel => 'Related assignment';

  @override
  String syncRelatedValue(String terminal, String berth) {
    return '$terminal · Berth $berth';
  }

  @override
  String get syncDeviceSaveLabel => 'Device save';

  @override
  String get syncDeviceSaved => 'Saved on Device · kept';

  @override
  String get syncDispatchOffline => 'Not dispatched · offline';

  @override
  String get syncEventPendingNote =>
      'Pending is not Done: the server has not confirmed this update.';

  @override
  String get syncEventFailedNote =>
      'The previous send failed. It stays Pending until the server accepts it.';

  @override
  String syncEventRejectedNote(String reason) {
    return 'Rejection reason: $reason';
  }

  @override
  String get syncEventDoneNote =>
      'Confirmed history · Done events stay on the device for 30 days, then are removed.';

  @override
  String get settingsTitle => 'Settings & Session';

  @override
  String get settingsLoading => 'Loading settings…';

  @override
  String get settingsStripNoEvents => 'No pending execution events';

  @override
  String get settingsStripNone =>
      'Device: no queued update · Dispatch: none · Server: no new acceptance claimed';

  @override
  String get settingsStripUnknown =>
      'Connection status unavailable · sync not verified';

  @override
  String settingsStripPending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Pending events',
      one: '1 Pending event',
    );
    return '$_temp0 · preserved on device';
  }

  @override
  String settingsStripPendingCaption(String action) {
    return 'Device: saved · Dispatch: not sent · Server: $action not confirmed';
  }

  @override
  String get settingsReadOnlyTitle => 'Read-only information';

  @override
  String get settingsReadOnlyMessage =>
      'Current authenticated user and current device only. Account, port, and application information cannot be edited here.';

  @override
  String get settingsPendingTitle => 'Review unsent updates before logout';

  @override
  String get settingsPendingMessage =>
      'Logging out does not clear or transfer pending events. Review Outbox now; same-user reauthentication is required for sending.';

  @override
  String get settingsUnknownTitle => 'Unknown is not Offline';

  @override
  String get settingsUnknownMessage =>
      'The app cannot determine the current connection. No Offline or sync-success claim is made; available account information stays read-only.';

  @override
  String get settingsAccountTitle => 'Account';

  @override
  String get settingsAccountName => 'Account name';

  @override
  String get settingsUsername => 'Username';

  @override
  String get settingsRole => 'Assigned role';

  @override
  String get settingsPortTitle => 'Port';

  @override
  String get settingsPortName => 'Port name';

  @override
  String get settingsPortId => 'Port identifier';

  @override
  String get settingsPortNote => 'Server-provided port context';

  @override
  String get settingsNotAvailable => 'Not available';

  @override
  String get settingsAppTitle => 'Application & Device';

  @override
  String get settingsVersion => 'Installed version';

  @override
  String get settingsDevice => 'Device information';

  @override
  String get settingsConnection => 'Current connection';

  @override
  String get settingsAppNote =>
      'Only information available to this app is shown. Language: English or Arabic (RTL layout). Pending updates stay on the device when the token expires.';

  @override
  String get settingsSessionTitle => 'Session';

  @override
  String get settingsSessionMessage =>
      'Log Out ends the session on this device.';

  @override
  String settingsSessionPending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Pending events',
      one: '1 Pending event',
    );
    return '$_temp0 · original-user ownership retained';
  }

  @override
  String get settingsReviewOutbox => 'Review Outbox';

  @override
  String get settingsLogOut => 'Log Out';

  @override
  String get logoutDialogTitle => 'Log out of this device?';

  @override
  String get logoutDialogMessage => 'Your current session will end.';

  @override
  String logoutDialogMessagePending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count unsent updates remain',
      one: '1 unsent update remains',
    );
    return 'Your current session will end. $_temp0 Pending on this device and may require reauthentication.';
  }

  @override
  String logoutRetainedTitle(String action) {
    return '$action · Saved on Device · not dispatched or accepted';
  }

  @override
  String logoutRetainedMessage(String username) {
    return 'Owner: $username. Sign in again as this same user to sync. Events are never discarded or reassigned at logout.';
  }

  @override
  String get logoutReviewPending => 'Review Pending Events';

  @override
  String get logoutConfirm => 'Confirm Log Out';

  @override
  String get signedOutHeader => 'Field Operations · Signed Out';

  @override
  String get signedOutTitle => 'You’re signed out';

  @override
  String get signedOutMessage =>
      'The current device session has ended. Sign in again through Sign In to return to the authenticated application.';

  @override
  String signedOutPendingTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count unsent updates remain',
      one: '1 unsent update remains',
    );
    return '$_temp0 Pending on this device';
  }

  @override
  String signedOutPendingMessage(String username) {
    return 'Original recording user: $username. Reauthenticate as this same user before sync; another user cannot send this event.';
  }

  @override
  String get signedOutDeviceRecord => 'Device record';

  @override
  String signedOutDeviceRecordValue(String action, String time) {
    return '$action · saved at $time · retained';
  }

  @override
  String get signedOutDispatchValue => 'Paused · no active session';

  @override
  String get signedOutFootnote =>
      'Logout did not send, clear, discard, or transfer pending events. No authenticated account settings are exposed here.';

  @override
  String get notifStripLoading => 'Receiving notifications…';

  @override
  String get notifStripLoadingCaption => 'Synchronization not yet confirmed';

  @override
  String get notifStripError => 'Refresh unavailable';

  @override
  String get notifStripOffline => 'Offline · showing saved notifications';

  @override
  String get notifStripReceived => 'Updates received from the port server';

  @override
  String notifLastSync(String time) {
    return 'Last list sync: $time';
  }

  @override
  String get notifCachedCaption =>
      'Saved on this device; new notifications arrive after reconnecting';

  @override
  String get notifErrorTitle => 'Unable to refresh notifications';

  @override
  String get notifErrorMessage =>
      'The connection to the port server is unavailable. This is a list-loading error, not a Failed notification status.';

  @override
  String get notifOfflineTitle => 'Offline';

  @override
  String get notifOfflineMessage =>
      'Acknowledgements you make now are saved on the device and sent when the connection is back.';

  @override
  String get notifFailedTitle => 'A notification could not be delivered';

  @override
  String get notifFailedMessage =>
      'Failed means the system could not distribute it. Acknowledging does not fix it, and there is no manual resend. Open the task to check it.';

  @override
  String get notifFilterAll => 'All';

  @override
  String get notifListTitle => 'My notifications';

  @override
  String notifListTitleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count',
      one: '1',
      zero: 'none',
    );
    return 'My notifications · $_temp0 · newest first';
  }

  @override
  String get notifLoadingMessage => 'Loading notifications…';

  @override
  String get notifEmptyTitle => 'No notifications';

  @override
  String get notifEmptyMessage =>
      'New assignments, reminders and cancelled plans will appear here.';

  @override
  String get notifErrorListMessage =>
      'New notifications and current statuses could not be loaded.';

  @override
  String get notifFilteredEmptyTitle => 'No notifications match your filter';

  @override
  String notifFilteredEmptyMessage(String status) {
    return 'Nothing with status “$status”. Clear the filter to see all your notifications.';
  }

  @override
  String get notifClearFilter => 'Clear filter';

  @override
  String get notifExplainTitle => 'Understanding status and delivery';

  @override
  String get notifExplainStatus =>
      'Sent = dispatched by the system, not device delivery. Failed = distribution failure. Acknowledged = user acknowledgement, not proof of device synchronization.';

  @override
  String get notifExplainOffline =>
      'Acknowledgements made offline wait in the Outbox until the server accepts them.';

  @override
  String get notifMessageAssignment => 'You have been assigned to this task.';

  @override
  String get notifMessageReminder => 'This task starts soon.';

  @override
  String get notifMessageCancelled =>
      'The plan for this task was cancelled. No more actions are possible.';

  @override
  String get notifNoteSent =>
      'System dispatch confirmed. Acknowledge to confirm you have seen it.';

  @override
  String get notifNoteAckPending =>
      'Acknowledgement saved on device · waiting for server acceptance.';

  @override
  String get notifNoteFailed =>
      'Distribution failed. Not resolved by acknowledgement; no manual resend.';

  @override
  String notifNoteAcknowledged(String time) {
    return 'Acknowledged at $time. User acknowledgement only.';
  }

  @override
  String get notifRelatedTask => 'Related task';

  @override
  String get notifTimestamp => 'Received';

  @override
  String get notifOpenTask => 'Open task';

  @override
  String get notifAcknowledge => 'Acknowledge';

  @override
  String get notifAckSavedAction => 'Saved · pending sync';

  @override
  String get notifAckSavedBadge => 'Ack pending';
}
