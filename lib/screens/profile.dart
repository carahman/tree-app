import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:tree_app/utils/global_variables.dart';
import 'package:tree_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tree_app/widgets/text_field_input.dart';
import 'package:tree_app/utils/colors.dart';
import 'package:tree_app/resources/auth_methods.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController cPassController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController pCodeController = TextEditingController();
  TextEditingController bNameController = TextEditingController();
  TextEditingController bTypeController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController icController = TextEditingController();
  var userData = {};
  String uid = FirebaseAuth.instance.currentUser!.uid;
  bool isLoading = false;
  bool isRead = true;
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void cancelEdit() {
    setState(() {
      isRead = true;
      isEdit = false;
    });
  }

  void editMode() {
    setState(() {
      isRead = false;
      isEdit = true;
    });
    phoneController.text = userData['phoneNo'];
    homeController.text = userData['homeAddress'];
    pCodeController.text = userData['postcode'];
    bNameController.text = userData['businessName'];
    bType = userData['businessType'];
    salaryController.text = userData['salary'];
    state = userData['state'];
  }

  void onSave() async {
    setState(() {
      isLoading = true;
    });

    if (phoneController.text.isEmpty) {
      phoneController.text = userData['phoneNo'];
    }
    if (homeController.text.isEmpty) {
      homeController.text = userData['homeAddress'];
    }
    if (pCodeController.text.isEmpty) {
      pCodeController.text = userData['postcode'];
    }
    if (bNameController.text.isEmpty) {
      bNameController.text = userData['businessName'];
    }
    if (bTypeController.text.isEmpty) {
      bTypeController.text = userData['businessType'];
    }
    if (salaryController.text.isEmpty) {
      salaryController.text = userData['salary'];
    }
    if (stateController.text.isEmpty) {
      stateController.text = userData['state'];
    }

    String res = await AuthMethods().editUser(
      email: userData['email'],
      pass: userData['password'],
      cPass: userData['confirmPassword'],
      fName: userData['firstName'],
      lName: userData['lastName'],
      phone: phoneController.text,
      home: homeController.text,
      pCode: pCodeController.text,
      bName: bNameController.text,
      bType: bType.toString(),
      salary: salaryController.text,
      state: state.toString(),
      ic: userData['identityCard'],
    );

    if (res != "success") {
      showSnackBar(context, res);
      // print("res: " + res);
      isEdit = true;
      isRead = false;
    } else if (res == "success") {
      setState(() {
        isEdit = false;
        isRead = true;
      });
    }
    isLoading = false;

    // print("res: " + res);

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

  final businessType = [
    'Accessories',
    'Agriculture Product',
    'Clothes and Apparel',
    'E-hailing',
    'Food and Beverages',
    'Gas and Services',
    'Health and Beauty',
    'Mini Market',
    'Retail Store',
  ];

  final stateList = [
    'Johor',
    'Kedah',
    'Kelantan',
    'Melacca',
    'Negeri Sembilan',
    'Pahang',
    'Penang',
    'Perak',
    'Perlis',
    'Sabah',
    'Sarawak',
    'Selangor',
    'Terengganu',
    'Kuala Lumpur',
    'Putrajaya',
    'Labuan',
  ];

  String? bType, state;

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontSize: 16),
      ));

  DropdownMenuItem<String> buildStateItem(String state) => DropdownMenuItem(
      value: state,
      child: Text(
        state,
        style: const TextStyle(fontSize: 16),
      ));

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),

                      const Center(
                        child: Text(
                          'My Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      // first name form
                      TextFieldInput(
                        textEditingController:
                            TextEditingController(text: userData['firstName']),
                        hintText: "First Name",
                        textInputType: TextInputType.text,
                        isRead: true,
                        prefix: 'First Name: ',
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      // last name form
                      TextFieldInput(
                        textEditingController: TextEditingController(
                            text: lNameController.text = userData['lastName']),
                        hintText: "Last Name",
                        textInputType: TextInputType.text,
                        isRead: true,
                        prefix: 'Last Name: ',
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      // ic number form
                      TextFieldInput(
                        textEditingController: TextEditingController(
                            text: userData['identityCard']),
                        hintText: "Identity Card Number",
                        textInputType: TextInputType.number,
                        isRead: true,
                        prefix: 'IC Number: ',
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      // phone number form
                      TextFieldInput(
                        textEditingController: isEdit
                            ? phoneController
                            : TextEditingController(text: userData['phoneNo']),
                        hintText: "Phone Number",
                        textInputType: TextInputType.phone,
                        isRead: isRead,
                        prefix: 'Phone Number: ',
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      // email form
                      TextFieldInput(
                        textEditingController:
                            TextEditingController(text: userData['email']),
                        hintText: "Email Address",
                        textInputType: TextInputType.emailAddress,
                        isRead: true,
                        prefix: 'Email Address: ',
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      // home address form
                      TextFieldInput(
                        textEditingController: isEdit
                            ? homeController
                            : TextEditingController(
                                text: userData['homeAddress']),
                        //  .text = userData['homeAddress'],
                        hintText: "Home Address",
                        textInputType: TextInputType.text,
                        isRead: isRead,
                        prefix: 'Home Address: ',
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      // postcode form
                      TextFieldInput(
                        textEditingController: isEdit
                            ? pCodeController
                            : TextEditingController(text: userData['postcode']),
                        hintText: "Postcode",
                        textInputType: TextInputType.number,
                        isRead: isRead,
                        prefix: 'Postcode: ',
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      // state form
                      isEdit
                          ? DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                hintText: 'State',
                                label: const Text(
                                  'State',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: secondaryColor,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(8),
                                alignLabelWithHint: true,
                                enabledBorder: inputBorder,
                                focusedBorder: inputBorder,
                                filled: true,
                              ),
                              value: state,
                              isExpanded: true,
                              items: stateList.map(buildStateItem).toList(),
                              onChanged: (value) =>
                                  setState(() => state = value),
                            )
                          : TextFieldInput(
                              textEditingController: isEdit
                                  ? stateController
                                  : TextEditingController(
                                      text: userData['state']),
                              hintText: "State",
                              textInputType: TextInputType.text,
                              isRead: isRead,
                              prefix: 'State: ',
                            ),

                      const SizedBox(
                        height: 14,
                      ),

                      // business name form
                      TextFieldInput(
                        textEditingController: isEdit
                            ? bNameController
                            : TextEditingController(
                                text: userData['businessName']),
                        hintText: "Business Name",
                        textInputType: TextInputType.text,
                        isRead: isRead,
                        prefix: 'Business Name: ',
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      isEdit
                          ? DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                hintText: 'Business Type',
                                label: const Text(
                                  'State',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: secondaryColor,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(8),
                                alignLabelWithHint: true,
                                enabledBorder: inputBorder,
                                focusedBorder: inputBorder,
                                filled: true,
                              ),
                              value: bType,
                              isExpanded: true,
                              items: businessType.map(buildMenuItem).toList(),
                              onChanged: (value) =>
                                  setState(() => bType = value),
                            )
                          : TextFieldInput(
                              textEditingController: isEdit
                                  ? bTypeController
                                  : TextEditingController(
                                      text: userData['businessType']),
                              hintText: "Business Type",
                              textInputType: TextInputType.text,
                              isRead: isRead,
                              prefix: 'Business Type: ',
                            ),

                      const SizedBox(
                        height: 14,
                      ),

                      // salary form
                      TextFieldInput(
                        textEditingController: isEdit
                            ? salaryController
                            : TextEditingController(text: (userData['salary'])),
                        hintText: "Average Monthly Income (MYR)",
                        prefix: 'Average Monthly Income: RM ',
                        textInputType: TextInputType.number,
                        isRead: isRead,
                        label: 'Average Monthly Income',
                      ),

                      // const SizedBox(
                      //   height: 14,
                      // ),

                      // // password form
                      // TextFieldInput(
                      //   textEditingController:
                      //       TextEditingController(text: userData['password']),
                      //   hintText: "Enter your Password",
                      //   textInputType: TextInputType.text,
                      //   isPass: true,
                      //   isRead: true,
                      // ),

                      // const SizedBox(
                      //   height: 14,
                      // ),

                      // // confirm password form
                      // TextFieldInput(
                      //   textEditingController: TextEditingController(
                      //       text: userData['confirmPassword']),
                      //   hintText: "Confirm Password",
                      //   textInputType: TextInputType.text,
                      //   isPass: true,
                      //   isRead: true,
                      // ),

                      const SizedBox(
                        height: 16,
                      ),

                      // register button
                      InkWell(
                        onTap: isEdit ? onSave : editMode,
                        child: Container(
                          child: isEdit
                              ? const Text(
                                  "Save",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                )
                              // Center(
                              //     child: CircularProgressIndicator(
                              //       color: primaryColor,
                              //     ),
                              //   )
                              : const Text(
                                  "Edit Profile",
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

                      if (isEdit)
                        const SizedBox(
                          height: 16,
                        ),

                      if (isEdit)
                        InkWell(
                          onTap: cancelEdit,
                          child: Container(
                            child: const Text(
                              "Cancel",
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
                              color: fireColor,
                            ),
                          ),
                        ),
                      // register, forgot password button

                      const SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
