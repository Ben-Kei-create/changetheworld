# TERRA — Stories of Our World

A narrative puzzle game for macOS where players step into the lives of six people from across the globe, each facing one of humanity's most urgent challenges.

## About

TERRA is a premium, story-driven macOS game built with SwiftUI. Players navigate real-world dilemmas — climate change, ocean pollution, deforestation, inequality, poverty, and human isolation — through the eyes of characters whose stories are grounded in real data and real struggles.

Every choice matters. Every story is connected.

## Characters

| Name | Origin | Challenge |
|------|--------|-----------|
| Amara Diallo | Senegal | Climate Crisis & Solar Energy |
| Mei Lin | China | Ocean Plastic Pollution |
| Carlos Vega | Peru | Amazon Deforestation |
| Fatima Al-Hassan | Jordan | Education & Inequality |
| James Okafor | Nigeria | Urban Poverty & Food Access |
| Hana Nakamura | Japan | Human Isolation & Community |

## Tech Stack

- **Platform:** macOS 14+ (Sonoma)
- **Framework:** SwiftUI
- **Architecture:** MVVM with ObservableObject
- **Distribution:** Mac App Store
- **Price:** $19.99 (premium, no IAP)

## Project Structure

```
TERRA/
├── Sources/TERRA/
│   ├── App/            # App entry point
│   ├── Views/          # All SwiftUI views
│   ├── Models/         # Data models + GameState
│   ├── GameEngine/     # Story content & logic
│   └── Resources/      # Assets, plist
└── Tests/TERRATests/   # Unit tests
```

## Building

Open in Xcode 15+ on macOS 14+:

```bash
open TERRA/Package.swift
```

Or build via CLI:

```bash
cd TERRA && swift build
```

## Team

Built by a team who believes games can change how people see the world.

---

*"The world has many stories. Each one is connected."*
