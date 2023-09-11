import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'EnterPasswordScreen.dart';

class CreatingUserScreen extends StatefulWidget {
  static const routeName = 'CreatingUserScreen';
  const CreatingUserScreen({super.key});

  @override
  State<CreatingUserScreen> createState() => _CreatingUserScreenState();
}

class _CreatingUserScreenState extends State<CreatingUserScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 4),
      () {
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
                'assets/accountcreated.json',
                repeat: false,
              ),
            ),
            Text(
              'Account Created',
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
