import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'EnterPasswordScreen.dart';

class UserNameUpdatingScreen extends StatefulWidget {
  static const routeName = 'UserNameUpdatingScreen';
  const UserNameUpdatingScreen({super.key});

  @override
  State<UserNameUpdatingScreen> createState() => _UserNameUpdatingScreenState();
}

class _UserNameUpdatingScreenState extends State<UserNameUpdatingScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 10),
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
                'assets/updatingusername.json',
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
