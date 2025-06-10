import 'package:daily_price_list/Resources/Components/CustomTextFormField.dart';
import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _EmailController = TextEditingController();

  final _PasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Image(
                        image: AssetImage('assets/images/LoginSignup.png'))),
                SizedBox(
                  height: 60.h,
                ),
                Text(
                  'Loging',
                  style: StringsConstants.loginScreenTextColor,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Enter your emails and password',
                  style: StringsConstants.loginScreenTextColor2,
                ),
                SizedBox(
                  height: 20.h,
                ),
                AuthTextField(
                  controller: _EmailController,
                  labelText: 'Email',
                  hintText: 'email@example.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => EmailValidator.validate(value ?? '')
                      ? null
                      : 'Enter Valid Email',
                ),
                SizedBox(
                  height: 20.h,
                ),
                AuthTextField(
                  controller: _PasswordController,
                  labelText: 'Password',
                  hintText: '*******',
                  keyboardType: TextInputType.visiblePassword,
                  // prefixIcon: Icons.lock,
                  isPassword: true,
                  validator: (value) =>
                      value!.length >= 8 ? null : 'Minimun 8 characters',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
