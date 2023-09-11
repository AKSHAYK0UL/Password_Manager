import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'BankAccountModel.g.dart';

@HiveType(typeId: 1)
class BankAccountModel {
  @HiveField(0)
  String bankName;
  @HiveField(1)
  String branchName;
  @HiveField(2)
  String accountHolderName;
  @HiveField(3)
  int accountNumber;
  @HiveField(4)
  String accountType;
  @HiveField(5)
  String? ifcCode;
  @HiveField(6)
  int? cardNumber;
  @HiveField(7)
  int? atmPin;
  @HiveField(8)
  String? id;
  @HiveField(9)
  DateTime? lastUpdatedDate;
  BankAccountModel({
    required this.bankName,
    required this.branchName,
    required this.accountHolderName,
    required this.accountNumber,
    required this.accountType,
    this.id,
    this.lastUpdatedDate,
    this.cardNumber,
    this.ifcCode,
    this.atmPin,
  });
}

class BankData with ChangeNotifier {
  final _hiveBANKbox = Hive.box('bankdetail');

//find by id
  BankAccountModel findBYidBank(String ID) {
    return _hiveBANKbox.values.firstWhere(
      (acc) {
        return acc.id == ID;
      },
    );
  }

  //add Bank Account
  void addbankAccount(BankAccountModel account) {
    final newAccount = BankAccountModel(
      bankName: account.bankName,
      branchName: account.branchName,
      accountHolderName: account.accountHolderName,
      accountNumber: account.accountNumber,
      accountType: account.accountType,
      atmPin: account.atmPin,
      cardNumber: account.cardNumber,
      ifcCode: account.ifcCode,
      id: DateTime.now().toString(),
      lastUpdatedDate: DateTime.now(),
    );
    _hiveBANKbox.add(newAccount);
    notifyListeners();
  }

  //edit Bank Account
  void editbankAccount(BankAccountModel account, String ID) {
    final accountIndex =
        _hiveBANKbox.values.toList().indexWhere((acc) => acc.id == ID);
    final editbank = BankAccountModel(
      bankName: account.bankName,
      branchName: account.branchName,
      accountHolderName: account.accountHolderName,
      accountNumber: account.accountNumber,
      accountType: account.accountType,
      atmPin: account.atmPin,
      cardNumber: account.cardNumber,
      ifcCode: account.ifcCode,
      lastUpdatedDate: DateTime.now(),
      id: ID,
    );
    _hiveBANKbox.putAt(accountIndex, editbank);
    notifyListeners();
  }
}
