import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/reusable_text.dart';
import 'package:minified_commerce/const/constants.dart';
import 'package:minified_commerce/src/cart/controllers/cart_notifier.dart';
import 'package:minified_commerce/src/cart/models/cart_model.dart';
import 'package:minified_commerce/src/cart/widgets/cart_counter.dart';
import 'package:minified_commerce/src/cart/widgets/update_button.dart';
import 'package:provider/provider.dart';

class CheckoutTile extends StatelessWidget {
  const CheckoutTile({super.key, required this.cart});

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(builder: (context, cartNotifier, child) {
      return Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Container(
          width: ScreenUtil().screenWidth,
          height: 90.h,
          decoration: BoxDecoration(
            color:  Kolors.kPrimaryLight.withOpacity(.2),
            borderRadius: kRadiusAll,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: SizedBox(
              height: 85.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Kolors.kWhite,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12.h),
                            bottomLeft: Radius.circular(12.h),
                          ),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: kRadiusAll,
                              child: SizedBox(
                                width: 76.w,
                                height: double.infinity,
                                child: CachedNetworkImage(
                                  imageUrl: cart.product.imageUrls[0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ReusableText(
                            text: cart.product.title,
                            style:
                                appStyle(12, Kolors.kDark, FontWeight.normal),
                          ),
                          ReusableText(
                            text:
                                "Size: ${cart.size}    ||    Color: ${cart.color}"
                                    .toUpperCase(),
                            style:
                                appStyle(12, Kolors.kGray, FontWeight.normal),
                          ),
                          SizedBox(
                            width: ScreenUtil().screenWidth * 0.5,
                            child: Text(
                              cart.product.description,
                              maxLines: 2,
                              textAlign: TextAlign.justify,
                              style:
                                  appStyle(9, Kolors.kGray, FontWeight.normal),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 6.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                                onTap: () {
                                  // pushing id and cart item to controller
                                  cartNotifier.setSelectedCounter(
                                      cart.id, cart.quantity);
                                },
                                onDoubleTap: () {},
                                child: Container(
                                  width: 40.w,
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Kolors.kPrimary, width: 0.5),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: ReusableText(
                                    text: "* ${cart.quantity}",
                                    style: appStyle(
                                        12, Kolors.kPrimary, FontWeight.normal),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Padding(
                                padding: EdgeInsets.only(right: 6.w),
                                child: ReusableText(
                                  text:
                                      "\$ ${(cart.quantity * cart.product.price).toStringAsFixed(2)}",
                                  style: appStyle(
                                      12, Kolors.kPrimary, FontWeight.w600),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
