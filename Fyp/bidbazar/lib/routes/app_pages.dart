import 'package:bidbazar/Views/Login.dart';
import 'package:bidbazar/Views/Signup.dart';
import 'package:bidbazar/Views/admin_home.dart';
import 'package:bidbazar/Views/buyer_home.dart';
import 'package:bidbazar/Views/seller_home.dart';
import 'package:bidbazar/Views/splash.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/routes/app_routesnames.dart';
import 'package:bidbazar/widgets/addproduct.dart';
import 'package:bidbazar/widgets/product_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => loginScreen(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => signUp(),
    ),
    GetPage(
      name: AppRoutes.admin,
      page: () => Admin(),
    ),
    GetPage(
      name: AppRoutes.buyer,
      page: () => Buyer(),
    ),
    GetPage(
      name: AppRoutes.seller,
      page: () => Seller(),
    ),
    GetPage(
      name: AppRoutes.productdetailscreen,
      page: () => ProductDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.addproduct,
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 200),
      page: () => addProduct(),
    ),
  ];
}
