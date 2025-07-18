import 'package:logger/logger.dart';

/// 全局日志服务，提供统一的日志记录功能
class LoggerService {
  /// 单例实例
  static final LoggerService _instance = LoggerService._internal();
  
  /// Logger 实例
  late final Logger _logger;
  
  /// 工厂构造函数，返回单例实例
  factory LoggerService() {
    return _instance;
  }
  
  /// 私有构造函数，初始化 Logger
  LoggerService._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2, // 显示的方法调用数量
        errorMethodCount: 8, // 错误时显示的方法调用数量
        lineLength: 120, // 每行最大长度
        colors: true, // 彩色输出
        printEmojis: true, // 打印表情符号
        // ignore: deprecated_member_use
        printTime: true, // 打印时间
      ),
    );
  }
  
  /// 获取 Logger 实例
  Logger get logger => _logger;
  
  /// 记录调试信息
  void d(dynamic message) {
    _logger.d(message);
  }
  
  /// 记录信息
  void i(dynamic message) {
    _logger.i(message);
  }
  
  /// 记录警告
  void w(dynamic message) {
    _logger.w(message);
  }
  
  /// 记录错误
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (error != null) {
      _logger.e(message, error: error, stackTrace: stackTrace);
    } else {
      _logger.e(message);
    }
  }
  
  /// 记录严重错误
  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (error != null) {
      _logger.f(message, error: error, stackTrace: stackTrace);
    } else {
      _logger.f(message);
    }
  }
} 