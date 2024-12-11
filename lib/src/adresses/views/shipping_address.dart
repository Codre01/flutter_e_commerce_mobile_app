import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/back_button.dart';
import 'package:minified_commerce/common/widgets/reusable_text.dart';
import 'package:minified_commerce/common/widgets/shimmers/list_shimmer.dart';
import 'package:minified_commerce/src/adresses/controllers/address_notifier.dart';
import 'package:minified_commerce/src/adresses/hooks/fetch_address_list.dart';
import 'package:minified_commerce/src/adresses/widget/add_address_modal.dart';
import 'package:minified_commerce/src/adresses/widget/address_tile.dart';
import 'package:provider/provider.dart';

class ShippingAddress extends HookWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchAddress();
    final addresses = result.address;
    final isLoading = result.isLoading;
    final refetch = result.refetch;

    if (isLoading) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: const ListShimmer(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: ReusableText(
          text: "Shipping Address",
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        children: List.generate(addresses.length, (index) {
          final address = addresses[index];
          return AddressTile(
            address: address,
            isCheckout: false,
            onDelete: () {
              context
                  .read<AddressNotifier>()
                  .deleteAddress(address.id, refetch, context);
            },
            setDefault: () {
              context
                  .read<AddressNotifier>()
                  .setAsDefault(address.id, refetch, context);
            },
          );
        }),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          addAddressModalSheet(context, refetch);
        },
        child: Container(
          height: 80,
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
            color: Kolors.kPrimaryLight,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.h),
              topRight: Radius.circular(12.h),
            ),
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
