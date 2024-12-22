import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save or update user profile
  Future<void> saveUserProfile(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userId).set(data, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to save user profile: $e');
    }
  }

  // Save health data
  Future<void> saveHealthData(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('healthData')
          .add(data); // Add a new document to the healthData subcollection
    } catch (e) {
      throw Exception('Failed to save health data: $e');
    }
  }

  // Retrieve health history
  Future<List<Map<String, dynamic>>> getHealthHistory(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('healthData')
          .orderBy('date', descending: true)
          .get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Failed to fetch health history: $e');
    }
  }
}
