import 'package:bidbazar/Views/Login.dart';
import 'package:bidbazar/data/models/cart_model.dart';
import 'package:bidbazar/data/models/category_model.dart';
import 'package:bidbazar/data/models/user_model.dart';
import 'package:bidbazar/data/repo/category_repo.dart';
import 'package:bidbazar/data/repo/user_repo.dart';
import 'package:bidbazar/routes/app_pages.dart';
import 'package:bidbazar/widgets/buttonController.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticateController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();

  Rx<bool> isLoading = false.obs;
  Rx<bool> isObscure = true.obs;
  RxString ErrorMessage = "".obs;

  // late final userModel usermodel;
  UserRepository userRepo = UserRepository();
  // List<userModel>  = [];
  static RxList<userModel> userdata = (List<userModel>.of([])).obs;

  RxInt screenIndex = 0.obs;

  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  ButtonController usertypes = Get.put(ButtonController());

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  void toggleVisibility() {
    // print("siguptype = " + usertypes.getUserName);
    isObscure == true ? isObscure.value = false : isObscure.value = true;
  }

  Future login(String email, String password) async {
    toggleLoading();
    try {
      userModel? user = await userRepo.signIn(email, password);
      if (user == null) {
        toggleLoading();
        Get.snackbar(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          'Error Logging in',
          'Please try again.',
        );
      } else {
        userdata.assign(user);

        routeForBuyerSellerAdmin(user.usertype.toString());
      }
    } catch (e) {
      toggleLoading();

      ErrorMessage.value = e.toString();
    }
  }

  Future routeForBuyerSellerAdmin(String user) async {
    switch (user) {
      case 'Buyer':
        Get.offAndToNamed('buyerScreen');
        break;
      case 'Admin':
        Get.offAndToNamed('adminScreen');
        break;
      case 'Seller':
        Get.offAndToNamed('sellerScreen');
        break;
      default:
        Get.snackbar(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          'Error Logging in',
          'Please check usertype.',
        );
    }
  }

  Future signup(
      {required String name,
      required String email,
      required String password,
      required String phonenum,
      required String address,
      required String cnic}) async {
    toggleLoading();
    try {
      String usertype =
          usertypes.getUserName == null ? 'Buyer' : usertypes.getUserName;
      userModel? user = await userRepo.createAccount(
          name, email, phonenum, cnic, address, password, usertype);
      toggleLoading();
      clearfields();
      Get.offAndToNamed('loginScreen');
    } catch (ex) {
      toggleLoading();
      ErrorMessage.value = ex.toString();
    }
  }

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // void checkLoginStatus() {
  //   final userType = ButtonController().getUserType;

  //   if (userType == null || userType.isEmpty) {
  //     Get.off(loginScreen());
  //   } else {
  //     if (userType == "Seller") {
  //       Get.toNamed('/');
  //       // Get.offAll(const SellerHomeScreen());
  //     } else {
  //       // Get.offAll(const BuyerHomeScreen());
  //     }
  //   }
  // }

  // Future login(String email, String password) async {
  //   toggleLoading();
  //   try {
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     User? user = userCredential.user;

  //     if (user!.emailVerified) {
  //       routeForBuyerSellerAdmin();
  //     } else {
  //       toggleLoading();
  //       Get.snackbar(
  //         margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
  //         'Error Logging in',
  //         'Please verify your email to login.',
  //       );
  //     }
  //     // _userFromFirebaseUser(userCredential.user);
  //     // print("user id =" + _auth.currentUser!.uid.toString());

  //     // routeForBuyerSellerAdmin();
  //   } on FirebaseAuthException catch (e) {
  //     print("user userCredential =" + e.credential.toString());
  //     toggleLoading();
  //     print("e.email " + e.email.toString());

  //     if (e.email == null) {
  //       ErrorMessage.value =
  //           'No user found for that email check your email and password.';
  //     } else {
  //       ErrorMessage.value =
  //           'Check your internet connection. Try again or later';
  //     }

  //     // switch (e.code) {
  //     //   case 'ERROR_INVALID_EMAIL':
  //     //     ErrorMessage.value = 'No user found for that email.';
  //     //     break;
  //     //   case 'ERROR_WRONG_PASSWORD':
  //     //     ErrorMessage.value = 'Wrong password provided for that user.';
  //     //     break;
  //     //   default:
  //     //     ErrorMessage.value =
  //     //         'Check your internet connection. Try again or later';
  //     //     break;
  //     // }
  //   }
  // }

  // void resetPassword(String email) async {
  //   try {
  //     await _auth.sendPasswordResetEmail(email: email);
  //     Get.snackbar(
  //       'Success',
  //       'Password reset email is send successfully.',
  //     );
  //   } catch (err) {
  //     Get.snackbar(
  //       'Error',
  //       err.toString(),
  //     );
  //   }
  // }
  // String getutype() {
  //   // print("siguptype = " + ButtonController().getUserName());
  //   return ButtonController().getUserName();
  // }

  // Future routeForBuyerSellerAdmin() async {
  //   // print("user id =" + _auth.currentUser!.uid.toString());

  //   if (_auth.currentUser != null) {
  //     try {
  //       var kk = await firebaseFirestore
  //           .collection('users')
  //           .doc(_auth.currentUser!.uid.toString())
  //           .get()
  //           .then((DocumentSnapshot documentSnapshot) {
  //         toggleLoading();

  //         if (documentSnapshot.exists) {
  //           if (documentSnapshot.get('role') == "Buyer") {
  //             Get.offAndToNamed('buyerScreen');
  //           } else if (documentSnapshot.get('role') == "Admin") {
  //             Get.offAndToNamed('adminScreen');
  //           } else if (documentSnapshot.get('role') == "Seller") {
  //             Get.offAndToNamed('sellerScreen');
  //           }
  //         } else {
  //           print('Document is not available');
  //         }
  //       });
  //     } on FirebaseAuthException catch (e) {
  //       print("Doc" + e.toString());
  //     }
  //   }
  // }

  // Future signup(
  //     {required String email,
  //     required String password,
  //     required String phonenum,
  //     required String address,
  //     required String cnic}) async {
  //   toggleLoading();
  //   try {
  //     // create email in firebase Auth
  //     UserCredential userCredential =
  //         await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     User? user = userCredential.user;
  //     // String uId = ;
  //     // Create a user document in Cloud Firestore with the assigned role
  //     await firebaseFirestore // save user name and email usertype to firestore
  //         .collection('users')
  //         .doc(_auth.currentUser!.uid.toString())
  //         .set({
  //       'email': email,
  //       'role': usertypes.getUserName == null ? 'Buyer' : usertypes.getUserName,
  //       'address': address,
  //       'cnic': cnic,
  //       'phone': phonenum,
  //     });
  //     await _auth.currentUser!.sendEmailVerification();
  //     Get.snackbar(
  //       "Email verification ",
  //       "Please check your email to verify",
  //       backgroundColor: Colors.amberAccent[900],
  //       colorText: Colors.white,
  //     );
  //     // if (user!.emailVerified) {
  //     //   routeForBuyerSellerAdmin();
  //     // } else {
  //     //   clearfields();

  //     //   toggleLoading();
  //     //   Get.snackbar(
  //     //     'Error Logging in',
  //     //     'Please verify your email to login.',
  //     //   );
  //     // }
  //     // return _userFromFirebaseUser(user);
  //     toggleLoading();
  //     Get.offNamed('loginScreen');
  //   } on FirebaseAuthException catch (e) {
  //     toggleLoading();
  //     // print(e.toString());
  //     // print(e.toString() + "Email is not valid Error creating user");
  //     // print("user userCredential =" + e.credential.toString());

  //     // print("e.email " + e.email.toString());

  //     if (e.email == null) {
  //       ErrorMessage.value =
  //           ' The email address is already in use by another account.';
  //     } else {
  //       ErrorMessage.value =
  //           'Check your internet connection. Try again or later\ne.toString()';
  //     }

  //     return null;
  //   }
  // }

  void clearfields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    addressController.clear();
    cnicController.clear();
  }

  String? validateEmail(String val) {
    if (val.isEmpty) {
      return "Email can not be empty";
    } else if (!RegExp(r"^[\w-\.]+(@gmail)+(\.com)$").hasMatch(val)) {
      return "Email Address is Invalid ";
    } else {
      return null;
    }
  }

  String? validatePhone(String val) {
    if (val.isEmpty) {
      return "Phone number can not be empty";
    } else if (!RegExp(r"^[0-9]{11,13}$").hasMatch(val)) {
      return "Phones number is Invalid ";
    } else
      return null;
  }

  String? validatePassword(String val) {
    print("Password value $val");

    if (val.isEmpty) {
      return "Password can not be empty";
    } else if (!(val.length >= 6)) {
      return "Password must be at least 6 charater";
      // } else if (!RegExp(r"([\w][\d][^\w\d]{1,}){1,}$").hasMatch(val)) {
      // return "Invalid Password Ex: Laksh123#%";
    } else
      return null;
  }
}
