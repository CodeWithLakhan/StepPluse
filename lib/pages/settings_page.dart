import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/healthdataprovider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final healthDataProvider = Provider.of<HealthDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Bluetooth Connectivity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Connect to Smartwatch'),
              subtitle: Text(
                healthDataProvider.isWatchConnected
                    ? 'Connected'
                    : 'Disconnected',
                style: TextStyle(
                  color: healthDataProvider.isWatchConnected
                      ? Colors.green
                      : Colors.red,
                ),
              ),
              value: healthDataProvider.isWatchConnected,
              activeColor: Colors.green,
              inactiveThumbColor: Colors.red,
              inactiveTrackColor: Colors.red[200],
              onChanged: (value) {
                if (value) {
                  healthDataProvider.connectWatch();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Connected to the smartwatch'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  healthDataProvider.disconnectWatch();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Disconnected from the smartwatch'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
            const Divider(),
            const Text(
              'App Preferences',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.sync),
              title: const Text('Enable Data Synchronization'),
              trailing: Switch(
                value: healthDataProvider.isDataSyncEnabled,
                onChanged: (value) {
                  healthDataProvider.toggleDataSync(value);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(value
                          ? 'Data Synchronization Enabled'
                          : 'Data Synchronization Disabled'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Enable Notifications'),
              trailing: Switch(
                value: healthDataProvider.isNotificationsEnabled,
                onChanged: (value) {
                  healthDataProvider.toggleNotifications(value);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(value
                          ? 'Notifications Enabled'
                          : 'Notifications Disabled'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save settings or perform logout actions if needed
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Settings Saved'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
