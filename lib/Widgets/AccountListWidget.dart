import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../Models/AccountModel.dart';
import '../Screens/AccountDetailScreen.dart';
import '../Screens/AddNewAccountScreen.dart';
import 'NoHistory.dart';

class AccountListWidget extends StatelessWidget {
  const AccountListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Hivebox = Hive.box('storeaccounts');
    final AccountMODEL = Provider.of<Datalist>(context);
    return SizedBox(
      child: ValueListenableBuilder(
        valueListenable: Hivebox.listenable(),
        builder: (context, value, child) => Hivebox.isEmpty
            ? const NoHistoryWidget()
            : Align(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: Hivebox.length,
                  itemBuilder: (context, index) {
                    final AccountDetail = Hivebox.getAt(index) as AccountModel;
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: ListTile(
                        tileColor: Colors.lightBlue.shade50,
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              AccountDetailScreen.routeName,
                              arguments: AccountDetail.id);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        leading: CircleAvatar(
                          radius: 23,
                          child: AccountMODEL.showIcon(AccountDetail.appName),
                        ),
                        title: Text(
                          AccountDetail.appName,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(AccountDetail.userName,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    AddNewAccountScreen.routeName,
                                    arguments: AccountDetail.id);
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
                                        borderRadius: BorderRadius.circular(15),
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
                                            Hivebox.deleteAt(index);
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
    );
  }
}
