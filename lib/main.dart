import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steppluse/pages/history_page.dart';
import 'package:steppluse/pages/settings_page.dart';
import 'package:steppluse/provider/healthdataprovider.dart';
import 'firebase_options.dart';
import 'pages/dashboard_page.dart';
import 'pages/login_page.dart';
import 'provider/authprovider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HealthDataProvider()..connectWatch()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'StepPulse',
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            secondary: Colors.purpleAccent,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          useMaterial3: true,
        ),
        home: const AuthWrapper(), // Dynamic home screen
        routes: {
          '/dashboard': (context) => DashboardPage(),
          '/history': (context) => const HistoryPage(),
          '/settings': (context) => const SettingsPage(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    // Check if the user is authenticated
    if (authProvider.isAuthenticated) {
      return  DashboardPage(); // Navigate to Dashboard if logged in
    } else {
      return const LoginScreen(); // Navigate to Login if not logged in
    }
  }
}
