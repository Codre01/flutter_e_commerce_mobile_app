import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/utils/kstrings.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/custom_button.dart';
import 'package:minified_commerce/common/widgets/reusable_text.dart';
import 'package:minified_commerce/const/resource.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Kolors.kWhite,
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            child: Column(
              children: [
                SizedBox(height: 100.h),
                Image.asset(R.ASSETS_IMAGES_GETSTARTED_PNG, fit: BoxFit.cover),
                SizedBox(height: 30.h),
                Text(
                  AppText.kWelcomeHeader,
                  textAlign: TextAlign.center,
                  style: appStyle(24, Kolors.kPrimary, FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: ScreenUtil().screenWidth - 100,
                  child: Text(
                    AppText.kWelcomeMessage,
                    textAlign: TextAlign.center,
                    style: appStyle(11, Kolors.kGray, FontWeight.normal),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomBtn(
                  text: AppText.kGetStarted,
                  onTap: () {
                    // Storage().setBool("firstOpen", true);
                    context.go("/home");
                  },
                  btnHeight: 35.h,
                  radius: 20,
                  btnWidth: ScreenUtil().screenWidth - 100,
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReusableText(
                        text: "Already have an account?",
                        style: appStyle(12, Kolors.kDark, FontWeight.normal)),
                    TextButton(
                        onPressed: () {
                          // navigate to login screen
                          context.go("/login");
                        },
                        child: Text("Sign In",
                            style:
                                appStyle(12, Colors.blue, FontWeight.normal)))
                  ],
                )
              ],
            )));
  }
}
