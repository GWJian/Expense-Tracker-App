import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/main_screen.dart';
import 'theme/app_theme.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routes: {
        '/': (context) => const LoginScreen(),
        '/main': (context) => const MainScreen(),
      },
      initialRoute: '/main',
    );
  }
}