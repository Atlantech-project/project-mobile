# Task notes — ATLANTECH Mobile

Changes to the Mobile roadmap tasks (MB-xx) after the contracts review (CT-01, CT-04, CT-06, CT-07, DEC-39, DEC-40, DEC-54, DEC-58).

## How to use this file

- Read it before starting any MB task.
- Find the section with the task ID. If there is none, the roadmap text is current.
- The roadmap text stays the base. A note adds to it or replaces the part it names.
- If the roadmap text already says what a note says, ignore the duplicate.
- If a note and a contract (CT-xx) disagree, stop and ask Farouk. The contract wins.
- "Done when" of each task does not change, unless a note says so.

## Global rules (apply to every task)

- Outbox field names: `client_event_id` (was `idempotency_key`) and `reported_at` (was `recorded_at`). Also `client_sent_at` and `sync_source`.
- Connection check: `GET /api/v1/system/info`. There is no `/system/ping` (DEC-58).
- Sign-in: `POST /api/v1/auth/mobile/login`. `X-Device-Id` and `X-App-Version` are headers, not body fields.
- Errors are problem bodies: `code`, `message_key`, `detail`, and `errors` (422), `current` (409), `min_app_version` (426). Branch on `code`. Translate by `message_key`. Never branch on `detail`.
- Datetimes sent: UTC ISO 8601 with microseconds and `Z`.
- `version` is an opaque string. Never turn it into a DateTime.
- `Idempotency-Key` goes on every write except `/sync/events`, `/auth/mobile/login` and `/broadcasting/auth`.
- A sync event never returns 409.
- READ_ONLY banner and the 14-day token warning are deferred (DEC-54). `license_mode` is always `FULL` and `token_warning_days_left` is always `null` for now.

## Tasks with no change

MB-F1 · MB-P56 · MB-P20 · MB-P57 · MB-S01 · MB-R2

---

## MB-F2 · Network layer

Roadmap says: "error mapping (401, 403, 409, 422, 426), Root CA trust, ping"

- Do not use `Idempotency-Key` on `/sync/events`, `/auth/mobile/login` and `/broadcasting/auth`.
- Map these codes to custom exceptions: 401, 403, 404, 409, 422, 423, 426, 429, 503.
- Parse the problem body (see Global rules). Translate by `message_key` from the app's Arabic and English files, fall back to the English `detail`.
- Replace "ping" with `checkConnection()` on `GET /system/info` (no sign-in, never 426).
- Send every datetime as UTC ISO 8601 with microseconds and `Z`.

## MB-F3 · Local storage

Roadmap says: "Outbox and cache models, meta box"

- Outbox model fields: `client_event_id`, `type`, `payload`, `reported_at`, `client_sent_at`, `sync_source`, `status`, `attempts`, `user_id`, `reason_code`.
- Task cache keeps `system_label`. Notification cache keeps `acknowledged_at`.
- Keep every `version` as a string.
- Detect the device class once (shortest display side of 600 dp or more is `TABLET`, otherwise `MOBILE`) and store it for `sync_source`.

## MB-F4A · Sync engine core

Roadmap says: "enqueue, ordered send, backoff ping, idempotency key reuse, DONE/REJECTED/PENDING rules, purge, counters stream"

- `enqueue(event)` writes `reported_at` and a new UUID v4 `client_event_id`.
- Backoff check uses `GET /system/info` (up to 5 tries, from 2 s, doubling, max 60 s).
- A retry sends the same `client_event_id`.
- `APPLIED` or `DUPLICATE` makes the event `DONE`.
- `REJECTED` stores the `reason_code`. An unknown code is shown as a general rejection.
- Events left in `SENDING` go back to `PENDING` when the app starts.
- Start a sync cycle right after an event is saved when online (DEC-41).

## MB-F4B · Sync engine integration

Roadmap says: "POST /sync/events, GET /sync/changes, 401/426 stop, same-user rule"

- `POST /sync/events` takes up to 100 events in Outbox order. A longer queue goes in several requests.
- Match every result to its event by `client_event_id`. A rejected event does not stop the next ones.
- No answer to a whole request: all its events go back to `PENDING`.
- `GET /sync/changes?since=sync_token`. No `since` on first use. Save the changes first, then store the new `sync_token`.
- If the `since` token is refused with 422, call again without `since`.
- Delete the tasks listed in `removed` from the cache.
- Stop the cycle on 401, 403 and 426 without deleting anything.
- On 403 `PASSWORD_CHANGE_REQUIRED`, go to the password change screen.

## MB-F5 · Realtime

Roadmap says: "Reverb WebSocket, event id then REST fetch, de-duplication, catch-up, Android foreground service"

- Authorise the private channel `private-user.{user_id}` with `POST /api/v1/broadcasting/auth` (Bearer, `socket_id`, `channel_name`) before connecting.
- An event is `{event_id, type, entity, entity_id}` with type `TASK_UPDATED` or `NOTIFICATION_CREATED`. Replace "REST fetch" with `GET /sync/changes`.
- Ignore an unknown event type, then fetch changes as usual.
- Handle channel errors: 403 (another user's channel or a revoked device) and 401 (sign in again).

## MB-F6 · App shell and shared states

Roadmap says: "event state chip, loading/empty/error, routing to P-20 / P-57 / P-52"

- The READ_ONLY banner and the token expiry warning are deferred (DEC-54).

## MB-P52 · Tablet Login

Roadmap says: "device data, token, forced password change, same-user Outbox rule"

- `login()` calls `POST /auth/mobile/login` with `username`, `password`, `platform` (`ANDROID`). Device id and app version go in the headers.
- Save user id, role, name, `terminal_ids` and `expires_at`.
- `changePassword()` calls `POST /auth/change-password`. Check on the device: at least 8 characters, letters and numbers, different from the current one.
- Error 429: ask the user to wait, using `Retry-After`.
- Handle 403 `PASSWORD_CHANGE_REQUIRED` at any time: go to the password change.

## MB-P53 · Port Identification

Roadmap says: "GET /system/info, min app version check, offline fallback"

- Save `port_id`, `port_code`, `port_name`, `license_mode`, `token_warning_days_left` and `min_app_version` in the meta box.

## MB-P54 · My Tasks

Roadmap says: "plan-changed notice"

- Replace the plan-changed notice with the `system_label` badge on each card (`UPDATED`, `OVERRIDDEN`, `CANCELLED`).
- The READ_ONLY banner and token warning on this screen are deferred (DEC-54).
- Role content comes from `component_type`: `PILOT`, `TUG`, `TERMINAL_OPS`.

## MB-P55 · Task Details and Status Update

Roadmap says: "Acknowledge, In progress / Executed, offline save, 409, rejected events"

- Buttons write `STATUS_UPDATE` with `plan_component_id` and `new_status` (`STARTED` or `DONE`). The labels stay In progress and Executed.
- Terminal components use the same two values (DEC-39).
- Acknowledge writes `ACKNOWLEDGE` with the `notification_id` of the task: any `SENT` one, normally the newest (DEC-40, DEC-58).
- Show `system_label` from the server. `OVERRIDDEN` and `CANCELLED` stop every action. Hide `UPDATED` locally as soon as the user's event is saved in the Outbox.
- Replace "409" with `ILLEGAL_TRANSITION`: redraw from `current` (`status`, `version`). If it equals the requested status, show "already updated".
- Rejected events: readable text for `PLAN_CANCELLED`, `ILLEGAL_TRANSITION`, `NOT_ASSIGNED`, `NOT_FOUND`, `INVALID_EVENT`. An unknown code is a general rejection.

## MB-P19 · Notifications

Roadmap says: "list, acknowledge via Outbox, open related task"

- Status values: `SENT`, `FAILED`, `ACKNOWLEDGED`, with `acknowledged_at`. An escalation is a separate `ACK_ESCALATION` row, not a status.
- Mobile types: `PLAN_ASSIGNMENT` (the T+10 and T+20 re-sends are the same type), `PRE_EXECUTION_REMINDER`, `PLAN_CANCELLED`.
- A new notification comes from `NOTIFICATION_CREATED`, then `GET /sync/changes`.
- Acknowledge writes `ACKNOWLEDGE`. The server acknowledges every `SENT` row of the same task. They come back in the next changes.
- Show `FAILED` clearly. There is no manual resend.

## MB-P58 · Settings and Session

Roadmap says: "logout online/offline, keep pending events"

- Online logout calls `POST /api/v1/auth/logout` (204, Bearer). Offline logout deletes the local token only.

## MB-R1 · Field test suite

Roadmap says: "airplane mode, duplicate send, cancelled plan offline, token expiry, 426, logout, each role, phone and tablet sizes"

- Add: a queue of more than 100 events is split into several requests and results are matched by `client_event_id`.
- Add: a refused `since` token (422) is retried without `since`.
- READ_ONLY tests are deferred (DEC-54).
- "Agree the acknowledge event type and payload" is no longer a task. It is closed (DEC-40).
