# Dart Language Guidelines

This document outlines Dart language best practices and conventions for the Expense Tracker Flutter application.

## Basic Principles
- Use English for all code and documentation
- Always declare types (avoid `dynamic` and `var` when the type is known)
- Follow clean architecture principles
- Use immutable data where possible with `final` and `const`
- Follow the Dart style guide: https://dart.dev/guides/language/effective-dart/style

## Nomenclature
- Use PascalCase for classes, enums, extensions, and typedefs
- Use camelCase for variables, functions, methods, and named parameters
- Use underscores_case for files and directories
- Use SCREAMING_CAPS for constants
- Prefix private members with underscore (_)

## Functions and Classes
- Write short, single-purpose functions (< 20 lines)
- Follow SOLID principles
- Prefer composition over inheritance
- Make classes immutable when possible
- Use factory constructors appropriately
- Make use of Dart's cascade notation (..) when appropriate

## Collections and Iterables

- Use collection literals when possible
- Use collection methods like `map`, `where`, `firstWhere`, etc. over manual iteration
- Consider using `const` for immutable collections
- Use the spread operator (...) and collection if when appropriate

```dart
// Good
final combined = [
  ...firstList,
  if (includeMiddle) ...middleList,
  ...lastList,
];

// Avoid
final combined = <String>[];
combined.addAll(firstList);
if (includeMiddle) {
  combined.addAll(middleList);
}
combined.addAll(lastList);
```

## Null Safety

- Embrace null safety
- Avoid using `!` (null assertion operator) when possible
- Use `??` (null coalescing operator) for providing default values
- Use conditional property access with `?.` when appropriate
- Handle nullability explicitly with proper checks

```dart
// Good
final name = user?.name ?? 'Guest';

// Avoid
final name = user!.name; // Dangerous

// Good
if (user != null && user.isAdmin) {
  // Do admin stuff
}

// Avoid
if (user!.isAdmin) { // Dangerous
  // Do admin stuff
}
```

## Error Handling in Dart

- Use exceptions for exceptional conditions, not for control flow
- Catch specific exceptions rather than using catch-all
- Always handle or rethrow exceptions
- Use `try-catch` blocks to gracefully handle errors
- Consider using `Result` pattern for complex error scenarios

```dart
// Good
try {
  final data = await repository.fetchData();
  return data;
} on NetworkException catch (e) {
  log.error('Network error: $e');
  rethrow; // Or handle appropriately
} on FormatException catch (e) {
  log.error('Format error: $e');
  rethrow; // Or handle appropriately
}

// Avoid
try {
  final data = await repository.fetchData();
  return data;
} catch (e) {
  // Generic error handling
  log.error('Error: $e');
  rethrow;
}
```

## Asynchronous Programming

- Use `async`/`await` for cleaner asynchronous code
- Properly handle errors in asynchronous code
- Avoid unnecessary `Future.then()` chains when `async`/`await` can be used
- Use `Future.wait()` for parallel asynchronous operations
- Properly document asynchronous methods

```dart
// Good
Future<List<Item>> fetchItems() async {
  final response = await http.get(url);
  
  if (response.statusCode == 200) {
    return (json.decode(response.body) as List)
        .map((data) => Item.fromJson(data))
        .toList();
  } else {
    throw Exception('Failed to load items');
  }
}

// Avoid
Future<List<Item>> fetchItems() {
  return http.get(url).then((response) {
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((data) => Item.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load items');
    }
  });
}
```

## Extension Methods

Use extension methods to add functionality to existing classes:

```dart
extension DateTimeExtensions on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.year == year && now.month == month && now.day == day;
  }
  
  String formatYMD() {
    return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }
}

// Usage
final date = DateTime.now();
if (date.isToday) {
  print(date.formatYMD());
}
```

## Code Performance

- Use const constructors when possible
- Minimize object allocations in hot code paths
- Use lazy initialization for expensive objects
- Be mindful of memory leaks, especially with closures and stream subscriptions
- Profile code performance in release mode

## Code Organization

### Method Order
Methods should be organized in the following order:

1. **Constants & Types**
```dart
/// ============================= Constants & Types =============================
class ScreenNameConstants {
  // Constants grouped by type
}
```

2. **Properties & Controllers**
```dart
/// ============================= Properties & Controllers =============================
final TextEditingController nameController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
```

3. **Lifecycle Methods**
```dart
/// ============================= Lifecycle Methods =============================
@override
void initState() { }

@override
void dispose() { }

@override
Widget build(BuildContext context) { }
```

4. **Data & Action Methods**
```dart
/// ============================= Data Methods =============================
Future<void> _loadData() async { }
void _handleData() { }

/// ============================= Action Methods =============================
void _handleTap() { }
void _handleSubmit() { }
```

5. **UI Building Methods**
```dart
/// ============================= UI Building =============================
Widget _buildForm() { }
Widget _buildButton() { }
```

### Section Comment Format
All major sections should use the following format:
```dart
/// ============================= Section Name =============================
```

### Method Naming Conventions
- UI building methods should start with `_build`
- Action handlers should start with `_handle`
- Validation methods should start with `_validate`
- Data operations should be descriptive of their purpose

### Constants Organization
Group constants by type in a dedicated class:

```dart
class ScreenNameConstants {
  // Spacing
  static const double contentPadding = 16.0;
  
  // Dimensions
  static const double buttonRadius = 8.0;
  
  // Colors
  static const Color primaryColor = Colors.blue;
  
  // Strings
  static const String title = 'Screen Title';
}
```

## Form Validation

- Group validation methods together
- Use descriptive validation error messages
- Extract validation logic to separate methods
- Use constants for validation rules

### Example Form Validation

```dart
/// ============================= Validation Methods =============================
String? _validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? _validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }
  return null;
}
```

## Core Programming Principles

### DRY (Don't Repeat Yourself)
- Extract common validation logic into utilities
- Reuse repository patterns with base classes
- Centralize constants and configuration
- **When to break**: Prefer clarity over abstraction when logic differs

### KISS (Keep It Simple, Stupid)
- Choose simple solutions over clever ones
- Write code that's easy to understand and maintain
- Avoid over-engineering for imaginary future needs
- **Ask**: "What's the simplest thing that works?"

### SOLID Basics
- **Single Responsibility**: One class, one reason to change
- **Open/Closed**: Extend behavior through interfaces, not modification
- **Dependency Inversion**: Depend on abstractions (interfaces), not concrete implementations

## Application Guidelines

- Use during code reviews to guide discussions
- Apply when refactoring existing code
- Consider when designing new features
- Reference when code feels complex or hard to maintain

## Remember

- Understanding > Memorization
- Guidelines > Rigid Rules
- It's okay to look these up when needed