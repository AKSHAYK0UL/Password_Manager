import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_manager/Models/AccountModel.dart';
import 'package:provider/provider.dart';

import '../Widgets/HomeTabWidget.dart';
import '../Widgets/BankAcountHOMEScreen.dart';
import 'SettingScreen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountObject = Provider.of<Datalist>(context);
    print('${AccountObject.showTime}');

    return WillPopScope(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
            title: ListTile(
              horizontalTitleGap: 0,
              contentPadding: const EdgeInsets.all(3),
              title: AccountObject.showTime,
              subtitle: Text(
                Hive.box('userinfo').get(1),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SettingScreen.routeName);
                },
                icon: const Icon(Icons.settings),
              ),
            ],
            bottom: TabBar(
              indicatorPadding: const EdgeInsets.all(5),
              labelPadding: const EdgeInsets.all(2),
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.blue,
              splashBorderRadius: BorderRadius.circular(5),
              tabs: const [
                Tab(
                  icon: Icon(Icons.apps),
                  text: 'Apps',
                ),
                Tab(
                  icon: Icon(Icons.account_balance),
                  text: 'Bank',
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              HomeTabWidget(),
              BankAcountHOMEScreen(),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
    );
  }
}
