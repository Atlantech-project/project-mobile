# Flutter Screens checklist

The tablet screens are built as static UI on a mock backend (`lib/core/mock/`,
DEV-ONLY). Each MB task swaps one mock repository for the real one. When a task
touches a screen below, tick **Wired** and write the PR.

How to preview a state: run in debug (`USE_MOCK_DATA` is on by default) and use
the floating **Dev states** button at the bottom of each screen.

Mock sign-in: `m.farid` (Marine Pilot), `s.hassan` (Tug Master), `n.adel`
(CT Supervisor), any password except `wrong`. `new.pilot` asks for a new
password, `disabled.user` is disabled, and `web.user` goes to P-20.

| Screen | Figma | States built | Mock repository to replace | Real task | Wired | PR |
|---|---|---|---|---|---|---|
| P-53 Port Identification | 245:8078 | identified, loading, server unavailable, verification failed, "not my port" | `MockAuthRepository.identifyPort` | MB-P53 (+ MB-F2) | ☐ | |
| P-52 Login | 245:7734 | default, signing in, invalid credentials, offline, session expired (same user), account disabled, server error, first login change password, passwords do not match | `MockAuthRepository.login / changePassword` | MB-P52 (+ MB-F3 token) | ☐ | |
| P-54 My Tasks | 245:7006 | pilot, tug master, CT supervisor, loading, empty, error, offline cached, offline no cache, sync pending, assignment updated, plan cancelled | `MockTasksRepository` | MB-P54 (+ MB-F3 cache, MB-F5 changes) | ☐ | |
| P-55 Task Details & Status Update | 245:6226 | not acknowledged, acknowledged, saved on device, pending sync, synced, offline, sync failure, updated plan, overridden / cancelled (locked), no data, loading | `MockTasksRepository.acknowledge / updateStatus` | MB-P55 (+ MB-F4A/F4B Outbox) | ☐ | |
| P-56 Sync Status & Outbox | 245:5631 | empty, pending offline, syncing, done, failure, retry, rejected (reason), device wiped | `MockOutboxRepository` | MB-F4A, MB-F4B | ☐ | |
| P-19 Notifications (tablet adaptation of the web frames) | 245:32986 | populated, loading, empty, filtered no results, connection error, offline cached, acknowledge pending | `MockNotificationsRepository` | MB-P19 (+ MB-F5) | ☐ | |
| P-58 Settings & Session | 245:5329 | normal, loading, pending events before logout, logout confirmation, logout completed (`/signed-out`), connection unknown | `MockAuthRepository.logout` | MB-P58 | ☐ | |
| P-20 Access Denied | — | done before (MB-S01 / MB-P20) | — | MB-P20 | ✅ | |
| P-57 App Update Required | 245:8359 | done before (MB-P57) | — | MB-P57 | ✅ | |

## Not built (deferred)

- READ_ONLY license states and the expiring-token warning on every screen
  (DEC-54).
- P-56 "Token expired": covered by the P-52 "session expired" state, because the
  router sends a signed-out user to P-52.

## When the last real repository lands

Delete `lib/core/mock/`, the `mock_*_repository.dart` files, the
`DevScenarioMenu` usages and `AppConfig.useMockData`.
