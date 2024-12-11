import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/back_button.dart';
import 'package:minified_commerce/common/widgets/reusable_text.dart';
import 'package:minified_commerce/common/widgets/shimmers/list_shimmer.dart';
import 'package:minified_commerce/src/order/hooks/fetch_order.dart';
import 'package:minified_commerce/src/order/widget/order_tile.dart';

class OrderScreen extends HookWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchOrders();
    final orders = result.orders;
    final isLoading = result.isLoading;

    if (isLoading) {
      return const Scaffold(
        body: ListShimmer(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        centerTitle: true,
        title: ReusableText(
          text: "My Orders",
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body: ListView(
        children: List.generate(orders.length, (index) {
          return OrderTile(orders[index]);
        }),
      ),
    );
  }
}
