import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/reusable_text.dart';
import 'package:minified_commerce/src/adresses/controllers/address_notifier.dart';
import 'package:minified_commerce/src/adresses/models/address_model.dart';
import 'package:provider/provider.dart';

class SelectAddressTile extends HookWidget {
  const SelectAddressTile({super.key, required this.theAddress});

  final AddressModel theAddress;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressNotifier>(
      builder: (context, addressNotifier, child) {
        return ListTile(
          onTap: () {
            addressNotifier.setAddress(theAddress);
            context.pop();
          },
          contentPadding: EdgeInsets.zero,
          leading: const CircleAvatar(
            radius: 28,
            backgroundColor: Kolors.kSecondaryLight,
            child: Icon(
              MaterialIcons.location_pin,
              color: Kolors.kPrimary,
              size: 30,
            ),
          ),
          title: ReusableText(
            text:theAddress.addressType.toUpperCase(),
            style: appStyle(13, Kolors.kDark, FontWeight.w400),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ReusableText(
                text:theAddress.address,
                style: appStyle(11, Kolors.kGray, FontWeight.w400),
              ),
              ReusableText(
                text:theAddress.phone,
                style: appStyle(11, Kolors.kGray, FontWeight.w400),
              ),
            ],
          ),
          trailing: ReusableText(text: addressNotifier.address != null && addressNotifier.address!.id == theAddress.id ? "Selected" : "Select", style: appStyle(12, Kolors.kPrimary, FontWeight.w400))
        );
      },
    );
  }
}
