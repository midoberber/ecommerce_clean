import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class Passwordfield extends StatefulWidget {
  final TextEditingController? controller;
  String? Function(String?)? validator;
  final FocusNode? focusnode;
  final TextInputType textinputtype;
  final String ?labeltext;
  final String ?hinttext;
  final void Function(String)? onFieldSubmitted;

  Passwordfield({
    this.controller,
     this.labeltext,
    this.textinputtype = TextInputType.text,
    this.focusnode,
    this.onFieldSubmitted,
    this.validator,
     this.hinttext,
  });

  @override
  _PasswordfieldState createState() => _PasswordfieldState();
}

class _PasswordfieldState extends State<Passwordfield> {
  bool _issecuire = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
     //height: 70.h,
      child: TextFormField(
        onFieldSubmitted: widget.onFieldSubmitted,
        controller: widget.controller,
        obscureText: _issecuire,
        keyboardType: widget.textinputtype,
        focusNode: widget.focusnode,
        autocorrect: true,
        validator: widget.validator,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xff343434),
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 5,right: 5),
          hintText: widget.hinttext,
          labelText: widget.labeltext,
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Color(0xff343434)

          ),
          labelStyle:const TextStyle(
            fontSize: 16,
            color: Color(0xff343434)
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _issecuire = !_issecuire;
              });
            },
            icon: Icon(
              _issecuire == false ? Icons.visibility : Icons.visibility_off,
              // color:
              // _issecuire == true ? Color(0xFFE0E0E0) : AppColors.subColor,
              size: 25,
              color: Color(0xffCCCCCC),
            ),
          ),
        ),
      ),
    );
  }
}
