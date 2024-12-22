import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Dummy data for history
  final List<Map<String, dynamic>> records = [
    {
      'date': '2024-01-01',
      'heartRate': 75,
      'steps': 1200,
    },
    {
      'date': '2024-01-02',
      'heartRate': 80,
      'steps': 1500,
    },
    {
      'date': '2024-01-03',
      'heartRate': 78,
      'steps': 1400,
    },
    {
      'date': '2024-01-04',
      'heartRate': 72,
      'steps': 1600,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('History'),
      ),
      body: records.isEmpty
          ? const Center(
        child: Text(
          'No history available',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
          : ListView.builder(
        itemCount: records.length,
        itemBuilder: (context, index) {
          final record = records[index];
          return Card(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Text(
                  record['date'].split('-')[2], // Display day of the date
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                'Heart Rate: ${record['heartRate']} bpm',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Steps: ${record['steps']}',
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              trailing: Text(
                record['date'],
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
