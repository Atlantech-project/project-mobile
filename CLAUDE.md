# ATLANTECH Mobile (Flutter) — Project Rules for Claude Code

Read this file fully before any task. Detailed docs live in `docs/`:
- `docs/Flutter_Architecture.md` — the architecture blueprint (source of truth for behavior)
- `docs/design_tokens.md` — every design token value extracted from Figma

## 1. Project facts

- Field app for port operations (Marine Pilot, Tug Master, CT Supervisor; NCT Supervisor deferred).
- **Android only.** No iOS, no web, no desktop.
- **Tablet first** (design frame 1280 × 800). The same pages run on phones at a smaller size. One codebase, no separate phone screens.
- applicationId / namespace: `io.atlantech.mobile` · Dart package name: `atlantech`
- Flutter 3.47.8 · Dart 3.13.x
- 9 screens only: P-53, P-52, P-54, P-55, P-56, P-19, P-20, P-57, P-58. Content changes by role, not the screen.
- **App shell follows the Figma design: top header (88) + footer (40), no bottom navigation bar.** Navigation between pages goes through the header.

## 2. Stack (do not substitute)

| Concern | Package |
|---|---|
| State | flutter_bloc (Cubit by default) |
| DI | get_it |
| Navigation | go_router |
| HTTP | dio — one instance only (added in MB-F2) |
| Local storage | hive_ce, encrypted boxes (added in MB-F3) |
| Secure storage | flutter_secure_storage (added in MB-F3) |
| Localization | flutter_localizations + intl + gen-l10n (ARB files) |
| Connectivity | connectivity_plus — `ConnectionCubit` in `core/network/` (added in MB-S01) |

**Never use:** Riverpod, GetX, Provider-as-state, Drift, Isar, FCM/APNs/any push service, the `google_fonts` package (fonts are bundled because the app runs on a closed port network).

**Only add the packages the current task needs.** Do not pre-install packages for future tasks.

## 3. Folder structure (Feature-First)

```
lib/
├── core/
│   ├── config/        app_config.dart (base URL, defaults)
│   ├── di/            injection.dart (setupInjection)
│   ├── router/        app_router.dart, app_routes.dart, session_state.dart
│   ├── theme/         tokens + ThemeData (see section 5)
│   ├── localization/  l10n/*.arb + generated files, locale_cubit.dart
│   ├── responsive/    responsive.dart
│   ├── errors/        custom exceptions (MB-F2)
│   ├── network/       dio_client.dart, interceptors/ (MB-F2)
│   ├── storage/       Hive boxes + encryption key (MB-F3)
│   ├── sync/          Outbox engine (MB-F4)
│   ├── models/
│   └── widgets/       shared design-system widgets (App* prefix)
├── features/
│   ├── auth/           P-53, P-52
│   ├── tasks/          P-54, P-55
│   ├── sync/           P-56
│   ├── notifications/  P-19
│   ├── settings/       P-58
│   └── system/         P-57, P-20, license banners
│       each feature: cubit/  screens/  widgets/  data/
└── main.dart
```

## 4. Architecture rules

- Flow: `UI → Cubit → Repository → (DioClient + Hive)`.
- A Cubit never touches Dio or Hive directly. Only Repositories do.
- Reads are cache-first. Writes go to the Outbox first (from MB-F4 onward).
- Register shared objects in `setupInjection()`; never construct singletons inside widgets.
- No business logic inside widgets.
- Testing is out of scope for this team (QA owns it). Do not generate test files unless asked.

## 5. Design system rules

- Figma file key: `E5LYIJCA56H7xZQ5Zf8CNx`. Pages: `Design System · Foundations` (241:29), `UI Design` (243:2), `Components` (260:2).
- All values come from `docs/design_tokens.md`. **Never hardcode a hex color, font size, spacing or radius in a widget.**
- Widgets use **semantic** tokens only (e.g. `AppColors.textPrimary`, `AppColors.statusWarningBg`). Primitive scales (navy/teal/gold/neutral 50–950) exist only to define semantic tokens.
- Text uses the `AppTextStyles` that mirror the Figma text styles. On tablet screens prefer the `Tablet/*` styles. Important text is 16 sp or larger.
- Spacing uses `AppSpacing` (4 px base). Radius uses `AppRadius`.
- Touch targets are at least 56 dp (`size/touch`). Primary status updates must be reachable in 3 taps or fewer from My Tasks.
- Status is always color **plus** a text label — never color alone.
- One strong color per screen: navy for the primary action, teal secondary/info, gold only for small accents.
- Light theme only.
- Fonts: Montserrat (headings, numbers), Inter (everything else), Roboto Mono (IDs like PT-A-0109, IMO). Arabic text falls back to the Android system font — this is intended by the design system; do not add an Arabic font.
- Shared widgets live in `core/widgets/` with the `App` prefix (`AppButton`, `AppStatusBadge`, …). Screens compose these; they do not restyle them.
- **Page states (MB-S01):** a page that loads data puts its body in `AppStateBody(status: …)`; its Cubit state carries an `AppViewStatus` (loading, ready, empty, error, offline). Never build a spinner or an empty/error layout by hand. Full pages show the brand symbol (`AppLoadingView`, `AppStateView`); inside a card or list pass `compact: true` (icon in a circle). For known progress pass `value` to `AppLoadingIndicator`.
- The splash (`/splash`, `features/system/screens/splash_screen.dart`) is the only dark screen. It uses the `cover*` colour tokens; no other screen may use them.
- When building UI from Figma: use the Figma MCP (`get_design_context`, `get_screenshot`) on the exact node, then **adapt** the result to our tokens and `App*` widgets. Never paste generated code as-is.

### Figma node map (UI Design page)

| Screen | Section node |
|---|---|
| P-53 Port Identification | 245:8078 |
| P-52 Tablet Login | 245:7734 |
| P-54 My Tasks | 245:7006 |
| P-55 Task Details | 245:6226 |
| P-56 Sync / Outbox | 245:5631 |
| P-19 Notifications | 245:32986 |
| P-20 Access Denied | 245:32883 |
| P-57 App Update Required | 245:8359 |
| P-58 Settings | 245:5329 |

| Component (Components page) | Node |
|---|---|
| Button (all variants) | 260:19 |
| Status badge | 260:30 |
| Form field | 331:24877 |
| Card | 331:24899 |
| Dialog | 331:24900 |
| Tab / Tabs | 331:24882 / 331:24883 |
| Icons 16 px line | 271:14 |

## 6. Localization and RTL

- Arabic and English, switchable at runtime. Full RTL, not just translated text.
- **No hardcoded user-facing strings.** Every string goes in `app_en.arb` and `app_ar.arb`.
- Use `EdgeInsetsDirectional`, `AlignmentDirectional`, `PositionedDirectional`, `start`/`end`. Never `left`/`right` for layout.
- Directional icons (arrows, chevrons) must mirror in RTL.
- Times, IDs and codes stay LTR inside RTL text (wrap with `Directionality(textDirection: TextDirection.ltr)` or Unicode isolation when needed).

## 7. Code style

- Run `dart format .` and `flutter analyze` before finishing; leave zero analyzer issues.
- File names `snake_case.dart`; one public widget per file for shared widgets.
- Prefer `const` constructors.
- Keep placeholder or dev-only code clearly marked with `// DEV-ONLY:` and the task ID that will replace it.

## 8. Workflow

- Every task has an ID from the tracker (e.g. `MB-F1`). Work on branch `feature/<TASK-ID>-<short-name>` from `develop`.
- Commit messages: `<TASK-ID>: <what changed>`.
- Do only what the current task asks. If something needed is missing or a doc conflicts, stop and report it instead of guessing.
- At the end of a task, report: files created/changed, packages added, anything left open.
