import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'ChangePasswordScreen.dart';
import 'ChangeUserNameScreen.dart';
import 'ResetPin_Pin.dart';
import 'UpdateUserNamePin.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = 'SettingScreen';
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Widget buildOption(BuildContext context, IconData icon, String optionName,
      String routename) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      onTap: () {
        Navigator.of(context).pushNamed(routename);
      },
      tileColor: Colors.grey.shade300,
      leading: CircleAvatar(
        radius: 25,
        child: Icon(
          icon,
          size: 30,
        ),
      ),
      title: Text(optionName),
    );
  }

  bool _biometricOption = Hive.box('userinfo').getAt(3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          'Setting',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        child: Column(
          children: [
            buildOption(
              context,
              Icons.person,
              'Update UserName',
              // ChangeuserNameScreen.routeName,
              UpdateUserNamePin.routeName,
            ),
            const SizedBox(
              height: 10,
            ),
            buildOption(
              context,
              Icons.lock,
              'Reset Password',
              ResetPin_Pin.routeName,
            ),
            const SizedBox(
              height: 10,
            ),
            if (Hive.box('userinfo').getAt(2))
              SwitchListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                secondary: const CircleAvatar(
                  radius: 25,
                  child: Icon(
                    Icons.fingerprint,
                    size: 30,
                  ),
                ),
                title: const Text("Biometric"),
                tileColor: Colors.grey.shade300,
                value: _biometricOption,
                activeColor: Colors.grey.shade900,
                onChanged: (value) {
                  setState(
                    () {
                      _biometricOption = value;
                      Hive.box('userinfo').putAt(3, _biometricOption);
                    },
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}
