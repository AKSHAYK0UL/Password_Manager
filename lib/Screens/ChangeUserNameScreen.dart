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
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          'Update UserName',
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
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  // height: 180,
                  height: WidgetsBinding.instance.window.viewInsets.bottom > 0.0
                      ? media.height * 0.155
                      : media.height * 0.250,
                  child: Lottie.asset(
                    'assets/username.json',
                    fit: BoxFit.contain,
                    repeat: false,
                  ),
                ),
                const SizedBox(
                  height: 30,
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
