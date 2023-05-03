import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Tabs {
  static const int home = 0;
  static const int doctors = 1;
  static const int history = 2;
  static const int appointments = 3;
}

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;
  bool _loggedIn = false;
  bool _darkmode = false;
  int _selectedTab = Tabs.home;

  ///
  ///getters
  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get darkmode => _darkmode;
  int get selectedTab => _selectedTab;

  ///
  ///setters
  void initializeApp() {
    _initialized = true;
    notifyListeners();
  }

  void loggedIn() {
    _loggedIn = true;
    notifyListeners();
  }

  void darkMode() {
    _darkmode = true;
    notifyListeners();
  }

  void goToTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  void silentlySetTab(index) {
    _selectedTab = index;
  }

  //firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //
  bool _registerWithEmail = false;
  bool _emailVerified = false;
  final bool _authLoading = false;
  final bool _loggedWithEmail = false;

  bool get registerWithEmail => _registerWithEmail;
  bool get emailVerified => _emailVerified;
  bool get loggedInWithEmail => _loggedWithEmail;

  //sign up email
  set withEmail(value) {
    _registerWithEmail = value;
    notifyListeners();
  }

  //email verified
  set isEmailVerified(value) {
    _emailVerified = value;
    notifyListeners();
  }

  //updating appointment
  Future updateAppointment({
    required bool appointmentUpdate,
    required String userId,
    required String appointmentId,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('appointment')
          .doc(appointmentId)
          .update({
        'updatedTime': 'not updated',
        'updatedDate': 'not updated',
        'appointmentUpdate': appointmentUpdate,
        'notification': true,
      });
    } catch (e) {}
  }

  Future makeAppointment({doctorName, time, date, meetFor, patientName}) async {
    //user
    final User? user = FirebaseAuth.instance.currentUser;
    //int notificaiton =+ 1;

    try {
      await _firestore
          .collection('users')
          .doc(user!.uid)
          .collection('appointment')
          .add({
        'doctorName': doctorName,
        'time': time,
        'date': date,
        'meetingFor': meetFor,
        'notification': false,
        'updatedTime': '',
        'updatedDate': '',
        'appointmentUpdate': '',
      }).then((value) {
        final docId = value.id;
        _firestore.collection('appointment').add({
          'patientName': patientName,
          'time': time,
          'date': date,
          'meetingFor': meetFor,
          'appointmentId': docId,
          'patientId': user.uid,
          'diagnosis': '',
          'updatedTime': '',
          'updatedDate': '',
          'appointmentUpdate': '',
          'notification': true
        });
      });
    } catch (e) {}
  }

  //email and password sign up
  Future signUpWithEmail(
      {required firstname,
      required lastname,
      required role,
      required emailOrPhone,
      required password}) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: emailOrPhone, password: password)
          .then((value) {
        //user
        final User? user = value.user;

        //saving to firestore collection
        if (user != null) {
          _firestore.collection('/users').doc(user.uid).set({
            'firstname': firstname,
            'lastname': lastname,
            'email': emailOrPhone,
            'password': password,
            'userRole': role,
          }).whenComplete(() {
            //check if the email is verified
            user.sendEmailVerification();
            _firestore
                .collection('users')
                .doc(user.uid)
                .collection('profile')
                .doc(user.uid)
                .set({
              'name': '$firstname $lastname',
              'profession': '',
              'hospital': '',
              'doctorId': user.uid
            });
          });
        } else {
          print("theres no  users created");
        }
      });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case 'invalid-email':
          return e.message;
        case 'email-already-in-use':
          return e.message;
        case 'weak-password':
          return e.message;
        case 'network-request-failed':
          return "You lost wifi connections";
        default:
          return 'Unknown error occurred';
      }
    }
    notifyListeners();
  }

  //login user
  Future signInWithEmail({email, password}) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        User? user = value.user;

        //check if the email is verified
        if (!user!.emailVerified) {
          user.sendEmailVerification();
        }
      });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case 'user-not-found':
          return "There's no user with that email address";
        case 'invalid-email':
          return e.message;
        case 'network-request-failed':
          return "You lost wifi connections";
        case 'wrong-password':
          return "The password is incorrect";
        default:
          return 'Unknown error occurred';
      }
    }
    notifyListeners();
  }

  Future logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // final snackBar = SnackBar(content: Text(e.toString()));
      // ScaffoldMessenger.of(context!).showSnackBar(snackBar);
    }
    notifyListeners();
  }

  Future resetPassword(email) async {
    await _auth.sendPasswordResetEmail(email: email);
    notifyListeners();
  }

  Stream<User?> get user => _auth.authStateChanges().map((event) => event);
}

final appStateManager = AppStateManager();
