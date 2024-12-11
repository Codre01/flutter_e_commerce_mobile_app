import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/src/products/controllers/colors_sizes_notifier.dart';
import 'package:minified_commerce/src/products/controllers/product_notifier.dart';
import 'package:provider/provider.dart';

class ProductSizesWidget extends StatelessWidget {
  const ProductSizesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorsSizesNotifier>(
      builder: (context, controller, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              context.read<ProductNotifier>().product!.sizes.length, (index) {
            String size = context.read<ProductNotifier>().product!.sizes[index];
            return GestureDetector(
              onTap: () {
                controller.setSizes(size);
              },
              child: Container(
                height: 30.h,
                width: 45.h,
                decoration: BoxDecoration(
                  color: controller.sizes == size
                      ? Kolors.kPrimary
                      : Kolors.kGrayLight,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(size, style: appStyle(20, Kolors.kWhite, FontWeight.bold),),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
