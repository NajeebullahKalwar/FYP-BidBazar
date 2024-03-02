import 'package:flutter/material.dart';


class BidbazarTheme{
  BidbazarTheme._();//private constructor not in used

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.black26,
    
    textTheme:  TextTheme(
          // bodyMedium: ,
          bodyLarge: TextStyle(fontSize: 14,color:Colors.black87),
          bodyMedium: TextStyle().copyWith(fontSize: 14,color:Colors.black87),
          bodySmall: TextStyle().copyWith(fontSize: 12,color:Colors.black87),
          headlineLarge: TextStyle().copyWith(fontSize: 20,color:Colors.black87 , fontWeight:FontWeight.w500 ),
          headlineMedium: TextStyle().copyWith(fontSize: 18,color:Colors.black87),
          headlineSmall: TextStyle().copyWith(fontSize: 16,color:Colors.black87),
     
        ),
    scaffoldBackgroundColor: Colors.white,//background colors
    
    pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),

  );
  
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme:  TextTheme(
          bodyLarge: TextStyle(fontSize: 16,color:Colors.white),
          bodyMedium: TextStyle().copyWith(fontSize: 14,color:Colors.white),
          bodySmall: TextStyle().copyWith(fontSize: 12,color:Colors.white),
          headlineLarge: TextStyle().copyWith(fontSize: 20,color:Colors.white , fontWeight:FontWeight.w500 ),
          headlineMedium: TextStyle().copyWith(fontSize: 18,color:Colors.white),
          headlineSmall: TextStyle().copyWith(fontSize: 16,color:Colors.white),
     
        ),
    primaryColor: Colors.white,
    
    scaffoldBackgroundColor: Colors.black12,
    pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
  );



}