import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../provider/firestore_service.dart';
import '../provider/healthdataprovider.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final healthDataProvider = Provider.of<HealthDataProvider>(context);
    final user = FirebaseAuth.instance.currentUser;

    // Calculate calories burned (assume 0.04 calories per step)
    final caloriesBurned = (healthDataProvider.steps * 0.04).toStringAsFixed(2);

    return Scaffold(
      drawer: _buildDrawer(context, user),
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [_buildWatchConnectionToggle(context, healthDataProvider)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Health Metrics',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMetricCard(
                    icon: Icons.favorite,
                    title: 'Heart Rate',
                    value: '${healthDataProvider.heartRate} bpm',
                    color: Colors.red,
                  ),
                  _buildMetricCard(
                    icon: Icons.directions_walk,
                    title: 'Steps',
                    value: '${healthDataProvider.steps}',
                    color: Colors.blue,
                  ),
                  _buildMetricCard(
                    icon: Icons.local_fire_department,
                    title: 'Calories',
                    value: '$caloriesBurned kcal',
                    color: Colors.orange,
                  ),
                  _buildMetricCard(
                    icon: Icons.timer,
                    title: 'Activity',
                    value: '30 mins', // Mocked duration, update as needed
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context, User? user) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.account_circle_rounded,
                      size: 80,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.displayName ?? "Guest",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          user?.email ?? "Unknown User",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.history,
              text: "History",
              onTap: () {
                Navigator.pushNamed(context, '/history');
              },
            ),
            _buildDrawerItem(
              context,
              icon: Icons.settings,
              text: "Settings",
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            const Divider(color: Colors.white70),
            _buildDrawerItem(
              context,
              icon: Icons.logout,
              text: "Log Out",
              onTap: () {
                _showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWatchConnectionToggle(
      BuildContext context, HealthDataProvider healthDataProvider) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            healthDataProvider.isWatchConnected
                ? 'Connected'
                : 'Disconnected',
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(width: 8),
          Switch(
            value: healthDataProvider.isWatchConnected,
            activeColor: Colors.green,
            inactiveThumbColor: Colors.red,
            inactiveTrackColor: Colors.red[200],
            onChanged: (value) {
              if (value) {
                healthDataProvider.connectWatch();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Connected to the watch'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                healthDataProvider.disconnectWatch();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Disconnected from the watch'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildDrawerItem(BuildContext context,
      {required IconData icon, required String text, required Function() onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          title: const Text(
            "Log Out",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "Do you really want to log out?",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Dismiss dialog
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
