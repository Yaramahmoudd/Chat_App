import 'package:chat_app/core/constant.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';
class ChatBubble extends StatelessWidget {
    ChatBubble({super.key,required this.message });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.only(left: 16,bottom: 16,top: 16,right: 16),
          decoration: BoxDecoration(
            color: kprimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
              bottomRight: Radius.circular(28),
            )
          ),
          child: Text(message.message,
              style: TextStyle(
                  color: bordercolor, fontSize: 15, )),
        ),
    );
  }
}
class ChatBubbleFriend extends StatelessWidget {
    ChatBubbleFriend({super.key,required this.message });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.only(left: 16,bottom: 16,top: 16,right: 16),
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
              bottomLeft: Radius.circular(28),
            )
          ),
          child: Text(message.message,
              style: TextStyle(
                  color: bordercolor, fontSize: 15, )),
        ),
    );
  }
}