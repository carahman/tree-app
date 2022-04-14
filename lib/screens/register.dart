import 'package:flutter/material.dart';
import 'package:tree_app/resources/auth_methods.dart';
import 'package:tree_app/screens/login.dart';
import 'package:tree_app/utils/colors.dart';
import 'package:tree_app/utils/utils.dart';
import 'package:tree_app/widgets/text_field_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _cPassController = TextEditingController();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _homeController = TextEditingController();
  final TextEditingController _pCodeController = TextEditingController();
  final TextEditingController _bNameController = TextEditingController();
  final TextEditingController _bTypeController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _icController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _cPassController.dispose();
    _fNameController.dispose();
    _lNameController.dispose();
    _phoneController.dispose();
    _homeController.dispose();
    _pCodeController.dispose();
    _bNameController.dispose();
    _bTypeController.dispose();
    _salaryController.dispose();
    _stateController.dispose();
    _icController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      pass: _passController.text,
      cPass: _cPassController.text,
      fName: _fNameController.text,
      lName: _lNameController.text,
      phone: _phoneController.text,
      home: _homeController.text,
      pCode: _pCodeController.text,
      bName: _bNameController.text,
      bType: bType.toString(),
      salary: _salaryController.text,
      state: state.toString(),
      ic: _icController.text,
    );

    if (res == 'success') {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });

      showSnackBar(context, res);
    }
  }

  void navToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
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

  DropdownMenuItem<String> buildBtypeItem(String bType) => DropdownMenuItem(
      value: bType,
      child: Text(
        bType,
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 32,
                ),

                const Text(
                  "Registration Form",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),

                const SizedBox(
                  height: 32,
                ),

                // first name form
                TextFieldInput(
                  textEditingController: _fNameController,
                  hintText: "First Name",
                  textInputType: TextInputType.text,
                ),

                const SizedBox(
                  height: 14,
                ),

                // last name form
                TextFieldInput(
                  textEditingController: _lNameController,
                  hintText: "Last Name",
                  textInputType: TextInputType.text,
                ),

                const SizedBox(
                  height: 14,
                ),

                // ic number form
                TextFieldInput(
                  textEditingController: _icController,
                  hintText: "Identity Card Number",
                  textInputType: TextInputType.number,
                ),

                const SizedBox(
                  height: 14,
                ),

                // phone number form
                TextFieldInput(
                  textEditingController: _phoneController,
                  hintText: "Phone Number",
                  textInputType: TextInputType.phone,
                ),

                const SizedBox(
                  height: 14,
                ),

                // email form
                TextFieldInput(
                  textEditingController: _emailController,
                  hintText: "Email Address",
                  textInputType: TextInputType.emailAddress,
                ),

                const SizedBox(
                  height: 14,
                ),

                // home address form
                TextFieldInput(
                  textEditingController: _homeController,
                  hintText: "Home Address",
                  textInputType: TextInputType.text,
                ),

                const SizedBox(
                  height: 14,
                ),

                // postcode form
                TextFieldInput(
                  textEditingController: _pCodeController,
                  hintText: "Postcode",
                  textInputType: TextInputType.number,
                ),

                const SizedBox(
                  height: 14,
                ),

                // state form
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: 'State',
                    contentPadding: const EdgeInsets.all(8),
                    alignLabelWithHint: true,
                    enabledBorder: inputBorder,
                    focusedBorder: inputBorder,
                    filled: true,
                  ),
                  value: state,
                  isExpanded: true,
                  items: stateList.map(buildStateItem).toList(),
                  onChanged: (value) => setState(() => state = value),
                ),

                const SizedBox(
                  height: 14,
                ),

                // business name form
                TextFieldInput(
                  textEditingController: _bNameController,
                  hintText: "Business Name",
                  textInputType: TextInputType.text,
                ),

                const SizedBox(
                  height: 14,
                ),

                // business type
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: 'Business Type',
                    contentPadding: const EdgeInsets.all(8),
                    alignLabelWithHint: true,
                    enabledBorder: inputBorder,
                    focusedBorder: inputBorder,
                    filled: true,
                  ),
                  value: bType,
                  isExpanded: true,
                  items: businessType.map(buildBtypeItem).toList(),
                  onChanged: (value) => setState(() => bType = value),
                ),

                const SizedBox(
                  height: 14,
                ),

                // salary form
                TextFieldInput(
                  textEditingController: _salaryController,
                  hintText: "Average Monthly Income (MYR)",
                  textInputType: TextInputType.number,
                  prefix: 'RM ',
                ),

                const SizedBox(
                  height: 14,
                ),

                // password form
                TextFieldInput(
                  textEditingController: _passController,
                  hintText: "Enter your Password",
                  textInputType: TextInputType.text,
                  isPass: true,
                ),

                const SizedBox(
                  height: 14,
                ),

                // confirm password form
                TextFieldInput(
                  textEditingController: _cPassController,
                  hintText: "Confirm Password",
                  textInputType: TextInputType.text,
                  isPass: true,
                ),

                const SizedBox(
                  height: 16,
                ),

                // register button
                InkWell(
                  onTap: signUpUser,
                  child: Container(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text(
                            "Register",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text("Already have an account? "),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                    GestureDetector(
                      onTap: navToLogin,
                      child: Container(
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ),
                // register, forgot password button

                const SizedBox(
                  height: 36,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
