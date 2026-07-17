# Time Saver App (Flutter) ⏱️

A cross-platform (Android/iOS) task and time-tracking app built with **Flutter**, letting users add tasks, track time spent on them with a start/stop mechanic, and persist everything locally on-device.

> This is the original Flutter/file-based version of the Time Saver app — later reimplemented natively in Kotlin using Room Database (see [RoomDatabaseTimeSaverApp](https://github.com/dev2imp/RoomDatabaseTimeSaverApp)) to move from file-based storage to a proper relational database.

## 📋 Overview

Users can create tasks, run/stop time tracking per task, and view accumulated time per task session. Data is persisted locally as a JSON file on the device using `path_provider`, with timestamps handled via `shared_preferences` and `intl`.

## ✨ Features

- ➕ **Add tasks** with a name
- ▶️ **Run / Stop time tracking** — only one task can run at a time; starting a new one stops the previous
- 🗑️ **Delete tasks**
- 📂 **Expand a task** to view its historical time-tracking sessions
- 💾 **Local JSON persistence** — task/session history stored as `appdata.json` in the app's documents directory
- 🕐 Human-readable elapsed time formatting (hours:minutes:seconds)

## 🏗️ Architecture

```
lib/
├── model/
│   ├── DataToDisk.dart     # Core logic: run/stop tasks, read/write JSON to disk
│   ├── SaveDataModel.dart  # A single tracked time session (date/time + duration)
│   ├── KeyDataModel.dart   # Task summary (name + running state) shown in the list
│   └── TimeDate.dart       # Date/time helpers, elapsed time calculation
└── view/
    ├── main.dart              # App entry point
    ├── DisplayTask.dart       # Task list UI
    ├── AddNewTaskDialog.dart  # Dialog to add a new task
    ├── DeleteTaskDialog.dart  # Dialog to confirm task deletion
    ├── ExpandWork.dart        # Expanded view of a task's session history
    ├── NoTask.dart            # Empty state UI
    └── StyleTextItem.dart     # Shared text styling widget
```

## 🛠️ Tech Stack

- **Flutter / Dart**
- `path_provider` — access to the device's local file system
- `shared_preferences` — lightweight key-value storage (used for tracking the current running task's start time)
- `intl` — date/time formatting

## 🚀 Getting Started

```bash
git clone https://github.com/dev2imp/FlutterTimeSaverApp.git
cd flutter_time_saver
flutter pub get
flutter run
```

## 👤 Author

**Osman Inci**
- GitHub: [@dev2imp](https://github.com/dev2imp)
- LinkedIn: [Osman Inci](https://www.linkedin.com/in/osman-inci-868435221/)
