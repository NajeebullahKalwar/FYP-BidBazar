import 'package:flutter/material.dart';

class Admin extends StatelessWidget {
  const Admin({super.key});
  static const String routeName = '/adminScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin screen'),
      ),
      body: Center(
          child: Container(
        child: Text('Admin screen'),
      )),
    );
  }
}
