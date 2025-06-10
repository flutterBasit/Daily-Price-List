import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool isPassword;
  final bool showPasswordToggle;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final VoidCallback? onSubmitted;

  AuthTextField(
      {super.key,
      this.keyboardType,
      this.controller,
      this.hintText,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.onChanged,
      this.validator,
      this.isPassword = false,
      this.showPasswordToggle = true,
      this.textInputAction,
      this.focusNode,
      this.onSubmitted});

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: widget.isPassword && _obsecureText,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      focusNode: widget.focusNode,
      onFieldSubmitted: (_) => widget.onSubmitted?.call(),
      decoration: InputDecoration(
          labelStyle: StringsConstants.CustomTextFieldLabelStyle,
          hintText: widget.hintText,
          labelText: widget.labelText,
          prefixIcon:
              widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          suffixIcon: widget.isPassword && widget.showPasswordToggle
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obsecureText = !_obsecureText;
                    });
                  },
                  //condition ? valueIfTrue : valueIfFalse
                  icon: Icon(
                      _obsecureText ? Icons.visibility_off : Icons.visibility))
              : null,
          enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: ColorsConstants.whiteColor4, width: 1.5)),
          focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: ColorsConstants.whiteColor4, width: 1.5))
          //  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r))
          ),
    );
  }
}
