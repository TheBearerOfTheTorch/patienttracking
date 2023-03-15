import 'package:flutter/material.dart';

class FieldStateManager extends ChangeNotifier {
  //register fields controllers
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();

  ///image manager
  var imageValue;

  //login field controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //register check fields
  final bool _isEmailFilled = false;
  final bool _isPasswordFilled = false;
  final bool _isFirstnameFilled = false;
  final bool _isLastnameFilled = false;
  final bool _isMobileNumberFilled = false;
  bool _isMaleGenderChecked = false;
  bool _isFemaleGenderChecked = false;
  bool _isOtherGenderChecked = false;
  bool _isDateOfBirthFilled = false;
  bool _isGenderNull = false;

  //login check fields
  bool _isEmailLoginFilled = false;
  bool _isPasswordLoginFilled = false;

  //register get check fields
  bool get isEmailRegisterFilled => _isEmailFilled;
  bool get isPasswordRegisterFilled => _isPasswordFilled;
  bool get isFirstnameRegisterFilled => _isFirstnameFilled;
  bool get isLastnameRegisterField => _isLastnameFilled;
  bool get isMobileNumberRegisterFilled => _isMobileNumberFilled;
  bool get isGenderRegisterMaleFilled => _isMaleGenderChecked;
  bool get isGenderRegisterFemaleFilled => _isFemaleGenderChecked;
  bool get isGenderRegisterOtherFilled => _isOtherGenderChecked;
  bool get isDateOfBirthRegisterNotFilled => _isDateOfBirthFilled;

  //login get check fields
  bool get isEmailLoginFilled => _isEmailLoginFilled;
  bool get isPasswordLoginFilled => _isPasswordLoginFilled;

  //register get controllers
  TextEditingController get regEmailController => _email;
  TextEditingController get regPasswordController => _password;
  TextEditingController get regFirstnameController => _firstname;
  TextEditingController get regLastnameController => _lastname;
  TextEditingController get regMobileNumberController => _mobileNumber;

  //login get controllers
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  //birthday setters
  set setIsGenderNull(value) {
    _isGenderNull = value;
    notifyListeners();
  }

  set setIfDtateOfBirthIsNotFilled(value) {
    _isDateOfBirthFilled = value;
    notifyListeners();
  }

  set isMaleChecked(value) {
    _isMaleGenderChecked = value;
    notifyListeners();
  }

  set isFemaleChecked(value) {
    _isFemaleGenderChecked = value;
    notifyListeners();
  }

  set isOtherChecked(value) {
    _isOtherGenderChecked = value;
    notifyListeners();
  }

  //login set function
  set emailFilled(email) {
    _isEmailLoginFilled = email;
    notifyListeners();
  }

  set passwordFilled(password) {
    _isPasswordLoginFilled = password;
    notifyListeners();
  }
}
