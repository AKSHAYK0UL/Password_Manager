import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_manager/Models/BankAccountModel.dart';

import '../Screens/AddEditBankAccountScreen.dart';
import '../Screens/BankDetailScreen.dart';
import 'NoHistory.dart';

class BankAccountListWidget extends StatelessWidget {
  const BankAccountListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _hiveBANKbox = Hive.box('bankdetail');
    return SizedBox(
      child: ValueListenableBuilder(
        valueListenable: _hiveBANKbox.listenable(),
        builder: (context, value, child) => _hiveBANKbox.isEmpty
            ? const NoHistoryWidget()
            : Align(
                alignment: Alignment.topCenter,
                child: Scrollbar(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    primary: true,
                    itemCount: _hiveBANKbox.length,
                    itemBuilder: (context, index) {
                      final hl = _hiveBANKbox.length;
                      // final AccountDetail = reverseHive[index];
                      int rIndex = hl - index - 1;
                      final BankDetail =
                          _hiveBANKbox.getAt(rIndex) as BankAccountModel;
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: ListTile(
                          tileColor: Colors.lightBlue.shade50,
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                BankDetailScreen.routeName,
                                arguments: BankDetail.id);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          leading: const CircleAvatar(
                            radius: 23,
                            child: Icon(
                              Icons.account_balance,
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            BankDetail.bankName,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          subtitle: Text(
                            BankDetail.accountHolderName,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      AddEditBankAccountScreen.routeName,
                                      arguments: BankDetail.id);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Are You Sure?',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        content: Text(
                                          'This item will be deleted permanently',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'No',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _hiveBANKbox.deleteAt(rIndex);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Yes',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
