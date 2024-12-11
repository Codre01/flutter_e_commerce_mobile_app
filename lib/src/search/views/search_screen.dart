import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/utils/kstrings.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/back_button.dart';
import 'package:minified_commerce/common/widgets/email_textfield.dart';
import 'package:minified_commerce/common/widgets/empty_screen_widget.dart';
import 'package:minified_commerce/common/widgets/login_bottom_sheet.dart';
import 'package:minified_commerce/common/widgets/reusable_text.dart';
import 'package:minified_commerce/src/products/widgets/staggered_tile_widget.dart';
import 'package:minified_commerce/src/search/controllers/search_notifier.dart';
import 'package:minified_commerce/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString("accessToken");
    final TextEditingController _searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(
          onTap: () {
            context.read<SearchNotifier>().clearResults();
            context.go("/home");
          },
        ),
        title: ReusableText(
          text: AppText.kSearch,
          style: appStyle(15, Kolors.kPrimary, FontWeight.bold),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: EmailTextField(
              controller: _searchController,
              radius: 30,
              hintText: "Search for products",
              prefixIcon: GestureDetector(
                onTap: () {
                  if (_searchController.text.isNotEmpty) {
                    context
                        .read<SearchNotifier>()
                        .searchFunction(_searchController.text);
                  }
                },
                child: const Icon(
                  AntDesign.search1,
                  color: Kolors.kPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<SearchNotifier>(
        builder: (context, searchNotifier, child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: ListView(
              children: [
                searchNotifier.results.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: "Search results",
                            style:
                                appStyle(13, Kolors.kPrimary, FontWeight.w600),
                          ),
                          ReusableText(
                            text: searchNotifier.searchKey,
                            style:
                                appStyle(13, Kolors.kPrimary, FontWeight.w600),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                SizedBox(height: 10.h),
                searchNotifier.results.isNotEmpty
                    ? StaggeredGrid.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        children: List.generate(
                          searchNotifier.results.length,
                          (index) {
                            final double mainAxisCellCount =
                                index % 2 == 0 ? 2.17 : 2.4;
                            final product = searchNotifier.results[index];

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
                                      context.read<WishlistNotifier>().addRemoveWishlist(
                                          product.id, () {});
                                    }
                                  }),
                            );
                          },
                        ),
                      )
                    : const EmptyScreenWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
