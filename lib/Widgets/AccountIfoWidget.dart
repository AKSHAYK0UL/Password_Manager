import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountInfoWidget extends StatelessWidget {
  String option;
  String info;
  IconData icon;
  AccountInfoWidget(this.option, this.info, this.icon, {super.key});

  void _ontap(BuildContext context) {
    Clipboard.setData(
      ClipboardData(
        text: info,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Copied to clipboard',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Colors.grey.shade200,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }

  void _ontapOnbar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            option,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: Text(
            info,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            TextButton(
              onPressed: () {
                _ontap(context);
                Navigator.of(context).pop();
              },
              child: Text(
                'Copy',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            child: Text(
              option,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          InkWell(
            onTap: option == 'Last updated on' || info == 'Not Provided'
                ? null
                : () => _ontapOnbar(context),
            child: Chip(
              backgroundColor: Colors.lightBlue.shade50,
              labelPadding: const EdgeInsets.symmetric(horizontal: 15),
              padding:
                  const EdgeInsets.only(right: 20, top: 12.5, bottom: 12.5),
              deleteIcon: const Icon(
                Icons.copy,
                size: 27,
              ),
              onDeleted: option == 'Last updated on' || info == 'Not Provided'
                  ? null
                  : () {
                      _ontap(context);
                    },
              label: option == 'Last updated on'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          child: Text(
                            info,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Icon(icon),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.69,
                          child: Text(
                            info,
                            style: Theme.of(context).textTheme.titleMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
