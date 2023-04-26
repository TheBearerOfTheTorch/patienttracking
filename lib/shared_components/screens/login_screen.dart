import 'package:flutter/material.dart';
import 'package:patienttracking/navigation/navigation.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../managers/managers.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  static Page page({LocalKey? key}) {
    return MaterialPage(key: key, child: LoginScreen());
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isLoadingRequired = false;

  @override
  Widget build(BuildContext context) {
    final _fieldStateManager = Provider.of<FieldStateManager>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.height / 23),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _fieldStateManager.emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          Provider.of<FieldStateManager>(context, listen: false)
                              .emailFilled = false;
                          return "Email or phone required";
                        } else {
                          Provider.of<FieldStateManager>(context, listen: false)
                              .emailFilled = true;
                        }
                      },
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF707070), width: .5)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                                color: Color(0xFF707070), width: .5)),
                        hintText: "Email or Phone number",
                        hintStyle: const TextStyle(height: 0.5),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    TextFormField(
                      controller: _fieldStateManager.passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          Provider.of<FieldStateManager>(context, listen: false)
                              .passwordFilled = false;
                          return "Password required";
                        } else {
                          Provider.of<FieldStateManager>(context, listen: false)
                              .passwordFilled = true;
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF707070), width: .5)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                                color: Color(0xFF707070), width: .5)),
                        hintText: "Password",
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 40),
                    SizedBox(
                      height: 40,
                      child: MaterialButton(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            //start loading spinner
                            setState(() {
                              isLoadingRequired = true;
                            });
                            //log in and get error
                            var errorValue =
                                await appStateManager.signInWithEmail(
                                    email:
                                        _fieldStateManager.emailController.text,
                                    password: _fieldStateManager
                                        .passwordController.text);

                            //check error
                            if (errorValue != null) {
                              //printing out the error
                              print('errorValue');
                            } else {
                              //updating loggin state
                              appStateManager.loggedIn();
                            }
                            setState(() {
                              isLoadingRequired = false;
                            });
                          }
                        },
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(color: Colors.blue),
                        )),
                    _keyboardIsVisible(context)
                        ? const Text("")
                        : TextButton(
                            onPressed: () {
                              GoRouter.of(context).go(Routes.register.path);
                            },
                            child: const Text(
                              "Create a new account",
                              style: TextStyle(color: Colors.green),
                            )),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  //building text form field
  Widget buildTextfield(String hintText, BuildContext context,
      {required bool obscure}) {
    return TextFormField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(height: 0.5),
      ),
    );
  }

  bool _keyboardIsVisible(context) {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }
}
