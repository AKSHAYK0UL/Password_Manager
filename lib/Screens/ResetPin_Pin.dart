import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_manager/Screens/ChangePasswordScreen.dart';

class ResetPin_Pin extends StatefulWidget {
  static const routeName = "ResetPin_Pin";
  const ResetPin_Pin({super.key});

  @override
  State<ResetPin_Pin> createState() => _ResetPin_PinState();
}

class _ResetPin_PinState extends State<ResetPin_Pin> {
  bool isSupported = Hive.box('userinfo').getAt(2);
  // bool _eye = true;
  // bool _password = true;
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

  String inputnum = "";
  bool valid = true;
  Widget KeyPad(String num) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
      child: Material(
        clipBehavior: Clip.hardEdge,
        shadowColor: Colors.grey,
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          child: TextButton(
            onPressed: num == "x"
                ? () {
                    setState(
                      () {
                        valid = true;
                        if (inputnum.isNotEmpty) {
                          inputnum = inputnum.substring(0, inputnum.length - 1);
                        }
                      },
                    );
                  }
                : num == "y"
                    ? () {
                        setState(
                          () {
                            final pincode = Hive.box('userinfo').getAt(0);

                            if (inputnum.length == 4 && inputnum == pincode) {
                              Navigator.of(context).pushReplacementNamed(
                                  ChangePasswordScreen.routeName);
                            } else {
                              valid = false;
                            }
                          },
                        );
                      }
                    : () {
                        setState(() {
                          valid = true;
                          if (inputnum.length <= 3) {
                            inputnum = inputnum + num;
                          }
                        });
                      },
            child: num == "x"
                ? Icon(
                    Icons.backspace,
                    color: Colors.red.shade400,
                    size: 25,
                  )
                : num == "y"
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                        size: 25,
                      )
                    : Text(
                        num,
                        style: const TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
          ),
        ),
      ),
    );
  }

  List<String> numbers = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "x",
    "0",
    "y"
  ];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              // height: 20,
              height: media.height * 0.025,
            ),
            const Text(
              "Enter current PIN",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              // height: 80,
              height: media.height * 0.100,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 9,
              children: [
                Icon(
                  inputnum.isNotEmpty ? Icons.circle : Icons.circle_outlined,
                  size: 28,
                ),
                Icon(
                  inputnum.length >= 2 ? Icons.circle : Icons.circle_outlined,
                  size: 28,
                ),
                Icon(
                  inputnum.length >= 3 ? Icons.circle : Icons.circle_outlined,
                  size: 28,
                ),
                Icon(
                  inputnum.length == 4 ? Icons.circle : Icons.circle_outlined,
                  size: 28,
                ),
              ],
            ),
            SizedBox(
              // height: 60,
              height: media.height * 0.075,
            ),
            Text(
              !valid ? "Incorrect PIN" : "",
              style: const TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              // height: 60,
              height: media.height * 0.075,
            ),
            Wrap(
              children: [
                ...numbers.map(
                  (e) => SizedBox(
                    width: media.width / 3,
                    height: media.height * 0.11,
                    child: KeyPad(e),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: media.height * 0.03,
            ),
            if (Hive.box('userinfo').getAt(3) && Hive.box('userinfo').getAt(2))
              Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () async {
                    final authvalue = await BiometricAuth();
                    if (authvalue) {
                      Navigator.of(context)
                          .pushReplacementNamed(ChangePasswordScreen.routeName);
                    }
                  },
                  child: const Icon(
                    Icons.fingerprint,
                    size: 65,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
