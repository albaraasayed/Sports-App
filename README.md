# SportsApp

<div align="center">
  <img src="https://github.com/user-attachments/assets/edbb269d-7939-4f5a-ad71-a2a1d1d0d93b" width="130"/>
  <img src="https://github.com/user-attachments/assets/570e3352-1833-466b-8343-55e7ad9454cd" width="130"/>
  <img src="https://github.com/user-attachments/assets/a0f09438-c183-46a7-bac8-554b467cfad5" width="130"/>
  <img src="https://github.com/user-attachments/assets/d84d0319-2de9-43b9-a301-eff8bdddb4dc" width="130"/>
  <img src="https://github.com/user-attachments/assets/33af9f66-d87f-4b3a-a169-3c270a21a598" width="130"/>
  <img src="https://github.com/user-attachments/assets/f2c4acb4-e9cf-4c86-8242-be8ea0a9382c" width="130"/>
</div>

## Overview
**SportsApp** is a comprehensive native iOS application designed to keep sports enthusiasts up to date with their favorite sports, leagues, and teams. Built completely in Swift, it seamlessly interfaces with the AllSportsAPI to provide real-time details on upcoming events, latest match results, and detailed team rosters across a variety of sports including football, basketball, cricket, and tennis. The app is crafted with a focus on robust offline capabilities, a responsive UI, and clean architectural principles to ensure a reliable and engaging user experience.

## Key Features
- **Sports Explorer (Home):** Browse through available sports dynamically retrieved from the backend API.
- **Leagues Directory:** View and instantly filter leagues associated with the selected sport using an intuitive live search feature.
- **League Details Hub:** An advanced dashboard presenting upcoming events, latest match results, and team rosters, leveraging modern compositional layouts.
- **Team & Player Insights:** Dive deep into specific team rosters and individual player statistics (including dedicated tennis player details) with rich graphical representations.
- **Favorites Management:** Star your preferred leagues to build a personalized, offline-capable dashboard. Swipe-to-delete functionality ensures easy management of saved content.
- **Localization & Theming:** Full RTL support for Arabic localization and seamless adaptation to the system's Dark/Light theme preferences.
- **Offline Reachability:** Intelligent network monitoring prevents API-dependent screens from loading when offline, gracefully presenting native alerts while keeping CoreData-backed favorites accessible.

## Tech Stack
- **Language:** Swift 5+
- **UI Framework:** UIKit (Storyboards, XIBs, Auto Layout, UICollectionViewCompositionalLayout)
- **State Management & Architecture:** MVP (Model-View-Presenter) with Protocol-Oriented Programming
- **Networking:** Alamofire (for REST API communication)
- **Data Persistence:** CoreData (SQLite-backed local storage)
- **Image Caching & Loading:** SDWebImage (asynchronous downloading and caching)
- **UI Components:** NVActivityIndicatorView (for polished loading states)
- **External API:** [AllSportsAPI](https://allsportsapi.com/)
- **Dependency Manager:** Swift Package Manager (SPM) (integrated via Xcode project configuration)

## Architecture
The application strictly follows the **MVP (Model-View-Presenter)** architectural pattern. This design ensures a clear separation of concerns, highly testable code, and avoids the "Massive View Controller" anti-pattern.
- **Model:** Represents the data layer. Codable structs are used to parse JSON payloads from the API, while CoreData entities handle local persistence.
- **View:** Consists of ViewControllers and Storyboards/XIBs. Views are completely passive; they focus solely on rendering UI and forwarding user interactions to the Presenter.
- **Presenter:** Contains all the business and presentation logic. It orchestrates data fetching (via Network or Local managers) and prepares data for the View through tightly defined protocols.

## Setup & Installation
Follow these steps to run the project locally on your machine:

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>/Sports-App.git
   cd Sports-App
   ```

2. **Open the Project:**
   Open the `.xcodeproj` file in Xcode:
   ```bash
   open SportsApp.xcodeproj
   ```

3. **Resolve Dependencies:**
   The project uses Swift Package Manager (SPM) embedded within the Xcode project. Once you open Xcode, it will automatically resolve and fetch packages like Alamofire, SDWebImage, and NVActivityIndicatorView.

4. **API Key Setup:**
   Navigate to `SportsApp/Model/Service/APIConfig.swift` in Xcode and insert your personal API key from AllSportsAPI into the required field.

5. **Build and Run:**
   - Select your preferred iOS Simulator (iOS 14.0+ is recommended).
   - Press `Cmd + R` or click the "Play" button in Xcode to build and run the application.

6. **Running Tests:**
   Press `Cmd + U` to execute the comprehensive test suite, which utilizes mocked network layers to validate the Presenter logic without requiring actual internet connectivity.

## Contributors
- Mahmoud Tarek 

