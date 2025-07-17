# UI Development Guidelines

This document outlines UI development best practices and responsive design guidelines for the Expense Tracker Flutter application.

## Material Design 3
- Follow Material Design 3 guidelines
- Use Material 3 components whenever possible
- Implement responsive layouts for different screen sizes

## UI Component Structure
- Break down complex widgets into smaller methods
- Standard UI method naming:
  - `build*` for main widget builders
  - `_build*` for private sub-components
- Keep UI methods focused and small
- Extract reusable widgets to separate components
- Use consistent padding/spacing

## Responsive Design

### Using MediaQuery

- Prefer MediaQuery over hardcoded dimensions for responsive layouts
- Create breakpoint constants:
  ```dart
  class ResponsiveBreakpoints {
    // Small mobile devices
    static const double xs = 360.0;
    // Mobile devices
    static const double sm = 480.0;
    // Tablets and large phones
    static const double md = 768.0;
    // Small desktops and tablets in landscape
    static const double lg = 1024.0;
    // Large desktops
    static const double xl = 1280.0;
  }
  ```
- Use percentage-based dimensions:
  ```dart
  // Width as 80% of screen width
  width: MediaQuery.of(context).size.width * 0.8,
  ```
- Handle different device orientations:
  ```dart
  if (MediaQuery.of(context).orientation == Orientation.portrait) {
    // Portrait layout
  } else {
    // Landscape layout
  }
  ```
- Account for text scaling (preferred method):
  ```dart
  // Use the recommended text scaling APIs
  MediaQuery.withClampedTextScaling(
    maxScaleFactor: 1.5,
    child: myWidget,
  )
  
  // Or disable text scaling completely
  MediaQuery.withNoTextScaling(
    child: myWidget,
  )
  ```
- Handle non-linear text scaling on Android 14:
  ```dart
  // Conditionally handle linear vs. non-linear text scaling
  Builder(builder: (context) {
    final mediaQueryData = MediaQuery.of(context);
    // Force linear text scaling if needed
    return MediaQuery(
      data: mediaQueryData.copyWith(
        textScaler: TextScaler.linear(mediaQueryData.textScaler.textScaleFactor)
      ), 
      child: myWidget,
    );
  })
  ```
- Use safe areas for modern devices:
  ```dart
  return SafeArea(
    child: YourWidget(),
  );
  ```
- Use `MediaQuery.maybeOf` for nullable data:
  ```dart
  MediaQueryData? data = MediaQuery.maybeOf(context);
  if (data != null) {
    // Use data safely
  }
  ```
- Consider device pixel ratio for image resolution:
  ```dart
  final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
  // Select appropriate image resolution
  final imagePath = devicePixelRatio > 2 
      ? 'assets/images/high_res.png'
      : 'assets/images/normal_res.png';
  ```

### Adaptive Material Components

- Use responsive navigation patterns:
  ```dart
  // For small screens
  BottomNavigationBar(...)
  
  // For medium screens
  NavigationRail(...)
  
  // For large screens
  Drawer(...)
  ```
- Implement adaptive layouts:
  ```dart
  LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth < ResponsiveBreakpoints.md) {
        return _buildMobileLayout();
      } else {
        return _buildDesktopLayout();
      }
    },
  )
  ```
- Create responsive grids:
  ```dart
  GridView.builder(
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200.0, // Auto-adjusts column count
      childAspectRatio: 1.0,
    ),
    // other properties
  )
  ```
- Scale Material typography using modern APIs:
  ```dart
  Text(
    'Heading',
    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
      // TextScaler handles proper text scaling
      textScaler: MediaQuery.textScalerOf(context),
    ),
  )
  ```
- Use adaptive dialogs:
  ```dart
  // Responsive dialog sizing
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 
            (MediaQuery.of(context).size.width < ResponsiveBreakpoints.md ? 0.8 : 0.5),
        child: /* Dialog content */,
      ),
    ),
  );
  ```

### Testing Responsive Layouts

- Test on multiple device sizes
- Use device preview package for quick testing
- Test in both portrait and landscape orientations
- Check behavior with different text scale factors
- Verify accessibility with screen readers

## Example Screen Structure
```dart
class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  /// ============================= Properties & Controllers =============================
  final TextEditingController _searchController = TextEditingController();
  
  /// ============================= Lifecycle Methods =============================
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  /// ============================= Action Methods =============================
  void _handleSearch(String query) {
    // Handle search logic
  }
  
  /// ============================= UI Building =============================
  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: const InputDecoration(
        hintText: 'Search...',
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: _handleSearch,
    );
  }
  
  Widget _buildContent() {
    // Build content
    return Container();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Screen')),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }
}
```

## Widget Best Practices

### State Management
- Use StatefulWidget for widgets that need to track state
- Use StatelessWidget for widgets that don't change
- Minimize the use of setState() calls
- Group related state changes in single setState() calls

### Widget Composition
- Break large widgets into smaller, focused widgets
- Use composition over inheritance
- Create reusable widgets in separate files
- Use const constructors where possible

### Performance Optimization
- Use const constructors for immutable widgets
- Minimize widget rebuilds by using keys appropriately
- Use ListView.builder for long lists
- Implement proper disposal of controllers and subscriptions

### Accessibility
- Add semantic labels to interactive elements
- Use proper contrast ratios for text and backgrounds
- Ensure touch targets are at least 48x48 pixels
- Test with screen readers

## Common UI Patterns

### Loading States
```dart
Widget _buildContent() {
  return BlocBuilder<DataBloc, DataState>(
    builder: (context, state) {
      if (state is DataLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is DataError) {
        return Center(child: Text('Error: ${state.message}'));
      } else if (state is DataLoaded) {
        return _buildDataList(state.data);
      }
      return const SizedBox.shrink();
    },
  );
}
```

### Form Handling
```dart
Widget _buildForm() {
  return Form(
    key: _formKey,
    child: Column(
      children: [
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(labelText: 'Email'),
          validator: _validateEmail,
        ),
        TextFormField(
          controller: _passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: _validatePassword,
        ),
        ElevatedButton(
          onPressed: _handleSubmit,
          child: const Text('Submit'),
        ),
      ],
    ),
  );
}
```

### Error Handling UI
```dart
Widget _buildErrorState(String message) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 64,
          color: Theme.of(context).colorScheme.error,
        ),
        const SizedBox(height: 16),
        Text(
          message,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _handleRetry,
          child: const Text('Retry'),
        ),
      ],
    ),
  );
}
```

### Empty States
```dart
Widget _buildEmptyState() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.inbox_outlined,
          size: 64,
          color: Theme.of(context).colorScheme.outline,
        ),
        const SizedBox(height: 16),
        Text(
          'No transactions yet',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Add your first transaction to get started',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _handleAddTransaction,
          child: const Text('Add Transaction'),
        ),
      ],
    ),
  );
}
```

## Theming and Styling

### Color Scheme
- Use Material 3 color scheme
- Define custom colors in theme extensions
- Use semantic color names (primary, secondary, error, etc.)

### Typography
- Use Material 3 typography scale
- Define custom text styles in theme
- Ensure proper contrast ratios

### Spacing and Layout
- Use consistent spacing values (8, 16, 24, 32, etc.)
- Define spacing constants in a shared file
- Use EdgeInsets.symmetric() for consistent padding

### Example Theme Setup
```dart
ThemeData _buildTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
```

## Navigation

### Using GoRouter
```dart
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/transactions',
      builder: (context, state) => const TransactionsScreen(),
    ),
    GoRoute(
      path: '/transaction/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return TransactionDetailScreen(transactionId: id);
      },
    ),
  ],
);
```

### Navigation Best Practices
- Use named routes for better maintainability
- Handle deep links properly
- Implement proper back navigation
- Use proper transition animations

## Animation Guidelines

### Basic Animations
```dart
class AnimatedCounter extends StatefulWidget {
  const AnimatedCounter({Key? key}) : super(key: key);

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
      child: const Icon(Icons.check_circle),
    );
  }
}
```

### Animation Best Practices
- Use appropriate duration (200-500ms for most animations)
- Choose suitable easing curves
- Dispose of animation controllers properly
- Use built-in animated widgets when possible