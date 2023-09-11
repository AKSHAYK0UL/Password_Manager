import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_manager/Screens/SetFirstTimePasswordScreen.dart';
import 'package:provider/provider.dart';
import 'Models/AccountModel.dart';
import 'Models/BankAccountModel.dart';
import 'Screens/AccountDetailScreen.dart';
import 'Screens/AddEditBankAccountScreen.dart';
import 'Screens/AddNewAccountScreen.dart';
import 'Screens/BankDetailScreen.dart';
import 'Screens/ChangePasswordScreen.dart';
import 'Screens/ChangeUserNameScreen.dart';
import 'Screens/CreatingUserScreen.dart';
import 'Screens/EnterPasswordScreen.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/IntroductionScreen.dart';
import 'Screens/PasswordUpdatingScreen.dart';
import 'Screens/SettingScreen.dart';
import 'Screens/UserNameUpdatingScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive
    ..registerAdapter(AccountModelAdapter())
    ..registerAdapter(BankAccountModelAdapter());

  await Hive.openBox('storeaccounts');
  await Hive.openBox('bankdetail');
  await Hive.openBox('userinfo');
  await Hive.openBox('firsttime');
  await Future.delayed(
    const Duration(seconds: 2),
    () {
      FlutterNativeSplash.remove();
    },
  );
  runApp(const Sigma());
}

class Sigma extends StatelessWidget {
  const Sigma({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Datalist(),
        ),
        ChangeNotifierProvider(
          create: (context) => BankData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          canvasColor: Colors.white,
          hintColor: Colors.black54,
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: Colors.black,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              color: Colors.black,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
            titleSmall: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: TextStyle(
              color: Colors.black,
              fontSize: 21,
              fontWeight: FontWeight.normal,
            ),
            bodyMedium: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
            bodySmall: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        home: Hive.box('firsttime').isEmpty
            ? IntroductionScreen()
            : Hive.box('userinfo').isEmpty
                ? SetFirstTimePasswordScreen()
                : EnterPasswordScreen(),
        routes: {
          SetFirstTimePasswordScreen.routeName: (context) =>
              SetFirstTimePasswordScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          AddNewAccountScreen.routeName: (context) =>
              const AddNewAccountScreen(),
          AccountDetailScreen.routeName: (context) =>
              const AccountDetailScreen(),
          EnterPasswordScreen.routeName: (context) => EnterPasswordScreen(),
          SettingScreen.routeName: (context) => const SettingScreen(),
          ChangeuserNameScreen.routeName: (context) =>
              const ChangeuserNameScreen(),
          ChangePasswordScreen.routeName: (context) =>
              const ChangePasswordScreen(),
          CreatingUserScreen.routeName: (context) => const CreatingUserScreen(),
          PasswordUpdatingScreen.routeName: (context) =>
              const PasswordUpdatingScreen(),
          UserNameUpdatingScreen.routeName: (context) =>
              const UserNameUpdatingScreen(),
          AddEditBankAccountScreen.routeName: (context) =>
              const AddEditBankAccountScreen(),
          BankDetailScreen.routeName: (context) => const BankDetailScreen(),
        },
      ),
    );
  }
}
