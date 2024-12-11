import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/widgets/login_bottom_sheet.dart';
import 'package:minified_commerce/common/widgets/shimmers/list_shimmer.dart';
import 'package:minified_commerce/const/resource.dart';
import 'package:minified_commerce/src/products/widgets/staggered_tile_widget.dart';
import 'package:minified_commerce/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:minified_commerce/src/wishlist/hooks/fetch_wishlist.dart';
import 'package:provider/provider.dart';

class WishlistList extends HookWidget {
  const WishlistList({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');

    final result = fetchWishList();
    final products = result.products;
    final isLoading = result.isLoading;
    final refetch = result.refetch;
    final error = result.error;

    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.0),
        child: ListShimmer(),
      );
    }

    return products.isEmpty
        ? Center(
          child: Padding(
              padding: const EdgeInsets.all(25),
              child: Image.asset(R.ASSETS_IMAGES_EMPTY_PNG, height: ScreenUtil().screenHeight * .3,),
            ),
        )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h),
            child: StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: List.generate(
                products.length,
                (index) {
                  final double mainAxisCellCount = index % 2 == 0 ? 2.17 : 2.4;
                  final product = products[index];

                  return StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: mainAxisCellCount,
                    child: StaggeredTileWidget(
                      index: index,
                      product: product,
                      onTap: () {
                        if (accessToken == null) {
                          loginBottomSheet(context);
                        } else {
                          context
                              .read<WishlistNotifier>()
                              .addRemoveWishlist(product.id, refetch!);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          );
  }
}
