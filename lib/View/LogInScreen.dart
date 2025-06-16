import 'package:daily_price_list/Resources/Components/Buttons.dart';
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

  final _EmailFocusNode = FocusNode();

  final _PasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.whiteColor,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                      child: Image(
                          image: AssetImage('assets/images/LoginSignup.png'))),
                  SizedBox(
                    height: 80.h,
                  ),
                  Text(
                    'Loging',
                    style: StringsConstants.loginScreenTextStyle,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Enter your emails and password',
                    style: StringsConstants.loginScreenTextStyle2,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

//The underscore _ is a placeholder for a parameter that is being ignored.

// In this case, onFieldSubmitted passes the submitted value (i.e., the text the user typed before hitting "Done" or "Next"). But if you don’t need to use that value, you can just write _ to say:

// “Yes, I accept a parameter here, but I don’t care about its value.”
                  AuthTextField(
                    controller: _EmailController,
                    labelText: 'Email',
                    hintText: 'email@example.com',
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _EmailFocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_PasswordFocusNode);
                    },
                    validator: (value) => EmailValidator.validate(value ?? '')
                        ? null
                        : 'Enter valid email',
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
                    focusNode: _PasswordFocusNode,
                    textInputAction: TextInputAction.done,
                    validator: (value) =>
                        value!.length >= 8 ? null : 'Minimun 8 characters',
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: StringsConstants.loginScreenTextStyle3,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: Buttons1(
                      title: 'Log in',
                      titleStyle: StringsConstants.signInButtonStyle,
                      color: ColorsConstants.greenColor,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          print('SUCCESS');
                        } else {
                          print('Failure');
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: StringsConstants.loginScreenTextStyle3,
                      ),
                      Text(" Signup",
                          style: StringsConstants.loginScreenTextStyle4)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
