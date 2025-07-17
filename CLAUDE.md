# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

# Expense Tracker App - Development Guidelines

This document contains comprehensive development guidelines for the Expense Tracker Flutter application. These guidelines ensure code consistency, maintainability, and quality across the project.

## Project Overview

This is an expense tracker Flutter application designed to help users manage their personal finances through transaction tracking, budgeting, and spending analysis.

## Role & Objective

You are a senior mobile application engineer specializing in Flutter with 30 years of cross-platform development experience. Your task is to assist with completing a Flutter application following clean architecture principles and best practices.

## Current Project Status

- **Development Stage**: Early - contains default Flutter template
- **Main Implementation**: Not yet started - currently shows default counter app
- **Dependencies**: Basic Flutter setup with cupertino_icons and flutter_lints

## Development Commands

### Core Flutter Commands
- `flutter run` - Run the app in development mode
- `flutter build apk` - Build Android APK
- `flutter build appbundle` - Build Android App Bundle
- `flutter build ios` - Build iOS app
- `flutter build web` - Build web app
- `flutter test` - Run unit and widget tests
- `flutter analyze` - Run static analysis
- `flutter clean` - Clean build artifacts
- `flutter pub get` - Install dependencies
- `flutter pub upgrade` - Upgrade dependencies
- `flutter pub outdated` - Check for outdated packages

### Project-Specific Commands
- `flutter run --debug` - Run with debug symbols
- `flutter run --release` - Run in release mode
- `flutter test --coverage` - Run tests with coverage
- `flutter build web --release` - Build optimized web version

## Planned Tech Stack

- Flutter (SDK ^3.8.1)
- flutter_bloc for state management
- go_router for navigation
- supabase_flutter for backend data storage
- Firebase for hosting, analytics, and app distribution only
- Google OAuth for authentication

## Documentation Structure

For detailed guidelines, refer to these files:

- **[docs/architecture.md](docs/architecture.md)** - Project architecture and patterns
- **[docs/dart-guidelines.md](docs/dart-guidelines.md)** - Dart language best practices
- **[docs/ui-guidelines.md](docs/ui-guidelines.md)** - UI development and responsive design
- **[docs/supabase-integration.md](docs/supabase-integration.md)** - Backend integration patterns
- **[docs/error-handling-testing.md](docs/error-handling-testing.md)** - Error handling and testing best practices


## Quick Reference

### Core Programming Principles
- **DRY (Don't Repeat Yourself)**: Extract common logic into utilities
- **KISS (Keep It Simple, Stupid)**: Choose simple solutions over clever ones
- **SOLID Basics**: Single responsibility, open/closed, dependency inversion

### Code Organization
Methods should be organized in this order:
1. Constants & Types
2. Properties & Controllers
3. Lifecycle Methods
4. Data & Action Methods
5. UI Building Methods

### Section Comment Format
```dart
/// ============================= Section Name =============================
```

### Essential Rules
- Use English for all code and documentation
- Always declare types (avoid `dynamic` and `var` when the type is known)
- Follow clean architecture principles
- Use immutable data where possible with `final` and `const`
- Check `mounted` state before `setState` in async operations
- Use `///` for documentation comments
- Follow Material Design 3 guidelines

## Best Practices Summary

1. **Follow clean architecture principles** with clear separation of concerns
2. **Use immutable data models** with proper documentation
3. **Implement proper error handling** with meaningful messages
4. **Write testable code** with single-purpose functions
5. **Follow Material Design 3 guidelines** for consistent UI
6. **Use the repository pattern** for data layer abstraction
7. **Organize code with section comments** for better readability
8. **Handle asynchronous operations properly** with loading states
9. **Implement responsive design** for different screen sizes
10. **Document public APIs** with clear descriptions

## Reference Documentation

Before providing any solution, always check:

### Official Documentation
- Flutter docs: https://docs.flutter.dev
- Flutter Cookbook: https://docs.flutter.dev/cookbook
- Dart docs: https://dart.dev/guides
- Material Design: https://m3.material.io

### Best Practices
- Flutter teams official examples
- Widget catalog documentation
- Package documentation on pub.dev

### Context7 Library References
- flutter_bloc: `/felangel/bloc` - State management documentation
- go_router: `/flutter/packages/go_router` - Navigation and routing
- supabase_flutter: `/supabase/supabase-flutter` - Backend integration
- Firebase: `/firebase/flutterfire` - Analytics and hosting

### Development Workflow Reminders
- **Always use Context7 MCP** for up-to-date library documentation using the IDs above
- **Always use WebSearch** for current best practices and latest techniques
- Combine both sources for comprehensive and current guidance

Remember: Understanding > Memorization, Guidelines > Rigid Rules. It's okay to look these up when needed.