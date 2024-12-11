import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/src/entry_point/views/entry_point.dart';
import 'package:minified_commerce/src/onboarding/controllers/onboarding_notifier.dart';
import 'package:minified_commerce/src/onboarding/widgets/onboarding_screen_one.dart';
import 'package:minified_commerce/src/onboarding/widgets/onboarding_screen_two.dart';
import 'package:minified_commerce/src/onboarding/widgets/welcome_screen.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    late final PageController _pageController;
    String? accessToken = Storage().getString('accessToken');
    if (accessToken != null) {
      return AppEntryPoint();
    }
    @override
    void initState() {
      controller:
      _pageController;
      _pageController = PageController(
          initialPage: context.read<OnBoardingNotifier>().selectedPage);
      super.initState();
    }

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (page) {
              context.read<OnBoardingNotifier>().setSelectedPage = page;
            },
            children: const [
              OnBoardingScreenOne(),
              OnBoardingScreenTwo(),
              WelcomeScreen(),
            ],
          ),
          context.read<OnBoardingNotifier>().selectedPage == 2 ? const SizedBox.shrink() : Positioned(
              bottom: 50,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                width: ScreenUtil().screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    context.watch<OnBoardingNotifier>().selectedPage == 0 ? SizedBox(width: 25):
                    GestureDetector(
                      onTap: () {
                        // _pageController.animateToPage(context.read<OnBoardingNotifier>().selectedPage - 1, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                      },
                      child: const Icon(
                        AntDesign.leftcircleo,
                        color: Kolors.kPrimary,
                        size: 30,
                      ),
                    ),



                    SizedBox(
                      width: ScreenUtil().screenWidth * 0.7,
                      height: 50.h,
                      child: PageViewDotIndicator(
                        currentItem:
                            context.watch<OnBoardingNotifier>().selectedPage,
                        count: 3,
                        unselectedColor: Colors.black26,
                        selectedColor: Kolors.kPrimary,
                        duration: const Duration(milliseconds: 200),
                        onItemClicked: (index) {
                          _pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // _pageController.animateToPage(context.read<OnBoardingNotifier>().selectedPage + 1, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                      },
                      child: const Icon(
                        AntDesign.rightcircleo,
                        color: Kolors.kPrimary,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
