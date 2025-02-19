# Bako

Bako is an iOS application built using The Composable Architecture (TCA), serving as a learning project to understand and implement TCA principles.

## About Bako

Bako is an emotion tracker app that helps users identify, categorize, and log their emotions.

## Technology Stack

- **Framework**: SwiftUI
- **Architecture**: The Composable Architecture (TCA)
- **Platform**: iOS
- **Language**: Swift
- **Data Persistence**: SwiftData
- **Dependency Management**: Swift Package Manager

## Project Structure

The project follows a structure organized around The Composable Architecture (TCA), divided into several main groups:

```
Bako/
├── App/                     # Core application files
│   ├── BakoApp.swift        # App entry point
│   ├── AppReducer.swift     # Root reducer
│   ├── AppView.swift        # Root view
│   ├── AppDependencies.swift# Dependency management
│   ├── AppModels.swift      # SwiftData models
│   ├── AppStore.swift       # Global store
│   └── AppRoute.swift       # Navigation routes
├── Features/                # Feature modules
│   ├── About/               # About feature
│   ├── DetailFeeling/       # Emotion detail view
│   ├── FormFeeling/         # Emotion form
│   ├── Home/                # Home screen
│   ├── Onboarding/          # Onboarding flow
│   ├── SelectCategoryFeeling/# Emotion category selection
│   ├── SelectFeeling/       # Specific emotion selection
│   ├── SuccessSubmitFeeling/ # Success screen after submission
│   └── Tracker/             # Emotion tracker
├── Core/                    # Shared resources
│   ├── Common/              # Shared components and utilities
│   │   ├── Components/      # Reusable UI components
│   │   ├── Enums/           # Shared enums
│   │   ├── Extensions/      # Swift extensions
│   │   └── Models/          # Data models
│   ├── Constants/           # Constants and mock data
│   └── Design/              # Design assets
│       ├── Assets/          # Asset catalogs
│       └── Fonts/           # Custom fonts
└── Preview Content/         # Preview assets
```

## The Composable Architecture

Through building Bako, I learned several key aspects of The Composable Architecture (TCA):

- **TCA Basics**: 
  - **State**: I discovered how TCA uses a single source of truth for the application's state, which is represented as a struct. This approach simplifies state management by ensuring that all state changes are predictable and traceable.
  - **Actions**: Actions in TCA are enums that represent all possible events that can affect the state. I learned to define actions for user interactions, system events, and more, which helped in clearly understanding what can change the state.
  - **Reducers**: Reducers are pure functions that take the current state and an action, and return a new state. This pattern taught me how to handle state transitions in a clear way, making the app's behavior more predictable.

- **Routing**: Implementing routing in TCA allowed me to manage navigation in a more modular way, enhancing the user experience by ensuring smooth transitions between different parts of the app.

- **Dependency Management**: TCA's explicit dependency management taught me how to inject dependencies in a controlled manner, making the app more flexible.

TCA provides several key benefits:

- **State Management**: Clear and predictable state mutations
- **Dependency Management**: Explicit dependencies
- **Side Effect Handling**: Controlled side effects
- **Composition**: Easy composition of features

## Getting Started

1. Clone the repository
2. Install dependencies
3. Open the Xcode project
4. Build and run

## Requirements

- iOS 17.0+
- Xcode 16.0+
- Swift 5+

## Contributors

- **Developer**: Muhammad Rezky Sulihin ([LinkedIn](https://www.linkedin.com/in/mrezkys/))
- **Designer**: Amanda Tri Utami Permatasari ([LinkedIn](https://www.linkedin.com/in/amandatriutamipermatasari/))