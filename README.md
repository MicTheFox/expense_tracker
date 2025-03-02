# expense_tracker

App that tracks personal expenses

## Getting Started

1. [Install flutter](https://docs.flutter.dev/get-started/install)
2. Run build_runner: `dart run build_runner build -d`
3. Start app: `flutter run`

## Architecture

### Routing
The app has two screens, one for adding and expense and one for showing all expenses. Routing is 
established by `go_router`.

### State management
State is managed by `bloc` library. There is one cubit for the history and one for adding an 
expense. The two cubits are connected through the `ExpenseRepository`.

### Storage
Expense data is stored locally with the help of `objectbox` package. To initialize the object 
store a path in the applications document directory is provided (`path_provider` and `path` package 
are needed for looking up the path).
Update and getAll operations are provided over the `ExpenseRepository` which is injected into the 
`ExpenseCubit` and `ExpenseHistoryCubit`.

### Data Models
The `Expense` data model that is stored with `objectbox` is generated with `build_runner` and 
`objectbox_generator` package. This automatically generates the structure for the local storage.

### Testing
- Mocks for Unit and Widget tests are created with `mocktail`.
- Bloc tests are created with `bloc_test`.
- Integration tests are run with plain `integration_test` package.