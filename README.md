# chowfinder

## Setup Instructions

1. **Install dependencies:**
   ```sh
   flutter pub get
   ```

2. **Run the app:**
   ```sh
   flutter run --dart-define-from-file=hats.json
   ```

## Design Decisions & Trade-offs

- **Layered Architecture:**  
  The project uses a clean architecture approach, separating data, domain, and presentation layers. Datasource is only responsible for data retrieval from underlying storage repository and network client.
  Repository layer acts as intermediary layer that sits between core business logic and data retrival. Buisness logic is primarily located inside the use cases, this ensures the app's business logic are clearly defined and separated from UI logic and data retrieval, they are also easily testable.

- **Dependency Injection:**  
  The `get_it` package is used for dependency injection, separating dependency creation from usage, making it a lot easier to maintain and write tests.

- **State Management:**  
  Bloc is used for state management, ideally this is where UI logic should be placed in, keeps no business logic which should be in the use cases. 

- **Trade-offs:**  
  The architecture favors scalability and testability over rapid prototyping. Some boilerplate is introduced, but the codebase remains flexible for future features and changes, and most importantly it allows for parallel work within multiple devs and are good for pair-programming and TDD approach.
