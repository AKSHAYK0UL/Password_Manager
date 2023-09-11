import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:password_manager/Models/BankAccountModel.dart';
import 'package:provider/provider.dart';

import '../Widgets/AccountIfoWidget.dart';
import 'AddEditBankAccountScreen.dart';

class BankDetailScreen extends StatelessWidget {
  static const routeName = 'BankDetailScreen';
  const BankDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _bankid = ModalRoute.of(context)!.settings.arguments as String;
    final _BankAccount = Provider.of<BankData>(context).findBYidBank(_bankid);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          'Account Details',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                    AddEditBankAccountScreen.routeName,
                    arguments: _bankid);
              },
              icon: const Icon(Icons.edit))
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
                  .format(_BankAccount.lastUpdatedDate!),
              Icons.alarm_on_outlined,
            ),
            AccountInfoWidget(
              'Bank Name',
              _BankAccount.bankName,
              Icons.account_balance,
            ),
            AccountInfoWidget(
              'Account Type',
              _BankAccount.accountType,
              FontAwesomeIcons.piggyBank,
            ),
            AccountInfoWidget(
              'Branch Name',
              _BankAccount.branchName,
              FontAwesomeIcons.codeBranch,
            ),
            AccountInfoWidget(
              'Account Holder Name',
              _BankAccount.accountHolderName,
              Icons.person,
            ),
            AccountInfoWidget(
              'Bank Account no.',
              _BankAccount.accountNumber.toString(),
              Icons.numbers,
            ),
            AccountInfoWidget(
              'Debit Card no.',
              _BankAccount.cardNumber == 0
                  ? 'Not Provided'
                  : _BankAccount.cardNumber.toString(),
              Icons.add_card_sharp,
            ),
            AccountInfoWidget(
              'IFSC code',
              _BankAccount.ifcCode!.isEmpty
                  ? 'Not Provided'
                  : _BankAccount.ifcCode!,
              Icons.code,
            ),
            AccountInfoWidget(
              'ATM pin',
              _BankAccount.atmPin == 0
                  ? 'Not Provided'
                  : _BankAccount.atmPin.toString(),
              Icons.pin,
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
