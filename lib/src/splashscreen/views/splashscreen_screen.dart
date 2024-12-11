import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';

import '../../../const/resource.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigator();
    super.initState();
  }

  _navigator() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {
      if (Storage().getBool('firstOpen') == null) {
        GoRouter.of(context).go('/onboarding');
      } else {
        // Go to homepage
        GoRouter.of(context).go('/home');
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kolors.kOffWhite,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(R.ASSETS_IMAGES_SPLASHSCREEN_PNG))),
      ),
    );
  }
}
