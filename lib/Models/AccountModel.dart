import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
part 'AccountModel.g.dart';

@HiveType(typeId: 0)
class AccountModel {
  @HiveField(0)
  String appName;
  @HiveField(1)
  String userName;
  @HiveField(2)
  String password;
  @HiveField(3)
  DateTime lastUpdatedDate;
  @HiveField(4)
  String id;
  @HiveField(5)
  String email;
  AccountModel(
      {required this.appName,
      required this.userName,
      required this.password,
      required this.lastUpdatedDate,
      required this.id,
      required this.email});
}

class Datalist with ChangeNotifier {
  //Hive Box
  final Hivebox = Hive.box('storeaccounts');

//Create New Account

  void addnewAccount(
      String appname, String username, String Password, String Email) {
    final _newAcc = AccountModel(
      appName: appname,
      userName: username,
      password: Password,
      email: Email,
      lastUpdatedDate: DateTime.now(),
      id: DateTime.now().toString(),
    );

    // userlist.add(_newAcc);
    Hivebox.add(_newAcc);
    notifyListeners();
  }

//Edit Account

  void editAccount(String ID, String appname, String username, String Password,
      String Email) {
    final accountindex =
        Hivebox.values.toList().indexWhere((user) => user.id == ID);

    final _editedaccount = AccountModel(
      appName: appname,
      userName: username,
      password: Password,
      email: Email,
      lastUpdatedDate: DateTime.now(),
      id: ID,
    );
    //userlist[accountindex] = _editedaccount;
    Hivebox.putAt(accountindex, _editedaccount);
    notifyListeners();
  }

//Find Account By Id

  AccountModel findById(String id) {
    return Hivebox.values.firstWhere(
      (user) {
        return user.id == id;
      },
    );
  }

//greeting
  Widget get showTime {
    final currentTime = int.parse(DateFormat('HH').format(DateTime.now()));

    print(currentTime);
    if (currentTime >= 5 && currentTime <= 11) {
      return const Text(
        'Good Morning',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.5,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (currentTime >= 12 && currentTime < 18) {
      return const Text(
        'Good Afternoon',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.5,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (currentTime >= 18 || currentTime <= 5) {
      return const Text(
        'Good Evening',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.5,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    return Text(Hive.box('userinfo').get(1));
  }

//Show Icons
  Widget showIcon(String appName) {
    if (appName.toLowerCase().contains('google')) {
      return const Icon(
        FontAwesomeIcons.google,
        color: Colors.blue,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('gmail')) {
      return const Icon(
        FontAwesomeIcons.google,
        color: Colors.blue,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('youtube')) {
      return const Icon(
        FontAwesomeIcons.youtube,
        color: Colors.red,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('facebook')) {
      return const Icon(
        FontAwesomeIcons.facebook,
        color: Colors.blue,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('instagram')) {
      return const Icon(
        FontAwesomeIcons.instagram,
        color: Colors.pink,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('whatsapp')) {
      return const Icon(
        FontAwesomeIcons.whatsapp,
        color: Colors.green,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('twitter')) {
      return const Icon(
        FontAwesomeIcons.twitter,
        color: Colors.blue,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('discord')) {
      return const FaIcon(
        FontAwesomeIcons.discord,
        color: Colors.blue,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('reddit')) {
      return const Icon(
        FontAwesomeIcons.reddit,
        color: Colors.red,
        size: 27,
      );
    } else if (appName.toLowerCase().contains('netflix')) {
      return const Icon(
        FontAwesomeIcons.n,
        color: Colors.red,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('amazon')) {
      return const Icon(
        FontAwesomeIcons.amazon,
        color: Colors.black,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('apple')) {
      return const Icon(
        FontAwesomeIcons.apple,
        color: Colors.black,
        size: 27,
      );
    } else if (appName.toLowerCase().contains('twitch')) {
      return const Icon(
        FontAwesomeIcons.twitch,
        color: Colors.purple,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('telegram')) {
      return const Icon(
        FontAwesomeIcons.telegram,
        color: Colors.blue,
        size: 27,
      );
    } else if (appName.toLowerCase().contains('spotify')) {
      return const Icon(
        FontAwesomeIcons.spotify,
        color: Colors.green,
        size: 26,
      );
    } else if (appName.toLowerCase().contains('office')) {
      return const Icon(
        Icons.work,
        color: Colors.black,
        size: 26,
      );
    } else if (appName.toLowerCase().contains('electricity')) {
      return const Icon(
        Icons.power_sharp,
        color: Colors.orange,
        size: 26,
      );
    } else if (appName.toLowerCase().contains('power')) {
      return const Icon(
        Icons.power_sharp,
        color: Colors.orange,
        size: 26,
      );
    } else if (appName.toLowerCase().contains('pdd')) {
      return const Icon(
        Icons.power_sharp,
        color: Colors.orange,
        size: 26,
      );
    } else if (appName.toLowerCase().contains('water')) {
      return Icon(
        Icons.water_drop,
        color: Colors.blue.shade400,
        size: 26,
      );
    } else if (appName.toLowerCase().contains('phe')) {
      return Icon(
        Icons.water_drop,
        color: Colors.blue.shade400,
        size: 26,
      );
    } else if (appName.toLowerCase().contains('game')) {
      return const Icon(
        FontAwesomeIcons.xbox,
        color: Colors.green,
        size: 26,
      );
    } else if (appName.toLowerCase().contains('messenger')) {
      return Icon(
        FontAwesomeIcons.facebookMessenger,
        color: Colors.blue.shade400,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('snapchat')) {
      return Icon(
        FontAwesomeIcons.snapchatGhost,
        color: Colors.yellow.shade600,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('tiktok')) {
      return const Icon(
        FontAwesomeIcons.tiktok,
        color: Colors.black,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('wechat')) {
      return Icon(
        Icons.wechat,
        color: Colors.green.shade400,
        size: 27,
      );
    } else if (appName.toLowerCase().contains('uber')) {
      return const Icon(
        FontAwesomeIcons.uber,
        color: Colors.black,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('ebay')) {
      return const Icon(
        FontAwesomeIcons.ebay,
        color: Colors.blue,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('ebay')) {
      return const Icon(
        FontAwesomeIcons.ebay,
        color: Colors.blue,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('paypal')) {
      return Icon(
        Icons.paypal,
        color: Colors.blue.shade400,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('trip')) {
      return Icon(
        Icons.tour_rounded,
        color: Colors.blue.shade400,
        size: 25,
      );
    } else if (appName.toLowerCase().contains('microsoft')) {
      return Icon(
        FontAwesomeIcons.microsoft,
        color: Colors.blue.shade400,
        size: 25,
      );
    }
    return Icon(
      Icons.apps_outage_sharp,
      color: Colors.blue.shade400,
      size: 25,
    );
  }
}
