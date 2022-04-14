import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tree_app/model/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // sign up user
  Future<String> signUpUser({
    required String email,
    required String pass,
    required String cPass,
    required String fName,
    required String lName,
    required String phone,
    required String home,
    required String pCode,
    required String bName,
    required String bType,
    required String salary,
    required String state,
    required String ic,
  }) async {
    String res = "Please fill in all the details"; // = "Some error occured";
    try {
      if (email.isNotEmpty &&
          pass.isNotEmpty &&
          cPass.isNotEmpty &&
          fName.isNotEmpty &&
          lName.isNotEmpty &&
          phone.isNotEmpty &&
          home.isNotEmpty &&
          pCode.isNotEmpty &&
          bName.isNotEmpty &&
          bType.isNotEmpty &&
          salary.isNotEmpty &&
          state.isNotEmpty &&
          ic.isNotEmpty) {
        // register user
        if (pass != cPass) {
          res = "Password do not match";
        } else if (pCode.length > 5 || pCode.length < 5) {
          res = "Enter a valid Postcode";
        } else if (ic.length > 12 || ic.length < 12) {
          res = "Enter a valid IC Number without symbols";
        } else {
          UserCredential cred = await _auth.createUserWithEmailAndPassword(
              email: email, password: pass);

          model.User _user = model.User(
            email: email,
            pass: pass,
            cPass: cPass,
            fName: fName,
            lName: lName,
            phone: phone,
            home: home,
            pCode: pCode,
            bName: bName,
            bType: bType,
            salary: salary,
            state: state,
            ic: ic,
            uid: cred.user!.uid,
          );
          // add user to database
          await _firestore
              .collection('users')
              .doc(cred.user!.uid)
              .set(_user.toJson());

          res = "success";
        }
      } else {
        res = "Please fill in all the details";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'Invalid email format';
      } else if (err.code == 'weak-password') {
        res = 'Password must contain at least 6 digit';
      } else if (err.code == 'unknown') {
        res = 'Please fill in all the details';
      } else if (err.code == 'email-already-in-use') {
        res = 'Email is already in use';
      } else {
        res = err.toString();
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // edit user
  Future<String> editUser({
    required String email,
    required String pass,
    required String cPass,
    required String fName,
    required String lName,
    required String phone,
    required String home,
    required String pCode,
    required String bName,
    required String bType,
    required String salary,
    required String state,
    required String ic,
  }) async {
    String res = "Please fill in all the details"; // = "Some error occured";
    try {
      if (email.isNotEmpty &&
          pass.isNotEmpty &&
          cPass.isNotEmpty &&
          fName.isNotEmpty &&
          lName.isNotEmpty &&
          phone.isNotEmpty &&
          home.isNotEmpty &&
          pCode.isNotEmpty &&
          bName.isNotEmpty &&
          bType.isNotEmpty &&
          salary.isNotEmpty &&
          state.isNotEmpty &&
          ic.isNotEmpty) {
        // print("it's working");
        // register user
        // UserCredential cred = await _auth.createUserWithEmailAndPassword(
        //     email: email, password: pass);
        // print(FirebaseAuth.instance.currentUser!.uid);
        if (pCode.length > 5 || pCode.length < 5) {
          res = "Enter a valid Postcode";
        } else {
          model.User _user = model.User(
            email: email,
            pass: pass,
            cPass: cPass,
            fName: fName,
            lName: lName,
            phone: phone,
            home: home,
            pCode: pCode,
            bName: bName,
            bType: bType,
            salary: salary,
            state: state,
            ic: ic,
            uid: FirebaseAuth.instance.currentUser!.uid,
          );
          // print(FirebaseAuth.instance.currentUser!.uid);
          // add user to database
          await _firestore
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set(_user.toJson());
          // print(FirebaseAuth.instance.currentUser!.uid);

          res = "success";
        }
      } else {
        res = "Please fill in all the details";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'Invalid email format';
      } else if (err.code == 'weak-password') {
        res = 'Password must contain at least 6 digit';
      } else if (err.code == 'unknown') {
        res = 'Please fill in all the details';
      } else {
        res = err.toString();
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String pass,
  }) async {
    String res = "Some error Occured"; // = "An error occured";

    try {
      if (email.isNotEmpty || pass.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: pass,
        );

        // print("test" + FirebaseAuth.instance.currentUser!.uid);

        res = 'success';
      } else {
        res = "Please enter your email and password";
      }
    } on FirebaseAuthException catch (e) {
      // unknown invalid-email user-not-found
      if (e.code == 'invalid-email') {
        res = "Please enter a valid email";
      } else if (e.code == 'unknown') {
        res = "Please enter password";
      } else if (e.code == 'user-not-found') {
        res = "User not found. Please register.";
      } else if (e.code == 'wrong-password') {
        res = "Wrong password";
      } else if (e.code == 'too-many-requests') {
        res = "Too many attempts. Please try again in few minutes.";
      } else {
        res = e.toString();
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
