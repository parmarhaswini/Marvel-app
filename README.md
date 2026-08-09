# Marvel iOS Master-Detail Application

## 1. Overview

This project is an iOS application built with **SwiftUI** and designed using **MVVM + Clean Architecture**.

The application implements a **Master-Detail** experience where users can browse a list of Marvel characters and view character details.

### Key Requirements

- SwiftUI for all UI development — **UIKit should not be used**.
- MVVM + Clean Architecture.
- Each architectural layer should be maintained as a separate framework/module.
- Appropriate Swift access control (`private`, `fileprivate`, `internal`, `public`, `open`) should be applied.
- Dependency Injection (DI) wherever appropriate.
- **Alamofire** for network communication.
- Local database/storage for offline persistence.
- English and Spanish localization.
- Accessibility support.
- Swift Package Manager (SPM) or CocoaPods for dependency management.
- Unit tests for business logic and important application components.
- Responsive UI across supported iPhone/iPad configurations.
- Component-based UI architecture for reusability and scalability.
- No hardcoded production data; dummy models should be used initially for UI development.

---

## 2. Architecture

The application should follow **MVVM + Clean Architecture** with separate frameworks/modules.

### Suggested Module Structure

```text
MarvelApp
│
├── App
│   └── MarvelAppApp.swift
│
├── Presentation
│   ├── Master
│   │   ├── CharacterListView.swift
│   │   └── CharacterListViewModel.swift
│   ├── Detail
│   │   ├── CharacterDetailView.swift
│   │   └── CharacterDetailViewModel.swift
│   └── Components
│       ├── CharacterRowView.swift
│       ├── LoadingView.swift
│       ├── ErrorView.swift
│       └── AsyncImageView.swift
│
├── Domain
│   ├── Entities
│   │   └── Character.swift
│   ├── Repositories
│   │   └── CharacterRepository.swift
│   └── UseCases
│       ├── FetchCharactersUseCase.swift
│       └── FetchCharacterDetailUseCase.swift
│
├── Data
│   ├── Network
│   │   ├── APIClient.swift
│   │   └── CharacterRemoteDataSource.swift
│   ├── Local
│   │   ├── CharacterLocalDataSource.swift
│   │   └── DatabaseManager.swift
│   ├── Models
│   │   └── CharacterDTO.swift
│   └── Repositories
│       └── CharacterRepositoryImpl.swift
│
├── Core
│   ├── DI
│   ├── Networking
│   ├── Localization
│   ├── Accessibility
│   └── Utilities
│
└── Tests
    ├── DomainTests
    ├── DataTests
    └── PresentationTests
```

### Framework Separation

A recommended framework/module separation is:

```text
MarvelApp
    │
    ├── PresentationFramework
    │
    ├── DomainFramework
    │
    ├── DataFramework
    │
    └── CoreFramework
```

The dependency direction should remain:

```text
Presentation
      ↓
   Domain
      ↑
    Data
      ↓
     Core
```

The **Domain layer should remain independent of UI and external frameworks** wherever possible.

---

## 3. Master-Detail Flow

### Master Screen

The Master screen displays the list of Marvel characters.

Responsibilities:

- Fetch character data.
- Display loading state.
- Display error state.
- Display empty state.
- Support accessibility.
- Navigate to the Detail screen.
- Support responsive layouts.

Example flow:

```text
CharacterListView
        ↓
CharacterListViewModel
        ↓
FetchCharactersUseCase
        ↓
CharacterRepository
        ↓
Remote / Local Data Source
```

### Detail Screen

The Detail screen displays information for the selected character.

Responsibilities:

- Display character name.
- Display character image.
- Display description.
- Display relevant metadata returned by the API.
- Handle missing/empty API fields gracefully.
- Support accessibility and Dynamic Type.

---

## 4. API Integration

The primary API requirement is the Marvel API.

### Marvel API

Documentation:

https://developer.marvel.com/docs#!/public/getCreatorCollection_get_0

Required endpoint:

```text
GET /v1/public/characters
```

The endpoint is expected to provide the character collection used to populate the Master screen and the selected character data used by the Detail screen.

### Authentication

Marvel API access requires registration and API credentials.

Credentials should **not be committed to source control**.

Recommended approach:

```text
Config.xcconfig
        ↓
Environment / Build Configuration
        ↓
API Configuration
        ↓
Network Client
```

Example configuration:

```text
MARVEL_PUBLIC_KEY = <your-public-key>
MARVEL_PRIVATE_KEY = <your-private-key>
```

For production, secrets should be managed through an appropriate secure CI/CD secret-management mechanism.

### Request Authentication

Marvel's API authentication requires the appropriate request parameters/signature according to the current Marvel API documentation.

The implementation should encapsulate this logic inside the networking/data layer rather than exposing authentication details to ViewModels or Views.

---

## 5. Networking

**Alamofire** should be used for API communication.

Suggested abstraction:

```swift
protocol APIClient {
    func request<T: Decodable>(
        _ endpoint: Endpoint
    ) async throws -> T
}
```

The concrete implementation can use Alamofire:

```swift
final class AlamofireAPIClient: APIClient {
    // Alamofire implementation
}
```

This abstraction makes networking testable and prevents the Domain layer from depending directly on Alamofire.

---

## 6. Dependency Injection

Dependencies should be injected rather than instantiated directly inside ViewModels.

Example:

```swift
final class CharacterListViewModel: ObservableObject {
    private let fetchCharactersUseCase: FetchCharactersUseCase

    init(fetchCharactersUseCase: FetchCharactersUseCase) {
        self.fetchCharactersUseCase = fetchCharactersUseCase
    }
}
```

A composition root can construct the dependency graph:

```text
App
 ↓
DependencyContainer
 ↓
Repository
 ↓
Use Case
 ↓
ViewModel
 ↓
View
```

This approach improves:

- Testability
- Maintainability
- Separation of concerns
- Mocking
- Scalability

---

## 7. Local Database / Persistence

The application should provide local persistence for character data.

The implementation should use an Apple-provided persistence solution and avoid introducing unnecessary third-party database libraries.

Possible approach:

```text
API
 ↓
Repository
 ↓
Local Persistence
 ↓
ViewModel
 ↓
SwiftUI View
```

Recommended behavior:

1. Check local storage when appropriate.
2. Request fresh data from the API.
3. Persist successful API responses.
4. Display cached data when network access is unavailable.
5. Update local storage when fresh data is received.

The repository should hide persistence implementation details from the Domain layer.

---

## 8. Localization

The application supports:

- English (`en`)
- Spanish (`es`)

User-facing strings should not be hardcoded inside SwiftUI views.

Example:

```swift
Text("characters_title")
```

Localization resources:

```text
Localizable.xcstrings
```

Suggested localized content:

```text
characters_title
character_details
loading
retry
error_message
no_characters
```

The application should use Apple's localization mechanisms and support language changes without requiring business-logic changes.

---

## 9. Accessibility

Accessibility is a first-class requirement.

The application should support:

- VoiceOver.
- Dynamic Type.
- Accessibility labels.
- Accessibility hints where useful.
- Sufficient touch target sizes.
- Semantic grouping.
- Meaningful navigation order.
- Avoiding information conveyed by color alone.
- Scalable text and layouts.

Example:

```swift
Image(character.name)
    .accessibilityLabel(character.name)
```

For decorative images:

```swift
Image("decorative_image")
    .accessibilityHidden(true)
```

SwiftUI accessibility APIs should be preferred instead of adding UIKit-based accessibility implementations.

---

## 10. Responsive UI

The UI should adapt to different device sizes and orientations.

Avoid:

- Fixed screen dimensions.
- Hardcoded positions.
- Device-specific layout assumptions.

Prefer:

- `VStack`
- `HStack`
- `LazyVStack`
- `LazyVGrid`
- `GeometryReader` where genuinely required.
- Adaptive frames.
- Dynamic Type.
- `ViewThatFits` where useful.
- Size classes when appropriate.

The layout should work across supported iPhone and iPad configurations.

---

## 11. Component-Based UI

Reusable SwiftUI components should be created for common UI elements.

Suggested components:

```text
CharacterRowView
CharacterImageView
LoadingView
ErrorView
EmptyStateView
PrimaryButton
SearchBar
SectionHeader
```

Components should have focused responsibilities and avoid containing business logic.

Example:

```swift
struct CharacterRowView: View {
    let character: Character

    var body: some View {
        // Reusable presentation component
    }
}
```

---

## 12. Dummy Data / UI-First Development

Before integrating the API, the UI should be developed using dummy models.

Example:

```swift
extension Character {
    static let mock = Character(
        id: 1,
        name: "Spider-Man",
        description: "Friendly neighborhood superhero"
    )
}
```

This allows the Master and Detail screens to be developed and tested independently from network availability.

The mock data should be isolated from production data sources.

---

## 13. Error Handling

The application should provide clear handling for:

- Network failures.
- Invalid responses.
- HTTP errors.
- Empty API responses.
- Decoding failures.
- Missing images.
- Local database failures.

A Domain-level error model can prevent UI code from depending directly on networking-library-specific errors.

Example:

```swift
enum AppError: Error {
    case network
    case decoding
    case unauthorized
    case server
    case emptyData
    case persistence
    case unknown
}
```

The UI should present user-friendly messages rather than raw technical errors.

---

## 14. Access Control

Swift access control should be used appropriately.

Examples:

```swift
public protocol CharacterRepository {
    func fetchCharacters() async throws -> [Character]
}
```

```swift
final class CharacterRepositoryImpl: CharacterRepository {
    private let remoteDataSource: CharacterRemoteDataSource

    init(remoteDataSource: CharacterRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
}
```

Internal implementation details should remain `internal` or `private` whenever possible.

The public API of each framework should be intentionally small.

---

## 15. Dependency Management

Use **Swift Package Manager (SPM)** or CocoaPods.

The preferred approach is SPM unless the project environment requires CocoaPods.

Required third-party dependency:

```text
Alamofire
```

No other third-party libraries should be introduced unless explicitly approved.

---

## 16. Unit Testing

Unit tests should cover the most important business and data behavior.

### Recommended Test Coverage

#### ViewModel

- Successful character loading.
- Loading state.
- Error state.
- Empty response.
- Retry behavior.

#### Use Cases

- Successful execution.
- Repository failure propagation.
- Correct repository interaction.

#### Repository

- Remote data success.
- Local cache behavior.
- Persistence failure handling.

#### Networking

- Successful decoding.
- HTTP error mapping.
- Invalid response handling.

### Mock Example

```swift
final class MockCharacterRepository: CharacterRepository {
    var characters: [Character] = []
    var error: Error?

    func fetchCharacters() async throws -> [Character] {
        if let error {
            throw error
        }

        return characters
    }
}
```

Tests should avoid real API calls and should use mocks/stubs for deterministic execution.

---

## 17. Suggested Project Flow

```text
                ┌──────────────────┐
                │   SwiftUI View   │
                └────────┬─────────┘
                         │
                         ▼
                ┌──────────────────┐
                │    ViewModel     │
                └────────┬─────────┘
                         │
                         ▼
                ┌──────────────────┐
                │     Use Case     │
                └────────┬─────────┘
                         │
                         ▼
                ┌──────────────────┐
                │   Repository     │
                └───────┬───┬──────┘
                        │   │
             ┌──────────┘   └──────────┐
             ▼                         ▼
      ┌──────────────┐          ┌──────────────┐
      │ Remote Data  │          │ Local Data   │
      │ Source       │          │ Source       │
      └──────┬───────┘          └──────┬───────┘
             │                         │
             ▼                         ▼
        Marvel API                Local DB
```

---

## 18. Security Considerations

API keys and credentials must not be committed to Git.

Do not place secrets directly in:

- Swift source files.
- `Info.plist` committed to the repository.
- README files.
- Git history.
- Public repositories.

Use build configuration files and/or CI/CD secret management.

If a credential has already been exposed publicly, it should be rotated before production use.

---

## 19. Important API Documentation Note

The requirement document contains both **Marvel API** and **TMDB API** information.

The primary application requirement explicitly specifies the Marvel API:

```text
GET /v1/public/characters
```

The TMDB section appears to be legacy/reference information and should **not** be used for the Marvel character implementation unless the project owner explicitly changes the requirement.

The TMDB credentials/API key have intentionally not been copied into this README.

---

## 20. Figma / Design References

### Figma Files

Design files are available through the provided Google Drive folder:

https://drive.google.com/drive/folders/1PEn_oEhPR-M_Gfb3amMJKhFH5L3HUs0r?usp=drive_link

The implementation should follow the approved Figma design while maintaining responsive and accessible SwiftUI layouts.

### Marvel App Sheet

Project/reference sheet:

https://docs.google.com/spreadsheets/d/1BQxzCcuQNSne4yDKpcZ3VcdyUhzA4XFskatOg_7XOe8/edit?gid=0#gid=0

---

## 21. API Reference

Marvel API documentation:

https://developer.marvel.com/docs#!/public/getCreatorCollection_get_0

Before implementation, verify the current Marvel API authentication, request signing, rate limits, response schema, and available image URLs against the official documentation.

---

## 22. Definition of Done

The application can be considered complete when:

- [ ] SwiftUI is used for all screens.
- [ ] UIKit is not used.
- [ ] MVVM is implemented.
- [ ] Clean Architecture boundaries are established.
- [ ] Layers are separated into frameworks/modules.
- [ ] Dependency Injection is implemented.
- [ ] Alamofire is used for network requests.
- [ ] Marvel character API is integrated.
- [ ] Local persistence is implemented.
- [ ] English localization is complete.
- [ ] Spanish localization is complete.
- [ ] Accessibility requirements are implemented.
- [ ] Master screen is implemented.
- [ ] Detail screen is implemented.
- [ ] UI is responsive across supported devices.
- [ ] Reusable SwiftUI components are created.
- [ ] Dummy/mock data is available for UI development and testing.
- [ ] Error and loading states are handled.
- [ ] Unit tests are implemented.
- [ ] API credentials are kept out of source control.
- [ ] Project builds successfully using the selected dependency manager.

---

## 23. Recommended Implementation Order

1. Create the Xcode workspace/project.
2. Create separate frameworks/modules for Core, Domain, Data, and Presentation.
3. Define Domain entities and repository protocols.
4. Define use cases.
5. Build the dependency container.
6. Build SwiftUI Master and Detail screens using dummy data.
7. Create reusable UI components.
8. Add localization.
9. Add accessibility.
10. Add local persistence.
11. Add Alamofire networking.
12. Integrate the Marvel API.
13. Connect remote and local data through the repository.
14. Add ViewModel state/error/loading handling.
15. Add unit tests.
16. Validate responsive layouts and accessibility.
17. Configure build environments and secure API credentials.
18. Perform final code review and cleanup.

---

## 24. Technology Stack

| Area | Technology |
|---|---|
| Language | Swift |
| UI | SwiftUI |
| Architecture | MVVM + Clean Architecture |
| Networking | Alamofire |
| Persistence | Apple-native local persistence |
| Dependency Injection | Custom DI / Composition Root |
| Localization | English + Spanish |
| Accessibility | SwiftUI Accessibility APIs |
| Dependency Management | Swift Package Manager / CocoaPods |
| Testing | XCTest |
| API | Marvel Public API |

---

## 25. Security Notice

**Never use the credentials shown in the original requirement document directly in the application source code or README.** Configure API credentials securely and rotate any credentials that have been exposed.
