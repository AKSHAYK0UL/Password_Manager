import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_manager/Screens/EnableBiometric.dart';

import 'CreatingUserScreen.dart';

class CreatePinScreen extends StatefulWidget {
  static const routeName = "CreatePinScreen";
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
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
        child: SizedBox(
          child: InkWell(
            child: TextButton(
              onPressed: num == "x"
                  ? () {
                      setState(
                        () {
                          valid = true;
                          if (inputnum.isNotEmpty) {
                            inputnum =
                                inputnum.substring(0, inputnum.length - 1);
                          }
                        },
                      );
                    }
                  : num == "y"
                      ? () {
                          setState(
                            () {
                              if (inputnum.length == 4) {
                                final _hivebox = Hive.box('userinfo');
                                _hivebox.put(2, _isFingerPrintSupported);

                                _hivebox.put(0, inputnum);
                                if (_isFingerPrintSupported) {
                                  Navigator.of(context)
                                      .pushNamed(EnableBiometric.routeName);
                                } else {
                                  Navigator.of(context).pushReplacementNamed(
                                      CreatingUserScreen.routeName);
                                }
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
      ),
    );
  }

// build Passcode TextField
  Widget buildPinCode(String PinCode) {
    final ScreenSize = MediaQuery.of(context).size;

    return Container(
      // height: 50,
      height: ScreenSize.height * 0.063,
      // width: 50,
      width: ScreenSize.height * 0.063,

      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          PinCode,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

//Keypad Numbers
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
  bool _isFingerPrintSupported = false;
  final auth = LocalAuthentication();
  @override
  void initState() {
    auth.isDeviceSupported().then((value) {
      setState(() {
        _isFingerPrintSupported = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              // height: 40,
              height: ScreenSize.height * 0.050,
            ),
            const Text(
              "Create PIN",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              // height: 200,
              // height: 100,
              height: ScreenSize.height * 0.125,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              children: [
                buildPinCode(inputnum.isNotEmpty ? inputnum[0] : ""),
                buildPinCode(inputnum.length >= 2 ? inputnum[1] : ""),
                buildPinCode(inputnum.length >= 3 ? inputnum[2] : ""),
                buildPinCode(inputnum.length >= 4 ? inputnum[3] : ""),
              ],
            ),
            SizedBox(
              // height: 40,
              height: ScreenSize.height * 0.050,
            ),
            Text(
              !valid ? " Incomplete PIN" : "",
              style: const TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              // height:60,
              height: ScreenSize.height * 0.075,
            ),
            Wrap(
              children: [
                ...numbers.map(
                  (e) => SizedBox(
                    width: ScreenSize.width / 3,
                    height: ScreenSize.height * 0.11,
                    child: SizedBox(child: KeyPad(e)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
