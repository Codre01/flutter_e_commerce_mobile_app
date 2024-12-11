import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minified_commerce/common/utils/kcolors.dart';
import 'package:minified_commerce/common/widgets/app_style.dart';
import 'package:minified_commerce/common/widgets/back_button.dart';
import 'package:minified_commerce/common/widgets/custom_button.dart';
import 'package:minified_commerce/common/widgets/email_textfield.dart';
import 'package:minified_commerce/common/widgets/password_field.dart';
import 'package:minified_commerce/src/auth/controllers/auth_notifier.dart';
import 'package:minified_commerce/src/auth/models/login_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _usernameController =
      TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();

  final FocusNode _passwordNode = FocusNode();

  @override
  void dispose() {
    _usernameController.dispose();
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
        leading: AppBackButton(
          onTap: () {
            context.go("/home");
          },
        ),
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
                PasswordField(
                  controller: _passwordController,
                  focusNode: _passwordNode,
                  radius: 25,
                ),
                SizedBox(
                  height: 25.h,
                ),
                context.watch<AuthNotifier>().isLoginLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Kolors.kPrimary,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Kolors.kWhite),
                        ),
                      )
                    : CustomBtn(
                        text: "L O G I N",
                        btnColor: Kolors.kPrimary,
                        onTap: () {
                          LoginModel model = LoginModel(
                            password: _passwordController.text,
                            username: _usernameController.text,
                          );
                          String data = loginModelToJson(model);
                          context
                              .read<AuthNotifier>()
                              .loginFunc(data, context);
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
      bottomNavigationBar: SizedBox(
        height: 130.h,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: GestureDetector(
            onTap: () {
              context.push("/register");
            },
            child: Text(
              "Do not have an account? Register a new account",
              textAlign: TextAlign.center,
              style: appStyle(12, Colors.blue, FontWeight.normal),
            ),
          ),
        ),
      ),
    );
  }
}
