import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/utils/kstrings.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/reusable_text.dart';
import 'package:minified_commerce/common/widgets/shimmers/list_shimmer.dart';
import 'package:minified_commerce/const/constants.dart';
import 'package:minified_commerce/src/auth/views/login_screen.dart';
import 'package:minified_commerce/src/cart/controllers/cart_notifier.dart';
import 'package:minified_commerce/src/cart/hooks/fetch_cart.dart';
import 'package:minified_commerce/src/cart/widgets/cart_tile.dart';
import 'package:provider/provider.dart';

class CartScreen extends HookWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    
    
    final result = fetchCart();
    final carts = result.carts;
    final isLoading = result.isLoading;
    final refetch = result.refetch;

    if (accessToken == null) {
      return const LoginScreen();
    }

    if (isLoading) {
      return const Scaffold(
        body: ListShimmer(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
          text: AppText.kCart,
          style: appStyle(15, Kolors.kPrimary, FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: ListView(
          children: List.generate(carts.length, (index) {
            final cart = carts[index];
            return CartTile(
              cart: cart,
              onUpdate: () {
                context.read<CartNotifier>().updateCart(cart.id, refetch);
              },
              onRemove: () {
                context.read<CartNotifier>().deleteCart(cart.id, refetch);
              },
            );
          }),
        ),
      ),
      bottomNavigationBar: Consumer<CartNotifier>(
        builder: (context, cartNotifier, child) {
          return GestureDetector(
            onTap: () {
              context.push('/checkout');
            },
            child: cartNotifier.selectedCartsItemsId.isNotEmpty
                ? Container(
                    padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 90.h),
                    height: 130,
                    decoration: BoxDecoration(
                      color: Kolors.kPrimaryLight,
                      borderRadius: kRadiusAll,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusableText(
                                text: "Click To Checkout",
                                style: appStyle(
                                    15, Kolors.kWhite, FontWeight.w600))),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReusableText(
                            text:
                                "\$ ${cartNotifier.totalPrice.toStringAsFixed(2)}",
                            style: appStyle(15, Kolors.kWhite, FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
