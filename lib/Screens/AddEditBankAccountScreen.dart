import 'package:flutter/material.dart';

import '../Widgets/BankInputWidget.dart';

class AddEditBankAccountScreen extends StatelessWidget {
  static const routeName = 'AddEditBankAccountScreen';
  const AddEditBankAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accId = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(accId == null ? 'Add Account' : 'Edit Account'),
      ),
      body: const BankInputWidget(),
    );
  }
}
