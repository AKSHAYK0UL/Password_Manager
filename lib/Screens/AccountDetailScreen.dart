import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:password_manager/Models/AccountModel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../Widgets/AccountIfoWidget.dart';
import 'AddNewAccountScreen.dart';

class AccountDetailScreen extends StatelessWidget {
  static const routeName = 'AccountDetailScreen';
  const AccountDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountID = ModalRoute.of(context)!.settings.arguments as String?;
    final AccountDetailOBJECT =
        Provider.of<Datalist>(context).findById(accountID!);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        title: Text(
          'Account Detail',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddNewAccountScreen.routeName,
                  arguments: accountID);
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.27,
              child: Lottie.asset(
                'assets/secure.json',
                repeat: false,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
              child: Text(
                'Your Account Is Secure',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            AccountInfoWidget(
              'Last updated on',
              DateFormat('dd MMM yyyy hh:mm a')
                  .format(AccountDetailOBJECT.lastUpdatedDate),
              Icons.alarm_on_outlined,
            ),
            AccountInfoWidget(
                'App Name', AccountDetailOBJECT.appName, Icons.apps_outlined),
            AccountInfoWidget(
                'UserName', AccountDetailOBJECT.userName, Icons.person_outline),
            AccountInfoWidget(
                'E-mail', AccountDetailOBJECT.email, Icons.email_outlined),
            AccountInfoWidget(
                'Password', AccountDetailOBJECT.password, Icons.lock_outline),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
