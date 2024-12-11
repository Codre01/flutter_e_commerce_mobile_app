import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/custom_button.dart';
import 'package:minified_commerce/common/widgets/help_bottom_sheet.dart';
import 'package:minified_commerce/common/widgets/logout_bottom_sheet.dart';
import 'package:minified_commerce/common/widgets/reusable_text.dart';
import 'package:minified_commerce/src/auth/controllers/auth_notifier.dart';
import 'package:minified_commerce/src/auth/views/login_screen.dart';
import 'package:minified_commerce/src/profile/models/profile_model.dart';
import 'package:minified_commerce/src/profile/widgets/tile_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    if (accessToken == null) {
      return const LoginScreen();
    }
    return Scaffold(
        body: Consumer<AuthNotifier>(builder: (context, authNotifier, child) {
      ProfileModel? user = authNotifier.getUserData();
      return ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              const CircleAvatar(
                radius: 35,
                backgroundColor: Kolors.kOffWhite,
                // backgroundImage: ,
              ),
              SizedBox(
                height: 15.h,
              ),
              ReusableText(
                text: user?.email ?? 'No email available',
                style: appStyle(11, Kolors.kGray, FontWeight.normal),
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  color: Kolors.kOffWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ReusableText(
                  text: user?.username ?? 'No username available',
                  style: appStyle(14, Kolors.kDark, FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            color: Kolors.kOffWhite,
            child: Column(
              children: [
                ProfileTileWidget(
                  title: "My Orders",
                  leading: Octicons.checklist,
                  onTap: () {
                    context.push("/orders");
                  },
                ),
                ProfileTileWidget(
                  title: "Shipping Address",
                  leading: MaterialIcons.location_pin,
                  onTap: () {
                    context.push("/addresses");
                  },
                ),
                ProfileTileWidget(
                  title: "Privacy Policy",
                  leading: MaterialIcons.policy,
                  onTap: () {},
                ),
                ProfileTileWidget(
                  title: "Help Center",
                  leading: AntDesign.customerservice,
                  onTap: () => showHelpCenterBottomSheet(context),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: CustomBtn(
                    text: "Logout".toUpperCase(),
                    btnColor: Kolors.kRed,
                    btnWidth: ScreenUtil().screenWidth,
                    btnHeight: 35.h,
                    onTap: () {
                      logoutBottomSheet(context);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      );
    }));
  }
}
