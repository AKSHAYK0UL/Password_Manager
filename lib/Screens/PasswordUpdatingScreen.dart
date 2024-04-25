import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:password_manager/Screens/EnterPasswordScreen.dart';

class PasswordUpdatingScreen extends StatefulWidget {
  static const routeName = 'PasswordUpdatingScreen';
  const PasswordUpdatingScreen({super.key});

  @override
  State<PasswordUpdatingScreen> createState() => _PasswordUpdatingScreenState();
}

class _PasswordUpdatingScreenState extends State<PasswordUpdatingScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 8),
      () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context)
            .pushReplacementNamed(EnterPasswordScreen.routeName);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                'assets/updatepassword.json',
                repeat: false,
              ),
            ),
            Text(
              'Updating...',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
