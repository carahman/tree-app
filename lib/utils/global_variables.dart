// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tree_app/screens/home.dart';
import 'package:tree_app/screens/profile.dart';
import 'package:tree_app/screens/setting.dart';

List<Widget> homeScreenItems = [
  const HomeScreen(),
  const ProfileScreen(),
  const SettingScreen(),
];

// void debug() {
//   String uid = FirebaseAuth.instance.currentUser!.uid;
//   print("UID Debug: " + uid);
// }
