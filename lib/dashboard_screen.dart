import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Remove Firestore and missing screen imports

class DashboardScreen extends StatelessWidget {
  final User user;
  const DashboardScreen({required this.user, super.key});

  // Future<String> getUserRole() async {
  //   final doc = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user.uid)
  //       .get();
  //   if (doc.exists && doc.data()?['role'] == 'admin') {
  //     return 'admin';
  //   }
  //   return 'public';
  // }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Welcome, ${user.email}'));
  }
}
