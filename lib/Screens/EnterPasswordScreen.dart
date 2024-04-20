import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:password_manager/Screens/HomeScreen.dart';

class EnterPasswordScreen extends StatefulWidget {
  static const routeName = 'EnterPasswordScreen';
  const EnterPasswordScreen({super.key});

  @override
  State<EnterPasswordScreen> createState() => _EnterPasswordScreenState();
}

class _EnterPasswordScreenState extends State<EnterPasswordScreen> {
  final _checkPasswordController = TextEditingController();
  bool isSupported = Hive.box('userinfo').getAt(2);
  bool _eye = true;
  bool _password = true;
  final auth = LocalAuthentication();

  Future<bool> BiometricAuth() async {
    if (!isSupported) {
      return false;
    }
    try {
      return await auth.authenticate(
          localizedReason: "Tap to unlock",
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
            biometricOnly: true,
          ));
    } on PlatformException catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: media.height * 0.07,
              ),
              SizedBox(
                height: media.height * 0.27,
                child: LottieBuilder.asset('assets/enterpassword.json'),
              ),
              Text(
                "Enter Password",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 1,
                color: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  obscureText: _eye,
                  decoration: InputDecoration(
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
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  controller: _checkPasswordController,
                  onChanged: (value) => setState(
                    () {
                      _password = true;
                    },
                  ),
                ),
              ),
              _password == false
                  ? const Text(
                      "Incorrect password",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    )
                  : const Text(''),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () {
                    if (Hive.box('userinfo').getAt(0) !=
                        _checkPasswordController.text) {
                      setState(
                        () {
                          _password = false;
                        },
                      );
                    }
                    if (Hive.box('userinfo').getAt(0) ==
                        _checkPasswordController.text) {
                      Navigator.of(context)
                          .pushReplacementNamed(HomeScreen.routeName);
                    }
                  },
                  icon: const Icon(Icons.skip_next_rounded),
                  label: Text(
                    "Next",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  style: TextButton.styleFrom(
                    iconColor: Colors.black,
                    backgroundColor: Colors.yellow,
                  ),
                ),
              ),
              SizedBox(
                height: media.height * 0.20,
              ),
              if (Hive.box('userinfo').getAt(3) &&
                  Hive.box('userinfo').getAt(2))
                Center(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () async {
                      final authvalue = await BiometricAuth();
                      if (authvalue) {
                        Navigator.of(context)
                            .pushReplacementNamed(HomeScreen.routeName);
                      }
                    },
                    child: const Icon(
                      Icons.fingerprint,
                      size: 70,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
