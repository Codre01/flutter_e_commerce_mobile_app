import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/reusable_text.dart';
import 'package:minified_commerce/const/constants.dart';
import 'package:minified_commerce/src/order/controllers/order_notifier.dart';
import 'package:minified_commerce/src/order/models/order_model.dart';
import 'package:provider/provider.dart';

class OrderTile extends HookWidget {
  const OrderTile(this.order, {super.key});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderNotifier>(builder: (context, orderNotifier, child) {
      return GestureDetector(
        onTap: () {
          // pushing id and cart item to controller
        },
        onDoubleTap: () {},
        child: Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Container(
            width: ScreenUtil().screenWidth,
            height: 90.h,
            decoration: BoxDecoration(
              color: Kolors.kWhite,
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
                                    imageUrl:
                                        order.items[0].product.imageUrls[0],
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
                              text: order.items[0].product.title,
                              style:
                                  appStyle(12, Kolors.kDark, FontWeight.normal),
                            ),
                            ReusableText(
                              text:
                                  "Items: ${order.items.length}    ||    Status: ${order.status}"
                                      .toUpperCase(),
                              style:
                                  appStyle(12, Kolors.kGray, FontWeight.normal),
                            ),
                            SizedBox(
                              width: ScreenUtil().screenWidth * 0.5,
                              child: Text(
                                order.address.address,
                                maxLines: 2,
                                textAlign: TextAlign.justify,
                                style: appStyle(
                                    9, Kolors.kGray, FontWeight.normal),
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
                          
                          SizedBox(
                            height: 6.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 6.w),
                            child: ReusableText(
                              text: "\$ ${(order.totalAmount)}",
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
        ),
      );
    });
  }
}
