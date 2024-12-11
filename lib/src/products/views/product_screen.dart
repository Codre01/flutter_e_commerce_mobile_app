import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/utils/kstrings.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/back_button.dart';
import 'package:minified_commerce/common/widgets/error_modal.dart';
import 'package:minified_commerce/common/widgets/login_bottom_sheet.dart';
import 'package:minified_commerce/common/widgets/reusable_text.dart';
import 'package:minified_commerce/src/cart/controllers/cart_notifier.dart';
import 'package:minified_commerce/src/cart/models/create_cart_model.dart';
import 'package:minified_commerce/src/products/controllers/colors_sizes_notifier.dart';
import 'package:minified_commerce/src/products/controllers/product_notifier.dart';
import 'package:minified_commerce/src/products/widgets/color_selection_widget.dart';
import 'package:minified_commerce/src/products/widgets/expandable_text.dart';
import 'package:minified_commerce/src/products/widgets/product_bottom_bar.dart';
import 'package:minified_commerce/src/products/widgets/product_sizes_widget.dart';
import 'package:minified_commerce/src/products/widgets/similar_products.dart';
import 'package:minified_commerce/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    return Consumer<ProductNotifier>(
      builder: (context, productNotifier, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Kolors.kWhite,
                expandedHeight: 320.h,
                collapsedHeight: 65.h,
                floating: false,
                pinned: true,
                leading: const AppBackButton(),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Consumer<WishlistNotifier>(
                      builder: (context, wishlistNotifier, child) {
                        return GestureDetector(
                          onTap: () {
                            if (accessToken == null) {
                              loginBottomSheet(context);
                            } else {
                              wishlistNotifier.addRemoveWishlist(
                                  productNotifier.product!.id, () {});
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: Kolors.kSecondaryLight,
                            child: Icon(
                              AntDesign.heart,
                              color: wishlistNotifier.wishlist
                                      .contains(productNotifier.product!.id)
                                  ? Kolors.kRed
                                  : Kolors.kGray,
                              size: 18,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  background: SizedBox(
                    height: 415.h,
                    child: ImageSlideshow(
                      indicatorColor: Kolors.kPrimary,
                      autoPlayInterval: 15000,
                      isLoop: productNotifier.product!.imageUrls.length > 1
                          ? true
                          : false,
                      children: List.generate(
                        productNotifier.product!.imageUrls.length,
                        (i) {
                          return CachedNetworkImage(
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            height: 415.h,
                            imageUrl: productNotifier.product!.imageUrls[i],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(
                        text:
                            productNotifier.product!.clothesType.toUpperCase(),
                        style: appStyle(13, Kolors.kGray, FontWeight.w600),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            AntDesign.star,
                            color: Kolors.kGold,
                            size: 14,
                          ),
                          ReusableText(
                            text: productNotifier.product!.ratings
                                .toStringAsFixed(1),
                            style:
                                appStyle(13, Kolors.kGray, FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ReusableText(
                    text: productNotifier.product!.title,
                    style: appStyle(16, Kolors.kDark, FontWeight.w600),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpandableText(
                      text: productNotifier.product!.description),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.h),
                  child: Divider(
                    thickness: .5.h,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ReusableText(
                    text: "Select Sizes",
                    style: appStyle(14, Kolors.kDark, FontWeight.w600),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: ProductSizesWidget(),
              )),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ReusableText(
                    text: "Select Color",
                    style: appStyle(14, Kolors.kDark, FontWeight.w600),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ColorSelectionWidget(),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ReusableText(
                    text: "Similar Products",
                    style: appStyle(14, Kolors.kDark, FontWeight.w600),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: SimilarProducts(),
                ),
              ),
            ],
          ),
          bottomNavigationBar: ProductBottomBar(
            price: productNotifier.product!.price.toStringAsFixed(2),
            onPressed: () {
              if (accessToken == null) {
                loginBottomSheet(context);
              } else {
                // Check if size and color are selected
                if (context.read<ColorsSizesNotifier>().color == "" ||
                    context.read<ColorsSizesNotifier>().sizes == "") {
                  showErrorPopup(context, AppText.kCartErrorText,
                      "Error Adding to Cart", true);
                } else {
                  var data = AddCartModel(product: context.read<ProductNotifier>().product!.id, quantity: 1, size: context.read<ColorsSizesNotifier>().sizes, color: context.read<ColorsSizesNotifier>().color);
                  String cartData = addCartModelToJson(data);

                  context.read<CartNotifier>().addToCart(cartData, context);
                }
              }
            },
          ),
        );
      },
    );
  }
}
