import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tree_app/resources/auth_methods.dart';
import 'package:tree_app/screens/register.dart';
import 'package:tree_app/screens/session.dart';
import 'package:tree_app/screens/success.dart';
import 'package:tree_app/utils/colors.dart';
import 'package:tree_app/utils/utils.dart';
import 'package:tree_app/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
        email: _emailController.text, pass: _passwordController.text);

    if (res == 'success') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const SessionScreen(
              success: SScreen(),
            ),
          ),
          (route) => false);

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  void navToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // flex: 2 spacing
              Flexible(
                child: Container(),
                flex: 2,
              ),

              // logo
              Container(
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  //color: mobileSearchColor,
                ),
                child: SvgPicture.asset(
                  'assets/images/treelogonobg.svg',
                  height: 148,
                ),
              ),

              const SizedBox(
                height: 64,
              ),

              // email form
              TextFieldInput(
                textEditingController: _emailController,
                hintText: "Email",
                textInputType: TextInputType.emailAddress,
                label: 'Email',
              ),

              const SizedBox(
                height: 14,
              ),

              // password form
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "Password",
                textInputType: TextInputType.text,
                isPass: true,
                label: 'Password',
              ),

              const SizedBox(
                height: 16,
              ),

              // login button
              InkWell(
                onTap: loginUser,
                child: Container(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
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

              // flex: 2 spacing
              Flexible(
                child: Container(),
                flex: 2,
              ),
              // register, forgot password button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an account? "),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                  GestureDetector(
                    onTap: navToRegister,
                    child: Container(
                      child: const Text(
                        "Register",
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
              const SizedBox(
                height: 36,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
