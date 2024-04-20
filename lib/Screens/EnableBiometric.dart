import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';

import 'CreatingUserScreen.dart';

class EnableBiometric extends StatefulWidget {
  static const routeName = "EnableBiometric";
  const EnableBiometric({super.key});

  @override
  State<EnableBiometric> createState() => _EnableBiometricState();
}

class _EnableBiometricState extends State<EnableBiometric> {
  bool _enableFingerPrint = false;

  void _createAccount() {
    final _hivebox = Hive.box('userinfo');
    _hivebox.put(3, _enableFingerPrint);

    Navigator.of(context).pushReplacementNamed(CreatingUserScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 35),
            height: 450,
            width: double.infinity,
            child: Lottie.asset(
              'assets/biometric.json',
              repeat: false,
            ),
          ),
          SwitchListTile(
            secondary: const Icon(
              Icons.fingerprint,
              size: 30,
              color: Colors.black,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            //tileColor: Colors.grey.shade200,
            title: const Text("Biometric"),
            value: _enableFingerPrint,
            activeColor: Colors.grey.shade900,
            onChanged: (value) {
              setState(
                () {
                  _enableFingerPrint = value;
                },
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            width: double.infinity,
            child: TextButton.icon(
              onPressed: () {
                _createAccount();
              },
              icon: const Icon(
                Icons.person,
                color: Colors.black,
                size: 25,
              ),
              label: Text(
                'Create',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.yellow,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
