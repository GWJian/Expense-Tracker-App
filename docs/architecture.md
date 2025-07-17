# Architecture Guidelines

This document outlines the project architecture and patterns for the Expense Tracker Flutter application.

## Project Architecture

The project follows a clean architecture pattern with clear separation of concerns:

```
lib/
├── app.dart                     # App configuration and initialization
├── app_view.dart                # Main app UI structure
├── main.dart                    # Entry point
├── docs/                        # Documentation files
│   └── expenses_tracker_userstory.md
│
├── backends/                    # Backend related code
│   ├── user_repository/         # User authentication data management
│   ├── transaction_repository/  # Transaction data management
│   ├── category_repository/     # Category data management
│   └── budget_repository/       # Budget data management
│       └── lib/
│           ├── *_repository.dart    # Public API barrel file
│           └── src/
│               ├── entities/           # Business entities
│               ├── models/             # Data models
│               ├── repository/          # Repository interface
│               └── supabase_*_repo.dart  # Implementation
│
├── bloc/                        # Global BLoCs
│   ├── auth/                    # Authentication related logic
│   ├── transaction/             # Transaction management
│   ├── category/                # Category management
│   └── budget/                  # Budget management
│       ├── *_bloc.dart
│       ├── *_event.dart
│       └── *_state.dart
│
├── components/                  # Reusable UI components
│   ├── buttons/                 # Button components
│   ├── cards/                   # Card components (transaction cards, summary cards)
│   ├── forms/                   # Form components (transaction forms, category forms)
│   ├── charts/                  # Chart components for spending analysis
│   └── navigation/              # Navigation components
│
├── core/                       # Core functionality
│   ├── config/                 # App configuration
│   ├── network/                # Network related code
│   ├── storage/                # Local storage
│   ├── supabase/               # Supabase client setup
│   └── utils/                  # Utility functions (date formatting, currency)
│
└── screens/                    # Application screens (feature modules)
    ├── auth/                   # Authentication feature module
    │   ├── bloc/               # Auth-specific BLoCs
    │   ├── views/              # Login/logout screens
    │   └── widgets/            # Auth-specific widgets
    │
    ├── transactions/           # Transaction feature module
    │   ├── bloc/               # Transaction-specific BLoCs
    │   ├── views/              # Transaction list, add/edit screens
    │   └── widgets/            # Transaction-specific widgets
    │
    ├── categories/             # Category feature module
    │   ├── bloc/               # Category-specific BLoCs
    │   ├── views/              # Category management screens
    │   └── widgets/            # Category-specific widgets
    │
    ├── budgets/                # Budget feature module
    │   ├── bloc/               # Budget-specific BLoCs
    │   ├── views/              # Budget management screens
    │   └── widgets/            # Budget-specific widgets
    │
    └── analytics/              # Analytics feature module
        ├── bloc/               # Analytics-specific BLoCs
        ├── views/              # Reports and charts screens
        └── widgets/            # Analytics-specific widgets
```

## Data Models and State Management

### Model Class Best Practices
- Place in separate files under appropriate repository
- Use `@immutable` annotation
- Make all fields final
- Add class-level documentation
- Document all public methods
- Implement `toJson`/`fromJson` for persistence
- Use const constructors
- Follow consistent field order
- Add parameter validation where needed

### JSONB Fields and Model Design Principles

When working with JSONB fields in models, follow these critical patterns to maintain consistency and separation of concerns:

#### Consistency Rule: All JSONB Fields Must Follow Same Pattern
```dart
// ✅ Correct: All JSONB fields use simple existence check
bool get hasCostData => costSettings.isNotEmpty;
bool get hasPlanningData => planningParams.isNotEmpty;
bool get hasTaskDetails => taskDetails.isNotEmpty;

// ❌ Wrong: Mixing concerns - don't parse complex objects at model level
bool get hasTaskDetails => taskActions.isNotEmpty;  // Depends on parsing
List<TaskAction> get taskActions { /* complex parsing */ }  // UI concern
```

#### Separation of Concerns
- **Model Layer**: Handle raw JSONB data (`Map<String, dynamic>`) and simple value extraction
- **UI Layer**: Handle complex object parsing and creation (`TaskAction.fromJson()`)
- **Repository Layer**: Handle database mapping and transformation

#### Correct Model-Level JSONB Access
```dart
// ✅ Good: Simple primitive value extraction when needed
double get estimatedCost {
  final costFromSettings = costSettings[CropJsonFields.totalEstimatedCost];
  if (costFromSettings is num) {
    return costFromSettings.toDouble();
  }
  return CropDefaults.defaultCostAmount;
}

// ✅ Good: Direct count access without object creation
int get taskActionsCount {
  final actions = taskDetails['task_actions'] as List<dynamic>?;
  return actions?.length ?? 0;
}
```

#### UI Layer Handles Complex Parsing
```dart
// ✅ Good: UI components parse objects when needed
List<TaskAction> _getTaskActions(CropTemplate template) {
  final actions = template.taskDetails['task_actions'] as List<dynamic>?;
  if (actions == null) return [];
  
  return actions
      .map((action) => TaskAction.fromJson(action as Map<String, dynamic>))
      .toList();
}
```

#### Performance Considerations
- **Avoid expensive operations in getters**: No JSON parsing or object creation
- **Parse only when needed**: Let UI components handle parsing when displaying data
- **Count vs Parse**: For counts, access raw data directly rather than creating objects first

### Example Model Class
```dart
/// A model representing a financial transaction in the system
@immutable
class Transaction {
  /// Unique identifier of the transaction
  final String id;
  
  /// Title or description of the transaction
  final String title;
  
  /// Amount of the transaction (positive for income, negative for expense)
  final double amount;
  
  /// Category of the transaction
  final String categoryId;
  
  /// Type of transaction (income or expense)
  final TransactionType type;
  
  /// Date when the transaction occurred
  final DateTime date;
  
  /// Date when the transaction was created
  final DateTime createdAt;
  
  /// Optional notes for the transaction
  final String? notes;
  
  /// Creates a transaction with the provided information
  const Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.categoryId,
    required this.type,
    required this.date,
    required this.createdAt,
    this.notes,
  });
  
  /// Creates a Transaction from JSON data
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      categoryId: json['category_id'] as String,
      type: TransactionType.fromString(json['type'] as String),
      date: DateTime.parse(json['date'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      notes: json['notes'] as String?,
    );
  }
  
  /// Converts the Transaction to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category_id': categoryId,
      'type': type.toString(),
      'date': date.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'notes': notes,
    };
  }
  
  /// Creates a copy of this Transaction with the given fields replaced with the new values
  Transaction copyWith({
    String? id,
    String? title,
    double? amount,
    String? categoryId,
    TransactionType? type,
    DateTime? date,
    DateTime? createdAt,
    String? notes,
  }) {
    return Transaction(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      type: type ?? this.type,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      notes: notes ?? this.notes,
    );
  }
}
```

### Example BLoC Structure

```dart
// Event
abstract class TransactionEvent {}

class LoadTransactions extends TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final Transaction transaction;
  AddTransaction(this.transaction);
}

class UpdateTransaction extends TransactionEvent {
  final Transaction transaction;
  UpdateTransaction(this.transaction);
}

class DeleteTransaction extends TransactionEvent {
  final String transactionId;
  DeleteTransaction(this.transactionId);
}

// State
abstract class TransactionState {}

class TransactionsInitial extends TransactionState {}

class TransactionsLoading extends TransactionState {}

class TransactionsLoaded extends TransactionState {
  final List<Transaction> transactions;
  TransactionsLoaded(this.transactions);
}

class TransactionsError extends TransactionState {
  final String message;
  TransactionsError(this.message);
}

// BLoC
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository transactionRepository;
  
  TransactionBloc({required this.transactionRepository}) : super(TransactionsInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<AddTransaction>(_onAddTransaction);
    on<UpdateTransaction>(_onUpdateTransaction);
    on<DeleteTransaction>(_onDeleteTransaction);
  }
  
  Future<void> _onLoadTransactions(LoadTransactions event, Emitter<TransactionState> emit) async {
    emit(TransactionsLoading());
    try {
      final transactions = await transactionRepository.getTransactions();
      emit(TransactionsLoaded(transactions));
    } catch (e) {
      emit(TransactionsError('Failed to load transactions: ${e.toString()}'));
    }
  }
  
  Future<void> _onAddTransaction(AddTransaction event, Emitter<TransactionState> emit) async {
    final currentState = state;
    if (currentState is TransactionsLoaded) {
      emit(TransactionsLoading());
      try {
        await transactionRepository.addTransaction(event.transaction);
        final updatedTransactions = await transactionRepository.getTransactions();
        emit(TransactionsLoaded(updatedTransactions));
      } catch (e) {
        emit(TransactionsError('Failed to add transaction: ${e.toString()}'));
      }
    }
  }
  
  Future<void> _onUpdateTransaction(UpdateTransaction event, Emitter<TransactionState> emit) async {
    final currentState = state;
    if (currentState is TransactionsLoaded) {
      emit(TransactionsLoading());
      try {
        await transactionRepository.updateTransaction(event.transaction);
        final updatedTransactions = await transactionRepository.getTransactions();
        emit(TransactionsLoaded(updatedTransactions));
      } catch (e) {
        emit(TransactionsError('Failed to update transaction: ${e.toString()}'));
      }
    }
  }
  
  Future<void> _onDeleteTransaction(DeleteTransaction event, Emitter<TransactionState> emit) async {
    final currentState = state;
    if (currentState is TransactionsLoaded) {
      emit(TransactionsLoading());
      try {
        await transactionRepository.deleteTransaction(event.transactionId);
        final updatedTransactions = await transactionRepository.getTransactions();
        emit(TransactionsLoaded(updatedTransactions));
      } catch (e) {
        emit(TransactionsError('Failed to delete transaction: ${e.toString()}'));
      }
    }
  }
}
```

### BLoC Pattern
- Each feature gets its own Bloc
- Events should be in present tense (e.g., `LoadTransactions`, `UpdateTransaction`)
- States should be nouns with status (e.g., `TransactionsState`, `TransactionsLoadingState`)
- Keep BLoC logic focused and testable

## Error Handling and Asynchronous Operations

### Error Handling
- Check mounted state before setState
- Extract error handling logic to separate methods
- Use meaningful error messages
- Handle all possible error cases
- Add error recovery options where possible
- Use consistent error dialog/snackbar style

### Example Error Handling
```dart
/// ============================= Error Handling =============================
void _handleError(dynamic error) {
  if (!mounted) return;
  
  String errorMessage = 'An unexpected error occurred';
  
  if (error is NetworkException) {
    errorMessage = 'Network error: Please check your connection';
  } else if (error is AuthException) {
    errorMessage = 'Authentication error: ${error.message}';
  }
  
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(errorMessage)),
  );
}
```

### Asynchronous Operations
- Use async/await consistently
- Handle loading states properly
- Check mounted state after async operations
- Extract async logic to separate methods
- Show appropriate loading indicators

### State Management After Async Operations

Always verify the widget is still mounted after asynchronous operations:

```dart
Future<void> _performAsyncOperation() async {
  try {
    // Start operation
    final result = await someAsyncFunction();
    
    // Check if widget is still in the tree
    if (!mounted) return;
    
    // Update UI with result
    setState(() {
      _data = result;
    });
  } catch (e) {
    // Check if widget is still in the tree
    if (!mounted) return;
    
    // Handle error
    _handleError(e);
  }
}
```

### Example Asynchronous Operation
```dart
/// ============================= Data Methods =============================
Future<void> _loadData() async {
  try {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    
    final result = await _repository.fetchData();
    
    if (!mounted) return;
    
    setState(() {
      _data = result;
      _isLoading = false;
    });
  } catch (e) {
    if (!mounted) return;
    
    setState(() {
      _error = e;
      _isLoading = false;
    });
    
    _handleError(e);
  }
}
```

## Documentation Standards

### Documentation Style
- Use `///` for documentation comments
- Add class-level documentation for all public classes
- Document all public methods and properties
- Use section comments to improve code readability
- Keep comments focused and relevant
- Update comments when code changes
- Remove redundant/obvious comments

### Class Documentation

```dart
/// A widget that displays a task card with detailed information.
///
/// This card shows the task title, description, status, and due date.
/// It supports tap interactions for navigation to task details.
class TaskCard extends StatelessWidget {
  // Implementation...
}
```

### Method Documentation

```dart
/// Fetches tasks from the repository based on the provided filter.
///
/// [filter] The filter to apply to the task list.
/// [sortBy] Optional parameter to specify sorting criteria.
///
/// Returns a Future that completes with a list of tasks matching the filter.
/// Throws a [RepositoryException] if the data cannot be retrieved.
Future<List<Task>> getTasks(TaskFilter filter, {TaskSort? sortBy}) async {
  // Implementation...
}
```

### Property Documentation

```dart
/// The current status of the task.
///
/// This property is used to determine the visual representation
/// and available actions for a task.
final TaskStatus status;
```

### Complex Logic Documentation

For complex logic, add detailed explanations:

```dart
/// Calculates the optimal distribution of tasks among workers.
///
/// The algorithm works as follows:
/// 1. Sort workers by availability and skill level
/// 2. Sort tasks by priority and deadline
/// 3. Assign tasks to workers based on:
///    - Worker skill matching task requirements
///    - Worker current workload
///    - Task deadline constraints
///
/// This balances workload while ensuring tasks are completed on time
/// by workers with appropriate skills.
void _assignTasksToWorkers() {
  // Implementation...
}
```

### Parameter Documentation

Document parameters using the `[paramName]` format:

```dart
/// Creates a new user profile.
///
/// [username] The unique username for the user.
/// [email] The email address for the user. Must be a valid email format.
/// [role] The role assigned to the user. Defaults to [UserRole.standard].
///
/// Returns a [User] object if successful.
/// Throws [ValidationException] if username or email is invalid.
User createUser(String username, String email, {UserRole role = UserRole.standard}) {
  // Implementation...
}
```

### Return Values Documentation

Document return values:

```dart
/// Validates the user credentials against the authentication service.
///
/// [username] The username to validate.
/// [password] The password to check.
///
/// Returns true if credentials are valid, false otherwise.
bool validateCredentials(String username, String password) {
  // Implementation...
}
```

### Exception Documentation

Document exceptions that may be thrown:

```dart
/// Retrieves a user by their ID.
///
/// [userId] The unique ID of the user to retrieve.
///
/// Returns a [User] object if found.
/// Throws [NotFoundException] if no user exists with the given ID.
/// Throws [AuthorizationException] if the current user lacks permission.
User getUserById(String userId) {
  // Implementation...
}
```

### TODOS and Temporary Code

Clearly mark temporary code or TODOs:

```dart
// TODO(username): Improve the performance of this method before release
// FIXME: This is a temporary solution until the backend API is updated
```

## Logging

Use the logger with different levels:

```dart
logger.t("Trace log");
logger.d("Debug log");
logger.i("Info log");
logger.w("Warning log");
logger.e("Error log", error: 'Test Error');
logger.f("What a fatal log", error: error, stackTrace: stackTrace);
```

Use `jsonEncode` if you have multiple data to log.

To show only specific log levels:
```dart
Logger.level = Level.warning;
```