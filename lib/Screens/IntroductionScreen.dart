import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'SetFirstTimePasswordScreen.dart';

class IntroductionScreen extends StatefulWidget {
  IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final _controller = PageController();
  bool _lastPage = false;
  Widget buildintro(String imageUrl) {
    return Lottie.asset(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) => setState(() {
              index == 2 ? _lastPage = true : _lastPage = false;
              print(_lastPage);
            }),
            children: [
              buildintro('assets/intro1scr.json'),
              buildintro('assets/intro2scr.json'),
              buildintro('assets/intro3scr.json'),
            ],
          ),
          Align(
            alignment: const Alignment(0, 0.73),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: _lastPage ? null : () => _controller.jumpToPage(2),
                  child: _lastPage
                      ? const Text('')
                      : Text(
                          'Skip',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                ),
                SmoothPageIndicator(controller: _controller, count: 3),
                TextButton(
                  onPressed: _lastPage
                      ? () {
                          Navigator.of(context).pushReplacementNamed(
                            SetFirstTimePasswordScreen.routeName,
                          );
                          Hive.box('firsttime').add(1);
                        }
                      : () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                  child: _lastPage
                      ? Text(
                          'Done',
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      : Text(
                          'Next',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
