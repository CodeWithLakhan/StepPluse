import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/pages/dashboard_page.dart';
import 'firebase_options.dart'; // Generated during Firebase setup
import 'pages/login_page.dart'; // Login page located in lib/pages/

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
    return MaterialApp(
      title: 'StepPulse',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Define initial route and navigation
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
