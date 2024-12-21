import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Your Dashboard!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (user != null) ...[
              Text(
                'Logged in as:',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                user.email ?? 'Unknown User',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Example: Navigate to another feature or page
              },
              child: const Text('View Health Data'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Example: Navigate to a settings or history page
              },
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
