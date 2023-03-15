import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../managers/managers.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  bool isLoadingRequired = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AppStateManager>(context);
    final field = Provider.of<FieldStateManager>(context);

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
                    customTextField(context,
                        hintText: " First name",
                        obscureText: false,
                        controller: field.regFirstnameController,
                        validation: "Firstname is required"),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    customTextField(context,
                        hintText: " Last name",
                        obscureText: false,
                        controller: field.regFirstnameController,
                        validation: "Firstname is required"),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    customTextField(context,
                        hintText: " Email or Phone number",
                        obscureText: false,
                        controller: field.regMobileNumberController,
                        validation: "Email or phone required"),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    customTextField(context,
                        hintText: "Password",
                        obscureText: true,
                        controller: field.regPasswordController,
                        validation: "password missing"),
                    SizedBox(
                      height: 40,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            //laoding spinner to true
                            isLoadingRequired = true;

                            var errorValue = await auth.signUpWithEmail(
                              firstname: field.regFirstnameController.text,
                              lastname: field.regLastnameController.text,
                              emailOrPhone:
                                  field.regMobileNumberController.text,
                              role: "user",
                              password: field.regPasswordController.text,
                            );

                            //checking if theres an error
                            if (errorValue != null) {}

                            isLoadingRequired = false;
                          }
                        },
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot password?",
                        )),
                    TextButton(
                        onPressed: () {},
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
  Widget customTextField(context,
      {controller, fieldState, hintText, obscureText, validation}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey.shade100,
      ),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return validation;
            // || !RegExp(r'^[a-z A-Z]+$').hasMatch(value) ||
            // !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
            //     .hasMatch(value)
            // || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)
          } else {
            return null;
          }
        },
        // obscureText: obscureText,
        decoration: InputDecoration(
          label: Text(hintText),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF707070), width: .5)),
          focusColor: Colors.grey,
          floatingLabelBehavior: FloatingLabelBehavior.values.first,
          fillColor: Colors.grey,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:
                  const BorderSide(color: Color(0xFF707070), width: .5)),
          hintText: hintText,
        ),
      ),
    );
  }
}
