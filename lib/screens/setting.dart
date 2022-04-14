import 'package:flutter/material.dart';
import 'package:tree_app/resources/auth_methods.dart';
import 'package:tree_app/screens/login.dart';
import 'package:tree_app/utils/colors.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            // GestureDetector(
            //   onTap: () async {
            //     await AuthMethods().signOut();
            //     Navigator.of(context).pushReplacement(MaterialPageRoute(
            //       builder: (context) => const LoginScreen(),
            //     ));
            //   },
            //   child: const Text("Log Out"),
            // ),
            InkWell(
          onTap: () async {
            await AuthMethods().signOut();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
          },
          child: SafeArea(
            child: Container(
              child: const Text(
                "Logout",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                color: treeColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
