# Error Handling and Testing Guidelines

This document provides comprehensive guidelines for error handling and testing in the Expense Tracker Flutter application, based on 2025 best practices.

## Error Handling Guidelines

### Core Principles
- **Graceful Recovery**: Handle errors to prevent app crashes and provide meaningful feedback
- **Type Safety**: Use specific exception types rather than generic catches
- **User Experience**: Display user-friendly error messages, never show technical errors to users
- **Logging**: Implement comprehensive error logging for debugging and monitoring

### Error Handling Patterns

#### 1. Try-Catch Best Practices
```dart
try {
  // Risky operation
  final result = await apiService.getData();
  return result;
} on NetworkException catch (e) {
  // Handle specific network errors
  _showError('Connection failed. Please check your internet.');
  return null;
} on ValidationException catch (e) {
  // Handle validation errors
  _showError(e.message);
  return null;
} on Exception catch (e) {
  // Handle other known exceptions
  _logError('Unexpected error', e);
  _showError('Something went wrong. Please try again.');
  return null;
} catch (e) {
  // Last resort for unknown errors
  _logError('Unknown error', e);
  _showError('An unexpected error occurred.');
  return null;
}
```

#### 2. Result Pattern (Recommended for 2025)
```dart
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Error<T> extends Result<T> {
  final String message;
  final Exception? exception;
  const Error(this.message, [this.exception]);
}

// Usage
Future<Result<User>> getUser(String id) async {
  try {
    final user = await userRepository.getUser(id);
    return Success(user);
  } on NetworkException catch (e) {
    return Error('Network error: ${e.message}', e);
  } catch (e) {
    return Error('Failed to get user', e as Exception);
  }
}

// In UI
final result = await userService.getUser(userId);
switch (result) {
  case Success<User>(data: final user):
    // Handle success
    setState(() => _user = user);
  case Error<User>(message: final message):
    // Handle error
    _showError(message);
}
```

#### 3. Global Error Handling
```dart
void main() {
  // Handle Flutter framework errors
  FlutterError.onError = (details) {
    FirebaseCrashlytics.instance.recordFlutterError(details);
  };

  // Handle errors outside Flutter
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };

  runApp(MyApp());
}
```

#### 4. Custom Exception Classes
```dart
// Base exception class
abstract class AppException implements Exception {
  final String message;
  final String? code;
  
  const AppException(this.message, [this.code]);
}

// Specific exception types
class NetworkException extends AppException {
  const NetworkException(super.message, [super.code]);
}

class ValidationException extends AppException {
  const ValidationException(super.message, [super.code]);
}

class AuthenticationException extends AppException {
  const AuthenticationException(super.message, [super.code]);
}

class BusinessLogicException extends AppException {
  const BusinessLogicException(super.message, [super.code]);
}
```

#### 5. Error Handling in BLoC
```dart
class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(ExpenseInitial()) {
    on<LoadExpenses>(_onLoadExpenses);
  }

  Future<void> _onLoadExpenses(
    LoadExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseLoading());
    
    try {
      final expenses = await _expenseRepository.getExpenses();
      emit(ExpenseLoaded(expenses));
    } on NetworkException catch (e) {
      emit(ExpenseError('No internet connection. Please try again.'));
    } on Exception catch (e) {
      emit(ExpenseError('Failed to load expenses. Please try again.'));
      _logError('Failed to load expenses', e);
    }
  }
}
```

### Error Handling Rules
- **Never ignore errors**: Always handle or log exceptions
- **Be specific**: Catch specific exception types when possible
- **Fail fast**: Validate inputs early and throw meaningful exceptions
- **Log context**: Include relevant context in error logs
- **Check mounted state**: Always check `mounted` before `setState` in async operations
- **Use sealed classes**: For type-safe error handling with pattern matching

### Error Logging Best Practices
```dart
class ErrorLogger {
  static void logError(String message, dynamic error, [StackTrace? stackTrace]) {
    // Log to console in debug mode
    if (kDebugMode) {
      print('ERROR: $message - $error');
      if (stackTrace != null) {
        print('Stack trace: $stackTrace');
      }
    }
    
    // Log to crash reporting service
    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: message,
    );
  }
  
  static void logWarning(String message, [Map<String, dynamic>? context]) {
    if (kDebugMode) {
      print('WARNING: $message');
      if (context != null) {
        print('Context: $context');
      }
    }
    
    FirebaseCrashlytics.instance.log('WARNING: $message');
  }
}
```

## Testing Guidelines

### Testing Strategy
- **Unit Tests**: 70% - Fast, isolated tests for business logic
- **Widget Tests**: 20% - UI component testing
- **Integration Tests**: 10% - End-to-end user flows

### Unit Testing Best Practices

#### Test Structure and Organization
```dart
group('UserService', () {
  late UserService userService;
  late MockUserRepository mockRepository;
  late MockAuthService mockAuthService;

  setUp(() {
    mockRepository = MockUserRepository();
    mockAuthService = MockAuthService();
    userService = UserService(mockRepository, mockAuthService);
  });

  group('getUser', () {
    test('should return user when repository succeeds', () async {
      // Arrange
      const userId = '123';
      const expectedUser = User(id: userId, name: 'John Doe');
      when(mockRepository.getUser(userId))
          .thenAnswer((_) async => expectedUser);

      // Act
      final result = await userService.getUser(userId);

      // Assert
      expect(result, equals(expectedUser));
      verify(mockRepository.getUser(userId)).called(1);
    });

    test('should throw NetworkException when repository fails', () async {
      // Arrange
      const userId = '123';
      when(mockRepository.getUser(userId))
          .thenThrow(NetworkException('Connection failed'));

      // Act & Assert
      expect(
        () => userService.getUser(userId),
        throwsA(isA<NetworkException>()),
      );
    });
  });
});
```

#### Testing BLoC
```dart
group('ExpenseBloc', () {
  late ExpenseBloc expenseBloc;
  late MockExpenseRepository mockRepository;

  setUp(() {
    mockRepository = MockExpenseRepository();
    expenseBloc = ExpenseBloc(mockRepository);
  });

  tearDown(() {
    expenseBloc.close();
  });

  blocTest<ExpenseBloc, ExpenseState>(
    'emits [ExpenseLoading, ExpenseLoaded] when LoadExpenses succeeds',
    build: () {
      when(mockRepository.getExpenses())
          .thenAnswer((_) async => [testExpense]);
      return expenseBloc;
    },
    act: (bloc) => bloc.add(LoadExpenses()),
    expect: () => [
      ExpenseLoading(),
      ExpenseLoaded([testExpense]),
    ],
  );

  blocTest<ExpenseBloc, ExpenseState>(
    'emits [ExpenseLoading, ExpenseError] when LoadExpenses fails',
    build: () {
      when(mockRepository.getExpenses())
          .thenThrow(NetworkException('Connection failed'));
      return expenseBloc;
    },
    act: (bloc) => bloc.add(LoadExpenses()),
    expect: () => [
      ExpenseLoading(),
      ExpenseError('No internet connection. Please try again.'),
    ],
  );
});
```

### Widget Testing Best Practices

#### Widget Test Structure
```dart
group('ExpenseForm', () {
  testWidgets('should show validation error for invalid amount', (tester) async {
    // Arrange
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExpenseForm(
            onSubmit: (expense) {},
          ),
        ),
      ),
    );

    // Act
    await tester.enterText(find.byKey(Key('amount_field')), 'invalid');
    await tester.tap(find.byKey(Key('submit_button')));
    await tester.pump();

    // Assert
    expect(find.text('Please enter a valid amount'), findsOneWidget);
  });

  testWidgets('should call onSubmit when form is valid', (tester) async {
    // Arrange
    Expense? submittedExpense;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExpenseForm(
            onSubmit: (expense) => submittedExpense = expense,
          ),
        ),
      ),
    );

    // Act
    await tester.enterText(find.byKey(Key('amount_field')), '25.50');
    await tester.enterText(find.byKey(Key('description_field')), 'Coffee');
    await tester.tap(find.byKey(Key('submit_button')));
    await tester.pump();

    // Assert
    expect(submittedExpense, isNotNull);
    expect(submittedExpense!.amount, 25.50);
    expect(submittedExpense!.description, 'Coffee');
  });
});
```

#### Testing with BLoC
```dart
group('ExpenseListPage', () {
  late MockExpenseBloc mockBloc;

  setUp(() {
    mockBloc = MockExpenseBloc();
  });

  testWidgets('should show loading indicator when state is loading', (tester) async {
    // Arrange
    when(mockBloc.state).thenReturn(ExpenseLoading());
    whenListen(mockBloc, Stream.fromIterable([ExpenseLoading()]));

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ExpenseBloc>.value(
          value: mockBloc,
          child: ExpenseListPage(),
        ),
      ),
    );

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
});
```

### Integration Testing Best Practices

#### Integration Test Structure
```dart
void main() {
  group('Expense Tracker App', () {
    testWidgets('should complete expense creation flow', (tester) async {
      // Launch app
      app.main();
      await tester.pumpAndSettle();

      // Navigate to add expense
      await tester.tap(find.byKey(Key('add_expense_fab')));
      await tester.pumpAndSettle();

      // Fill expense form
      await tester.enterText(find.byKey(Key('amount_field')), '25.50');
      await tester.enterText(find.byKey(Key('description_field')), 'Coffee');
      await tester.tap(find.byKey(Key('category_dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Food & Dining'));
      await tester.pumpAndSettle();

      // Submit expense
      await tester.tap(find.byKey(Key('save_button')));
      await tester.pumpAndSettle();

      // Verify expense appears in list
      expect(find.text('Coffee'), findsOneWidget);
      expect(find.text('\$25.50'), findsOneWidget);
      expect(find.text('Food & Dining'), findsOneWidget);
    });

    testWidgets('should handle network error gracefully', (tester) async {
      // Setup network failure
      HttpOverrides.global = MockHttpOverrides();
      
      app.main();
      await tester.pumpAndSettle();

      // Trigger network operation
      await tester.tap(find.byKey(Key('refresh_button')));
      await tester.pumpAndSettle();

      // Verify error message is shown
      expect(find.text('Connection failed. Please check your internet.'), findsOneWidget);
    });
  });
}
```

### Test Helpers and Utilities

#### Test Data Factory
```dart
class TestDataFactory {
  static User createUser({
    String? id,
    String? name,
    String? email,
  }) {
    return User(
      id: id ?? 'test_user_id',
      name: name ?? 'Test User',
      email: email ?? 'test@example.com',
    );
  }

  static Expense createExpense({
    String? id,
    double? amount,
    String? description,
    Category? category,
    DateTime? date,
  }) {
    return Expense(
      id: id ?? 'test_expense_id',
      amount: amount ?? 25.50,
      description: description ?? 'Test Expense',
      category: category ?? Category.food,
      date: date ?? DateTime.now(),
    );
  }
}
```

#### Mock Data Builder
```dart
class MockDataBuilder {
  static List<Expense> buildExpenseList({int count = 5}) {
    return List.generate(
      count,
      (index) => TestDataFactory.createExpense(
        id: 'expense_$index',
        amount: (index + 1) * 10.0,
        description: 'Expense $index',
      ),
    );
  }
}
```

### Testing Commands and Setup

#### Required Dependencies
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.4
  build_runner: ^2.4.7
  bloc_test: ^9.1.5
  integration_test:
    sdk: flutter
  golden_toolkit: ^0.15.0
```

#### Test Commands
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/unit/services/user_service_test.dart

# Run integration tests
flutter test integration_test/

# Run tests by pattern
flutter test --name "should return user"

# Generate mocks
flutter packages pub run build_runner build
```

### Testing File Organization
```
test/
├── unit/
│   ├── services/
│   │   ├── user_service_test.dart
│   │   └── expense_service_test.dart
│   ├── repositories/
│   │   └── expense_repository_test.dart
│   ├── blocs/
│   │   └── expense_bloc_test.dart
│   └── models/
│       └── expense_test.dart
├── widget/
│   ├── pages/
│   │   └── expense_list_page_test.dart
│   ├── components/
│   │   └── expense_card_test.dart
│   └── forms/
│       └── expense_form_test.dart
├── helpers/
│   ├── test_helpers.dart
│   ├── mock_data.dart
│   └── test_data_factory.dart
└── goldens/
    └── expense_card_test.dart

integration_test/
├── app_test.dart
├── auth_flow_test.dart
├── expense_management_test.dart
└── helpers/
    └── integration_test_helpers.dart
```

### Testing Best Practices Summary

1. **Write tests first** (TDD approach when possible)
2. **Maintain high coverage** (aim for 80%+ code coverage)
3. **Test behavior, not implementation**
4. **Use descriptive test names** that explain expected behavior
5. **Keep tests fast** and independent
6. **Mock external dependencies** (APIs, databases, services)
7. **Test error scenarios** as thoroughly as success cases
8. **Run tests in CI/CD** pipeline
9. **Use golden tests** for complex UI components
10. **Test accessibility** features
11. **Group related tests** logically
12. **Use AAA pattern** (Arrange, Act, Assert)
13. **Test edge cases** and boundary conditions
14. **Verify interactions** with mocks
15. **Clean up resources** in tearDown methods

### Performance Testing

#### Load Testing
```dart
test('should handle large expense lists efficiently', () async {
  // Arrange
  final largeExpenseList = MockDataBuilder.buildExpenseList(count: 10000);
  when(mockRepository.getExpenses())
      .thenAnswer((_) async => largeExpenseList);

  // Act
  final stopwatch = Stopwatch()..start();
  final result = await expenseService.getExpenses();
  stopwatch.stop();

  // Assert
  expect(result.length, equals(10000));
  expect(stopwatch.elapsedMilliseconds, lessThan(100));
});
```

#### Memory Testing
```dart
test('should not have memory leaks in expense processing', () async {
  // Test memory usage patterns
  final initialMemory = ProcessInfo.currentRss;
  
  // Perform operations
  for (int i = 0; i < 1000; i++) {
    await expenseService.processExpense(TestDataFactory.createExpense());
  }
  
  // Force garbage collection
  await Future.delayed(Duration(milliseconds: 100));
  
  final finalMemory = ProcessInfo.currentRss;
  expect(finalMemory - initialMemory, lessThan(1024 * 1024)); // Less than 1MB
});
```

## Conclusion

Following these error handling and testing guidelines will help ensure the Expense Tracker app is robust, maintainable, and provides a great user experience. Regular testing and proper error handling are essential for production-ready Flutter applications.