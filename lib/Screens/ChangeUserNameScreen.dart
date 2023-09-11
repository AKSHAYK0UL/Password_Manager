import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

import 'UserNameUpdatingScreen.dart';

class ChangeuserNameScreen extends StatefulWidget {
  static const routeName = 'ChangeuserNameScreen';
  const ChangeuserNameScreen({super.key});

  @override
  State<ChangeuserNameScreen> createState() => _ChangeuserNameScreenState();
}

class _ChangeuserNameScreenState extends State<ChangeuserNameScreen> {
  bool _eyeCurrent = true;
  String? _password;
  String? _username;

  final _formKey = GlobalKey<FormState>();
  void saveANDcheck() {
    _formKey.currentState!.save();
    final Valid = _formKey.currentState!.validate();
    if (Valid) {
      Hive.box('userinfo').put(1, _username);
      _formKey.currentState!.reset();
      Navigator.of(context)
          .pushReplacementNamed(UserNameUpdatingScreen.routeName);
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
          'Update Username',
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
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  height: 150,
                  child: Lottie.asset(
                    'assets/username.json',
                    repeat: false,
                  ),
                ),
                Card(
                  color: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (Hive.box('userinfo').getAt(0) != _password) {
                        return 'Incorrect password';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _password = newValue;
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
                      labelText: 'Password',
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
                      if (_username!.isEmpty) {
                        return 'Please enter the Username';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _username = newValue;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 27,
                      ),
                      labelText: 'New Username',
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
                      Icons.person,
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
