import 'package:flutter/material.dart';

import '../Screens/AddNewAccountScreen.dart';
import 'AccountListWidget.dart';

class HomeTabWidget extends StatelessWidget {
  const HomeTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const AccountListWidget(),
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
            Navigator.of(context).pushNamed(AddNewAccountScreen.routeName);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
