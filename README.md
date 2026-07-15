
# ReadItLater

A SwiftUI iOS application built for the Philonet Reading Timer Assignment.

## Features

- Save articles from Safari using Share Extension
- Read articles inside the app using WKWebView
- Reading timer
- Pause timer when app backgrounds
- Resume timer when app returns
- Persistent storage using JSON
- Memory + Disk merge engine
- Debug panel showing merge decisions

## Tech Stack

- Swift
- SwiftUI
- WKWebView
- App Groups
- Share Extension
- Observation Framework

## Architecture

- Repository Pattern
- MemoryStore
- DiskStore
- MergeEngine

## Merge Logic

- Prevents reading time from moving backwards.
- Merges unique reading sessions.
- Uses latest metadata when conflicts occur.
- Displays merge reason in the debug panel.

## Project Structure

ReadItLater/
├── App/
├── Models/
├── Services/
├── Persistence/
├── Shared/
├── ViewModels/
├── Views/
└── ReadItLaterShare/
