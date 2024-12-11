import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/reusable_text.dart';

class AddressesScreen extends HookWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          
        },
        child: Container(
          height: 80,
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
            color: Kolors.kPrimaryLight,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.h),
              topRight: Radius.circular(12.h),),
          ),
          child: Center(
            child: ReusableText(
              text: "Add Address",
              style: appStyle(16, Kolors.kWhite, FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
