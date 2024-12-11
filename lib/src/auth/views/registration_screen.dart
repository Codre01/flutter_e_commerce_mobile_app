import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/back_button.dart';
import 'package:minified_commerce/common/widgets/custom_button.dart';
import 'package:minified_commerce/common/widgets/email_textfield.dart';
import 'package:minified_commerce/common/widgets/password_field.dart';
import 'package:minified_commerce/src/auth/controllers/auth_notifier.dart';
import 'package:minified_commerce/src/auth/models/registration_model.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late final TextEditingController _usernameController =
      TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();

  final FocusNode _passwordNode = FocusNode();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kolors.kWhite,
      appBar: AppBar(
        backgroundColor: Kolors.kWhite,
        elevation: 0,
        leading: const AppBackButton(),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 100.h,
          ),
          Text(
            "Minified Commerce",
            textAlign: TextAlign.center,
            style: appStyle(24, Kolors.kGray, FontWeight.bold),
          ),
          Text(
            "Hi! Welcome back, You've been missed.",
            textAlign: TextAlign.center,
            style: appStyle(13, Kolors.kGray, FontWeight.normal),
          ),
          SizedBox(
            height: 25.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                EmailTextField(
                  radius: 25,
                  focusNode: _passwordNode,
                  hintText: "Username",
                  controller: _usernameController,
                  prefixIcon: const Icon(
                    CupertinoIcons.profile_circled,
                    size: 20,
                    color: Kolors.kGray,
                  ),
                  keyboardType: TextInputType.name,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                ),
                SizedBox(
                  height: 25.h,
                ),
                EmailTextField(
                  radius: 25,
                  focusNode: _passwordNode,
                  hintText: "Email",
                  controller: _emailController,
                  prefixIcon: const Icon(
                    CupertinoIcons.mail,
                    size: 20,
                    color: Kolors.kGray,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                ),
                SizedBox(
                  height: 25.h,
                ),
                PasswordField(
                  controller: _passwordController,
                  focusNode: _passwordNode,
                  radius: 25,
                ),
                SizedBox(
                  height: 25.h,
                ),
                context.watch<AuthNotifier>().isRegisterLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Kolors.kPrimary,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Kolors.kWhite),
                        ),
                      )
                    : CustomBtn(
                        text: "S I G N U P",
                        btnColor: Kolors.kPrimary,
                        onTap: () {
                          RegistrationModel model = RegistrationModel(
                              username: _usernameController.text,
                              email: _emailController.text,
                              password: _passwordController.text);

                          String data = registrationModelToJson(model);
                          context
                              .read<AuthNotifier>()
                              .registrationFunc(data, context);
                        },
                        btnWidth: ScreenUtil().screenWidth,
                        btnHeight: 45.h,
                        radius: 20,
                      ),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: SizedBox(
      //   height: 130.h,
      //   child: GestureDetector(
      //     onTap: () {},
      //     child: Text(
      //       "Do not have an account? Register a new account",
      //       textAlign: TextAlign.center,
      //       style: appStyle(12, Colors.blue, FontWeight.normal),
      //     ),
      //   ),
      // ),
    );
  }
}
