import 'package:logger/logger.dart';

/// Global logger service providing unified logging functionality across the application.
/// 
/// This service uses the singleton pattern to ensure consistent logging configuration
/// throughout the app. It wraps the `logger` package with convenient methods for
/// different log levels.
/// 
/// Usage:
/// ```dart
/// final logger = LoggerService();
/// logger.d('Debug message');
/// logger.i('Info message');
/// logger.w('Warning message');
/// logger.e('Error message', error, stackTrace);
/// ```
class LoggerService {
  /// Singleton instance
  static final LoggerService _instance = LoggerService._internal();
  
  /// Logger instance
  late final Logger _logger;
  
  /// Factory constructor returning singleton instance
  factory LoggerService() {
    return _instance;
  }
  
  /// Private constructor that initializes the Logger
  LoggerService._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2, // Number of method calls to show
        errorMethodCount: 8, // Number of method calls to show on error
        lineLength: 120, // Maximum line length
        colors: true, // Colored output
        printEmojis: true, // Print emojis
      ),
    );
  }
  
  /// Get the underlying Logger instance.
  /// 
  /// Provides direct access to the logger for advanced usage.
  Logger get logger => _logger;
  
  /// Log debug information.
  /// 
  /// Use for detailed information that is only of interest when diagnosing problems.
  void d(dynamic message) {
    _logger.d(message);
  }
  
  /// Log informational messages.
  /// 
  /// Use for general information about application flow.
  void i(dynamic message) {
    _logger.i(message);
  }
  
  /// Log warning messages.
  /// 
  /// Use for potentially harmful situations that don't prevent continued execution.
  void w(dynamic message) {
    _logger.w(message);
  }
  
  /// Log error messages.
  /// 
  /// Use for error events that might still allow the application to continue running.
  /// 
  /// [message] The error message to log
  /// [error] Optional error object
  /// [stackTrace] Optional stack trace for debugging
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (error != null) {
      _logger.e(message, error: error, stackTrace: stackTrace);
    } else {
      _logger.e(message);
    }
  }
  
  /// Log fatal errors.
  /// 
  /// Use for very severe error events that will presumably lead the application to abort.
  /// 
  /// [message] The fatal error message to log
  /// [error] Optional error object
  /// [stackTrace] Optional stack trace for debugging
  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (error != null) {
      _logger.f(message, error: error, stackTrace: stackTrace);
    } else {
      _logger.f(message);
    }
  }
} 