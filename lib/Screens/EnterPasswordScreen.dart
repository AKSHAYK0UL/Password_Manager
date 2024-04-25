import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:password_manager/Screens/HomeScreen.dart';
import 'package:password_manager/main.dart';

class EnterPasswordScreen extends StatefulWidget {
  static const routeName = 'EnterPasswordScreen';
  const EnterPasswordScreen({super.key});

  @override
  State<EnterPasswordScreen> createState() => _EnterPasswordScreenState();
}

class _EnterPasswordScreenState extends State<EnterPasswordScreen> {
  // final _checkPasswordController = TextEditingController();
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
                            final _hivebox = Hive.box('userinfo');
                            if (inputnum.length == 4 &&
                                inputnum == _hivebox.getAt(0)) {
                              Navigator.of(context)
                                  .pushReplacementNamed(HomeScreen.routeName);
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
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                // height: 20,
                height: media.height * 0.025,
              ),
              const Text(
                "Enter your PIN",
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
                      size: 65,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
    );
  }
}
