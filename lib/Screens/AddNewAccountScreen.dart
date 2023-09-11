import 'package:flutter/material.dart';

import '../Widgets/InputWidget.dart';

class AddNewAccountScreen extends StatelessWidget {
  static const routeName = 'AddNewAccountScreen';
  const AddNewAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountID = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          accountID == null ? 'Add Account' : 'Edit Account',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: InputWidget(),
    );
  }
}
