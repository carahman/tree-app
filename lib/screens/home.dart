import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:tree_app/utils/global_variables.dart';
import 'package:tree_app/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userData = {};
  String uid = FirebaseAuth.instance.currentUser!.uid;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid) // .doc(widget.uid)
          .get();

      userData = snap.data()!;

      // debug();
      // print("Snap Data: " + userData.toString());

      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 14,
                ),
                const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/tree-app-fyp.appspot.com/o/ads%2Fads1.png?alt=media&token=30e8ad96-4b65-4a18-8277-a3c95ddddcc5'),
                  width: double.infinity,
                ),
                SizedBox(
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/tree-app-fyp.appspot.com/o/ads%2Fads3.jpg?alt=media&token=40b99cf5-ff1b-4b6e-9bb0-da5faa334a2f'),
                  width: double.infinity,
                ),
                SizedBox(
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/tree-app-fyp.appspot.com/o/ads%2Fads2.jpg?alt=media&token=10ebad03-eb40-40f5-b90b-cedbc6bb8f95'),
                  width: double.infinity,
                ),
                SizedBox(
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/tree-app-fyp.appspot.com/o/ads%2Fads4.jpg?alt=media&token=c3d0b2cd-dc52-4e34-b760-c7fe35e7a2a0'),
                  width: double.infinity,
                ),
                SizedBox(
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/tree-app-fyp.appspot.com/o/ads%2Fads5.png?alt=media&token=979a1174-35ff-4578-be2a-6173b91d0390'),
                  width: double.infinity,
                ),
                SizedBox(
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/tree-app-fyp.appspot.com/o/ads%2Fads6.jpg?alt=media&token=c0d994e0-f850-4ea0-95f9-48f3102f0cb9'),
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
