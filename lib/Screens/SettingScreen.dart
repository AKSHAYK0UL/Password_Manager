import 'package:flutter/material.dart';

import 'ChangePasswordScreen.dart';
import 'ChangeUserNameScreen.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = 'SettingScreen';
  const SettingScreen({super.key});
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
              ChangeuserNameScreen.routeName,
            ),
            const SizedBox(
              height: 10,
            ),
            buildOption(
              context,
              Icons.lock,
              'Reset Password',
              ChangePasswordScreen.routeName,
            ),
          ],
        ),
      ),
    );
  }
}
