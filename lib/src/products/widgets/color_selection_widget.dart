import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/reusable_text.dart';
import 'package:minified_commerce/const/constants.dart';
import 'package:minified_commerce/src/products/controllers/colors_sizes_notifier.dart';
import 'package:minified_commerce/src/products/controllers/product_notifier.dart';
import 'package:provider/provider.dart';

class ColorSelectionWidget extends StatelessWidget {
  const ColorSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorsSizesNotifier>(
      builder: (context, controller, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              context.read<ProductNotifier>().product!.colors.length, (index) {
            String color =
                context.read<ProductNotifier>().product!.colors[index];
            return GestureDetector(
              onTap: () {
                controller.setColor(color);
              },
              child: Container(
                padding: const EdgeInsets.only(right: 20, left: 20),
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  borderRadius: kRadiusAll,
                  color: color == controller.color
                      ? Kolors.kPrimary
                      : Kolors.kGrayLight,
                ),
                child: ReusableText(text: color, style: appStyle(12, Kolors.kWhite, FontWeight.normal)),
              ),
            );
          }),
        );
      },
    );
  }
}
