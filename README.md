<div align="center">

# 🏆 The Sports App (iOS)

**A comprehensive, elegant, and native iOS application for tracking sports, leagues, upcoming events, and team details.**

[![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![iOS](https://img.shields.io/badge/iOS-14.0+-black.svg?style=flat)](https://developer.apple.com/ios/)
[![Architecture](https://img.shields.io/badge/Architecture-MVP-blue.svg?style=flat)](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93presenter)
[![Networking](https://img.shields.io/badge/Networking-Alamofire-red.svg?style=flat)](https://github.com/Alamofire/Alamofire)

</div>

---

## 📖 Overview

**The Sports App** is a native iOS application built completely in Swift. It allows users to explore a vast database of sports, browse leagues around the world, track upcoming and latest match events, and dive deep into individual team rosters. 

This project was built to demonstrate proficiency in iOS development best practices, including **MVP architecture**, programmatic and storyboard-based UI design, robust REST API integration, and local data persistence using **CoreData**.

---

## ✨ Features

### 🏅 1. Sports Explorer (Home Tab)
- Displays all available sports fetched from the API.
- Implemented using a responsive `UICollectionView` with a dynamic `FlowLayout` showing exactly 2 items per row with elegant spacing.
- Tapping a sport navigates seamlessly to its respective leagues.

### ⚽ 2. Leagues Directory
- Presents a visually appealing list of leagues for the selected sport.
- Features custom `UITableViewCells` with perfectly circular league badges.
- Includes a live search bar to filter leagues by name instantly.

### 🏟️ 3. League Details (The Hub)
An advanced screen divided into three distinct sections utilizing Apple's powerful `UICollectionViewCompositionalLayout`:
1. **Upcoming Events (Horizontal Scroll):** Beautiful cards showing event names, dates, times, and competing team badges.
2. **Latest Results (Vertical Scroll):** A detailed list of recent matches showing Home vs. Away teams, final scores, dates, and times.
3. **Teams Roster (Horizontal Scroll):** A carousel of circular team badges.
- Includes a **Favorite Star Button** at the top right to instantly save the league for offline access.

### 👥 4. Team Details
- Displays in-depth details of a selected team.
- Elegant, dynamic UI featuring player stats, positions, and an interactive "Playground" graphic that highlights player positions.

### ⭐️ 5. Favorite Leagues (Favorites Tab)
- Allows users to build a personal dashboard of their favorite leagues.
- Backed entirely by **CoreData** for lightning-fast, offline-capable access.
- Features intelligent swipe-to-delete functionality.
- **Offline Reachability:** Prevents users from navigating to API-dependent details screens if the device is offline, showing a graceful native alert.

---

## 🎁 Bonus Features
We went above and beyond the core requirements to deliver a truly production-ready app:
- 🌗 **Dark Theme Support:** The app seamlessly adapts to the user's system preferences using Semantic Named Colors in the Asset Catalog.
- 🌍 **Localization (English & Arabic):** Full RTL (Right-To-Left) support and localized strings for a global audience.
- 🚀 **Onboarding Screen:** A welcoming first-launch experience utilizing `UserDefaults` to ensure it only shows once.

---

## 🏗️ Architecture & Technologies

### Design Pattern: MVP (Model-View-Presenter)
The project strictly adheres to the MVP architecture to avoid "Massive View Controllers" and ensure high testability.
- **View:** Pure UI logic (Storyboards/XIBs + ViewControllers). Passive and dumb.
- **Presenter:** Handles all business logic, talks to the Network/Database, and updates the View via protocols.
- **Model:** Codable structs representing the JSON payload.

### Tech Stack
- **Language:** Swift 5+
- **UI Framework:** UIKit (Storyboards, XIBs, Auto Layout, Compositional Layout)
- **Networking:** [Alamofire](https://github.com/Alamofire/Alamofire) (Escaping Closures, DispatchGroups for parallel requests)
- **Persistence:** CoreData (SQLite backed)
- **Image Caching:** [SDWebImage](https://github.com/SDWebImage/SDWebImage) for asynchronous image downloading and caching.
- **Reachability:** Native `NWPathMonitor` for reliable internet connectivity checks.
- **Testing:** XCTest (100% Mocked Network layers using dependency injection).

### Data Source
- Powered by the [AllSportsAPI](https://allsportsapi.com/).

---

## 📂 Folder Structure

```text
SportsApp/
├── App/                  # AppDelegate, SceneDelegate, Base/ar.lproj
├── Model/
│   ├── Entities/         # Codable Models (League, Team, Fixture, etc.)
│   ├── Service/          # NetworkManager, APIConfig, Protocols
│   └── Local/            # CoreDataManager, UserDefaultsManager, .xcdatamodeld
├── Modules/              # MVP Feature Modules
│   ├── Start/            # Onboarding
│   ├── Home/             # Sports Tab
│   ├── Leagues/          # Leagues List
│   ├── LeagueDetails/    # 3-Section Compositional Layout
│   ├── TeamDetails/      # Roster & Playground UI
│   └── Favorite/         # CoreData Favorites Tab
├── Utils/                # Reachability, Colors, Alerts, Extensions
└── SportsAppTests/       # XCTestCase files, MockNetworkManager, MockViews
```

---

## 🧪 Unit Testing

We take reliability seriously. The app includes a comprehensive test suite targeting the **Presenter** layer. 
- Custom `MockNetworkManager` conforming to `NetworkManagerProtocol` to simulate API success/failure instantly without real internet.
- Used `XCTestExpectation` to handle asynchronous logic gracefully.
- ARRANGE, ACT, ASSERT pattern strictly followed.

---

## 🛠️ Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/Sports-App.git
   ```
2. **Install Dependencies:**
   - If using CocoaPods: Run `pod install` in the root directory and open the `.xcworkspace`.
   - If using Swift Package Manager (SPM): Open the `.xcodeproj` and Xcode will resolve dependencies automatically.
3. **API Key Setup:**
   - Open `APIConfig.swift` and insert your personal API key from AllSportsAPI.
4. **Build & Run:**
   - Select your preferred simulator (iOS 14.0+) and press `Cmd + R`.

---

## 📱 Screenshots

<p align="center">
   <img src="https://github.com/user-attachments/assets/edbb269d-7939-4f5a-ad71-a2a1d1d0d93b" alt="Home Screen" width="200"/>
  &nbsp;&nbsp;&nbsp;
  <img width="200"  alt="image" src="https://github.com/user-attachments/assets/570e3352-1833-466b-8343-55e7ad9454cd" />
  &nbsp;&nbsp;&nbsp;
  <img width="200" alt="image" src="https://github.com/user-attachments/assets/a0f09438-c183-46a7-bac8-554b467cfad5" />
   &nbsp;&nbsp;&nbsp;
   <img width="200" alt="image" src="https://github.com/user-attachments/assets/d84d0319-2de9-43b9-a301-eff8bdddb4dc" />
   &nbsp;&nbsp;&nbsp;
<img width="200" alt="image" src="https://github.com/user-attachments/assets/33af9f66-d87f-4b3a-a169-3c270a21a598" />
   &nbsp;&nbsp;&nbsp;
   <img width="200"  alt="image" src="https://github.com/user-attachments/assets/f2c4acb4-e9cf-4c86-8242-be8ea0a9382c" />

</p>

*(Note: Replace placeholder images with actual app screenshots before publishing)*

---

## 👨‍💻 Author

Developed with Albaraa Alsayed and Mahmoud Tarek. 
Feel free to reach out for feedback or collaboration!

---
*If you like this project, please consider giving it a ⭐!*
