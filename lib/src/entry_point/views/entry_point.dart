import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/src/auth/views/login_screen.dart';
import 'package:minified_commerce/src/cart/hooks/fetch_cart_count.dart';
import 'package:minified_commerce/src/cart/views/cart_screen.dart';
import 'package:minified_commerce/src/entry_point/controller/bottom_tab_notifier.dart';
import 'package:minified_commerce/src/home/views/home_screen.dart';
import 'package:minified_commerce/src/profile/views/profile_screen.dart';
import 'package:minified_commerce/src/wishlist/views/wishlist_screen.dart';
import 'package:provider/provider.dart';

class AppEntryPoint extends HookWidget {
  AppEntryPoint({super.key});

  List<Widget> pageList = [
    const HomeScreen(),
    const WishlistScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    if (accessToken == null) {
      return const LoginScreen();
    }
    final results = fetchCartCount(context);
    final data = results.count;
    return Consumer<TabIndexNotifier>(
        builder: (context, tabIndexNotifier, child) {
      return Scaffold(
        body: Stack(
          children: [
            pageList[tabIndexNotifier.index],
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                data: Theme.of(context).copyWith(canvasColor: Kolors.kOffWhite),
                child: BottomNavigationBar(
                  selectedFontSize: 12,
                  elevation: 0,
                  backgroundColor: Kolors.kOffWhite,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  currentIndex: tabIndexNotifier.index,
                  selectedItemColor: Kolors.kPrimary,
                  unselectedItemColor: Kolors.kGray,
                  selectedLabelStyle:
                      appStyle(9, Kolors.kPrimary, FontWeight.w500),
                  unselectedIconTheme: const IconThemeData(
                    color: Colors.black38,
                  ),
                  onTap: (i) {
                    tabIndexNotifier.setIndex(i);
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: tabIndexNotifier.index == 0
                            ? const Icon(Ionicons.home,
                                color: Kolors.kPrimary, size: 24)
                            : const Icon(AntDesign.home,
                                color: Kolors.kPrimary, size: 24),
                        label: "Home"),
                    BottomNavigationBarItem(
                        icon: tabIndexNotifier.index == 1
                            ? const Icon(Ionicons.heart,
                                color: Kolors.kPrimary, size: 24)
                            : const Icon(Ionicons.heart_outline,
                                color: Kolors.kPrimary, size: 24),
                        label: "Wishlist"),
                    BottomNavigationBarItem(
                        icon: tabIndexNotifier.index == 2
                            ? Badge(
                                label: Text(data.cartCount.toString()),
                                child: const Icon(
                                    MaterialCommunityIcons.shopping,
                                    color: Kolors.kPrimary,
                                    size: 24))
                            : Badge(
                                label: Text(data.cartCount.toString()),
                                child: const Icon(
                                    MaterialCommunityIcons.shopping_outline,
                                    color: Kolors.kPrimary,
                                    size: 24),
                              ),
                        label: "Cart"),
                    BottomNavigationBarItem(
                        icon: tabIndexNotifier.index == 3
                            ? const Icon(EvilIcons.user,
                                color: Kolors.kPrimary, size: 34)
                            : const Icon(EvilIcons.user,
                                color: Kolors.kPrimary, size: 34),
                        label: "Profile"),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
