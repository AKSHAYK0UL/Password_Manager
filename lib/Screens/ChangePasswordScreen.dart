import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

import 'PasswordUpdatingScreen.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = 'ChangePasswordScreen';
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _eyeCurrent = true;
  bool _eyeNew = true;
  String? _oldPassword;
  String? _newPassword;
  final _formKey = GlobalKey<FormState>();
  void saveANDcheck() {
    _formKey.currentState!.save();
    final Valid = _formKey.currentState!.validate();
    if (Valid) {
      Hive.box('userinfo').put(0, _newPassword);
      _formKey.currentState!.reset();
      Navigator.of(context)
          .pushReplacementNamed(PasswordUpdatingScreen.routeName);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          'Change Password',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  height: 180,
                  child: Lottie.asset(
                    'assets/changepasswords.json',
                  ),
                ),
                Card(
                  color: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (Hive.box('userinfo').getAt(0) != _oldPassword) {
                        return 'Incorrect password';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _oldPassword = newValue;
                    },
                    obscureText: _eyeCurrent,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _eyeCurrent = !_eyeCurrent;
                          });
                        },
                        icon: Icon(
                          _eyeCurrent ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black,
                        ),
                      ),
                      labelText: 'Current Password',
                      labelStyle: const TextStyle(color: Colors.black),
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
                        borderSide:
                            const BorderSide(width: 2, color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(width: 2, color: Colors.red),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
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
                      if (_newPassword!.isEmpty || _newPassword!.length < 6) {
                        return 'Password is too short';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _newPassword = newValue;
                    },
                    obscureText: _eyeNew,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _eyeNew = !_eyeNew;
                          });
                        },
                        icon: Icon(
                          _eyeNew ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black,
                        ),
                      ),
                      labelText: 'New Password',
                      labelStyle: const TextStyle(color: Colors.black),
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
                        borderSide:
                            const BorderSide(width: 2, color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(width: 2, color: Colors.red),
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () {
                      saveANDcheck();
                    },
                    icon: const Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Update',
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
