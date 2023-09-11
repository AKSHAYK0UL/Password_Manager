import 'package:flutter/material.dart';

import 'BankAccountListWidget.dart';
import '../Screens/AddEditBankAccountScreen.dart';

class BankAcountHOMEScreen extends StatelessWidget {
  const BankAcountHOMEScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const BankAccountListWidget(),
      floatingActionButton: Container(
        width: 65,
        height: 63,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue.shade400,
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.blue.shade400,
          onPressed: () {
            Navigator.of(context).pushNamed(AddEditBankAccountScreen.routeName);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
