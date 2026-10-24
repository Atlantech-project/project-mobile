<div align="center">

# 📱 ATLANTECH — Mobile App

### Offline-First Field App for Port Operations

![Status](https://img.shields.io/badge/status-in%20development-A58D66?style=for-the-badge)
![Part of](https://img.shields.io/badge/part%20of-ATLANTECH-083A4F?style=for-the-badge)

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=flat-square&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=flat-square&logo=apple&logoColor=white)
![WebSocket](https://img.shields.io/badge/WebSocket-realtime-407E8C?style=flat-square)
![Offline First](https://img.shields.io/badge/offline--first-Outbox-083A4F?style=flat-square)

</div>

---

## 📖 Overview

The mobile app is used by **field executors — pilots, tug masters and supervisors** — to receive tasks and report actual operational status. It is built to keep working when the network does not.

### Key features
- 📥 **Task dispatch** — receive assigned tasks from confirmed operational plans.
- 📍 **Status updates** — report actual times and progress; feeds tracking, deviations and the AI feedback loop.
- 📴 **Offline-first Outbox** — actions are queued locally with idempotency keys and synced through `/sync/events` when back online.
- 🔔 **Realtime** — WebSocket event, then a REST fetch of the full payload (no FCM / APNs push service).
- 🔒 **Secure by design** — managed devices (MDM), per-app always-on VPN, split DNS `app.atlantech.io`.

---

## 🛠️ Tech Stack

| Area | Technology |
|---|---|
| Framework | Flutter (Dart) |
| Platforms | Android · iOS |
| Communication | REST over HTTPS · WebSocket (Laravel Reverb) |
| Sync | Local Outbox, idempotent events |
| Network | Per-app VPN through the port VPN gateway |
| Backend | [ATLANTECH Port API](https://github.com/Atlantech-project/project-backend) (Laravel) |

---

## 🚀 Getting Started

**Requirements:** Flutter SDK with Dart `^3.11.5`, Android Studio / Xcode.

```bash
git clone https://github.com/Atlantech-project/project-mobile.git
cd project-mobile

flutter pub get
flutter run
```

### 🧪 Tests & analysis
```bash
flutter test
flutter analyze
```

---

## 🔗 Related Repositories

| | Repository |
|---|---|
| ⚓ Umbrella | [PortHub](https://github.com/Atlantech-project/PortHub) |
| ⚙️ Backend | [project-backend](https://github.com/Atlantech-project/project-backend) |
| 🧠 AI | [project-ai](https://github.com/Atlantech-project/project-ai) |
| 🖥️ Frontend | [project-frontend](https://github.com/Atlantech-project/project-frontend) |

## 👥 Mobile Team

- **Farouk Ahmed Farouk El-Balkiny** — Mobile App Developer

---

<div align="center">

⚓ *ATLANTECH — Intelligent Port Operations* · Mansoura University · Graduation Project 2026

</div>
