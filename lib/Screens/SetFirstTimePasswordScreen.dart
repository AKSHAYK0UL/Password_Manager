import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

import 'CreatingUserScreen.dart';

class SetFirstTimePasswordScreen extends StatefulWidget {
  static const routeName = 'SetFirstTimePasswordScreen';
  SetFirstTimePasswordScreen({super.key});

  @override
  State<SetFirstTimePasswordScreen> createState() =>
      _SetFirstTimePasswordScreenState();
}

class _SetFirstTimePasswordScreenState
    extends State<SetFirstTimePasswordScreen> {
  final _formkey = GlobalKey<FormState>();
  String? _name;
  String? _password;
  bool _eye = true;
  void _createAccount() {
    _formkey.currentState!.save();
    final valid = _formkey.currentState!.validate();
    if (valid) {
      final _hivebox = Hive.box('userinfo');
      _hivebox.put(0, _password);
      _hivebox.put(1, _name);
      Navigator.of(context).pushReplacementNamed(CreatingUserScreen.routeName);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 35),
                  height: 200,
                  child: LottieBuilder.asset(
                    'assets/userprofile.json',
                    repeat: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Card(
                  color: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (_name!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Your Name',
                      labelStyle: const TextStyle(color: Colors.black),
                      prefixIcon: const Icon(
                        Icons.person,
                        size: 26,
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(width: 2, color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(width: 2, color: Colors.black),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.red,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(width: 2, color: Colors.red),
                      ),
                    ),
                    onSaved: (newValue) {
                      _name = newValue;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Card(
                  color: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (_password!.length < 6) {
                        return 'Password is too short';
                      }
                      return null;
                    },
                    obscureText: _eye,
                    decoration: InputDecoration(
                      labelText: 'Create Password',
                      labelStyle: const TextStyle(color: Colors.black),
                      prefixIcon: const Icon(
                        Icons.lock,
                        size: 26,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(
                            () {
                              _eye = !_eye;
                            },
                          );
                        },
                        icon: Icon(
                          _eye ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(width: 2, color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(width: 2, color: Colors.black),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.red,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(width: 2, color: Colors.red),
                      ),
                    ),
                    onSaved: (newValue) {
                      _password = newValue;
                    },
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
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
          ),
        ),
      ),
    );
  }
}
