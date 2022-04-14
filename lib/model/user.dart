import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String pass;
  final String cPass;
  final String fName;
  final String lName;
  final String phone;
  final String home;
  final String pCode;
  final String bName;
  final String bType;
  final String salary;
  final String state;
  final String ic;
  final String uid;

  const User({
    required this.email,
    required this.pass,
    required this.cPass,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.home,
    required this.pCode,
    required this.bName,
    required this.bType,
    required this.salary,
    required this.state,
    required this.ic,
    this.uid = '',
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      email: snapshot['email'],
      pass: snapshot['password'],
      cPass: snapshot['confirmPassword'],
      fName: snapshot['firstName'],
      lName: snapshot['lastName'],
      phone: snapshot['phoneNo'],
      home: snapshot['homeAddress'],
      pCode: snapshot['postcode'],
      bName: snapshot['businessName'],
      bType: snapshot['businessType'],
      salary: snapshot['salary'],
      state: snapshot['state'],
      ic: snapshot['identityCard'],
      uid: snapshot['uid'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': pass,
        'confirmPassword': cPass,
        'firstName': fName,
        'lastName': lName,
        'phoneNo': phone,
        'homeAddress': home,
        'postcode': pCode,
        'businessName': bName,
        'businessType': bType,
        'salary': salary,
        'state': state,
        'identityCard': ic,
        'uid': uid,
      };
}
