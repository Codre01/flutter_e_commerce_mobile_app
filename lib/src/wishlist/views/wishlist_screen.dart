import 'package:flutter/material.dart';
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/utils/kstrings.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/reusable_text.dart';
import 'package:minified_commerce/src/auth/views/login_screen.dart';
import 'package:minified_commerce/src/wishlist/widgets/wishlist_list.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    if(accessToken == null){
      return const LoginScreen();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: ReusableText(
          text: AppText.kWishlist,
          style: appStyle(18, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: WishlistList(),
      ),
    );
  }
}
