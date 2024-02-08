import 'package:chat_app/core/constant.dart';
import 'package:flutter/material.dart';
class CustomeButton extends StatelessWidget {
    CustomeButton({super.key,required this.text,this.color,this.onTap});
  String text;
  Color? color;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text(text,style:const TextStyle(color: kprimaryColor,fontSize: 20,))),
              ),
    );
  }
}