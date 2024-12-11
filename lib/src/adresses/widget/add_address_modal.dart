import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:minified_commerce/common/models/api_error_model.dart';
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/common/utils/environment.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/custom_button.dart';
import 'package:minified_commerce/common/widgets/email_textfield.dart';
import 'package:minified_commerce/common/widgets/error_modal.dart';
import 'package:minified_commerce/common/widgets/reusable_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future<dynamic> addAddressModalSheet(BuildContext context, Function()? refetch) {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? accessToken = Storage().getString('accessToken');

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
    ),
    builder: (BuildContext context) {
      // Define ValueNotifiers inside the builder
      final ValueNotifier<String> _addressTypeNotifier =
          ValueNotifier<String>('Home');
      final ValueNotifier<bool> _isDefaultAddressNotifier =
          ValueNotifier<bool>(false);

      Future<void> _sendAddressData() async {
        // Input validation
        if (_addressController.text.isEmpty || _phoneController.text.isEmpty) {
          showErrorPopup(context, "Please fill in all fields", null, null);
          return;
        }

        final url = Uri.parse('${Environment.appBaseUrl}/api/address/add/');
        try {
          final response = await http.post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $accessToken'
            },
            body: jsonEncode({
              'address': _addressController.text,
              'phone': _phoneController.text,
              'address_type': _addressTypeNotifier.value,
              'is_default': _isDefaultAddressNotifier.value,
            }),
          );

          if (response.statusCode == 201) {
            Navigator.pop(context);
            refetch!();
          } else {
            var data = apiErrorFromJson(response.body);
            showErrorPopup(context, data.message, null, null);
          }
        } catch (e) {
          var data = apiErrorFromJson(e.toString());
            showErrorPopup(context, data.message, null, null);
        }
      }

      return DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
            ),
            child: ListView(
              controller: controller,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              children: [
                Center(
                  child: Container(
                    width: 50.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: ReusableText(
                    text: "Add New Address",
                    style: appStyle(18, Kolors.kPrimary, FontWeight.w600),
                  ),
                ),
                SizedBox(height: 30.h),
                EmailTextField(
                  radius: 25,
                  hintText: "Address",
                  controller: _addressController,
                  prefixIcon: const Icon(
                    MaterialIcons.location_pin,
                    size: 20,
                    color: Kolors.kGray,
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20.h),
                EmailTextField(
                  radius: 25,
                  hintText: "Phone",
                  controller: _phoneController,
                  prefixIcon: const Icon(
                    MaterialIcons.phone,
                    size: 20,
                    color: Kolors.kGray,
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20.h),
                ValueListenableBuilder<String>(
                  valueListenable: _addressTypeNotifier,
                  builder: (context, selectedType, child) {
                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Address Type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      value: selectedType,
                      items: ['Home', 'Office', 'School']
                          .map((label) => DropdownMenuItem(
                                value: label,
                                child: Text(label),
                              ))
                          .toList(),
                      onChanged: (value) {
                        _addressTypeNotifier.value = value!;
                      },
                    );
                  },
                ),
                SizedBox(height: 10.h),
                ValueListenableBuilder<bool>(
                  valueListenable: _isDefaultAddressNotifier,
                  builder: (context, isDefault, child) {
                    return SwitchListTile(
                      title: Text(
                        'Set as default address',
                        style: appStyle(14, Colors.black87, FontWeight.w500),
                      ),
                      value: isDefault,
                      activeColor: Kolors.kPrimary,
                      onChanged: (bool value) {
                        _isDefaultAddressNotifier.value = value;
                      },
                    );
                  },
                ),
                SizedBox(height: 30.h),
                CustomBtn(
                  text: "S A V E",
                  btnColor: Kolors.kPrimary,
                  onTap: _sendAddressData,
                  btnWidth: ScreenUtil().screenWidth,
                  btnHeight: 50.h,
                  radius: 20,
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
