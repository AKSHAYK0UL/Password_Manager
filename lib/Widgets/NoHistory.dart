import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoHistoryWidget extends StatelessWidget {
  const NoHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/nohistory.json'),
          Text(
            'No Account Created Yet!',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
