import 'package:flutter/material.dart';

class GenericField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final void Function(String)? onSubmitted;
  final String? labeltext;
  final String? hintText;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isProfile;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final int? maxLines;

  GenericField({
    this.controller,
    this.validation,
    this.labeltext,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSubmitted,
    this.focusNode,
    this.keyboardType,
    this.readOnly = false,
    this.isProfile = false,
    this.autoFocus = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 55.h,
      child: TextFormField(
        focusNode: focusNode,
        // textInputAction: TextInputAction.done,
        autofocus: autoFocus!,
        onFieldSubmitted: onSubmitted,
        readOnly: readOnly,
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        autocorrect: true,
        validator: validation,
        style: const TextStyle(
          color: Color(0xff343434),
          fontSize: 16,
        ),

        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 5, right: 5),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          labelText: labeltext,
          labelStyle: const TextStyle(fontSize: 16, color: Color(0xff343434)),
          hintStyle: const TextStyle(fontSize: 16, color: Color(0xff343434)),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
      ),
    );
  }
}
