import 'package:chat_app/core/constant.dart';
import 'package:flutter/material.dart';
class CustomeTextField extends StatelessWidget {
    CustomeTextField({super.key,this.hintText,this.labelText,this.onChanged,this.cont,required this.obscureText, this.icon,this.iconButton});
  String? hintText;
  String? labelText;
  TextEditingController? cont;
  Function(String)? onChanged;
  bool obscureText=false;
  final IconData? icon;
  final IconButton? iconButton;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      obscureText: obscureText,
      onChanged: onChanged,
      controller: cont,
        validator: (value) {
          if (value!.isEmpty) {
            return " must not be empty";
          }
          return null;
        },
              decoration: InputDecoration(
                prefixIcon: Icon(icon),
                suffixIcon: iconButton,
                suffixIconColor: bordercolor,
                prefixIconColor: bordercolor,
                labelText: labelText,
                labelStyle:const  TextStyle(color: bordercolor),
                hintText: hintText,
                hintStyle: const TextStyle(color: bordercolor),
                enabledBorder:const  OutlineInputBorder(
                  borderSide: BorderSide(color: bordercolor)
                ),
                border: const OutlineInputBorder(
                  
                )
              ),
            );
  }
}