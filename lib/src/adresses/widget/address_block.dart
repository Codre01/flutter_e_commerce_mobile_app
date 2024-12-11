import 'package:flutter/material.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/reusable_text.dart';
import 'package:minified_commerce/src/adresses/models/address_model.dart';
import 'package:minified_commerce/src/adresses/widget/address_tile.dart';

class AddressBlock extends StatelessWidget {
  const AddressBlock({super.key, this.address});

  final AddressModel? address;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableText(
          text: "Shipping Address",
          style: appStyle(13, Kolors.kPrimary, FontWeight.w500),
        ),

        AddressTile(address: address!, isCheckout: true,),
      ],
    );
  }
}
