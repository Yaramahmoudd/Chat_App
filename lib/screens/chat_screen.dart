import 'package:chat_app/core/constant.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kmessagesCollection);
  TextEditingController cont = TextEditingController();
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kcreatedAT, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kprimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    photo,
                    height: 60,
                  ),
                  const Text('Chat',
                      style: TextStyle(
                          color: bordercolor,
                          fontSize: 20,
                          fontFamily: 'Pacifico')),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? ChatBubble(
                                message: messagesList[index],
                              )
                            : ChatBubbleFriend(
                                message: messagesList[index],
                              );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: cont,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              if (cont.text.trim().isNotEmpty) {
                                messages.add({
                                  kmessage: cont.text,
                                  kcreatedAT: DateTime.now(),
                                  'id': email,
                                });
                                cont.clear();
                                _controller.animateTo(
                                  0,
                                  duration: Duration(seconds: 1),
                                  curve: Curves.easeIn,
                                );
                              }
                            },
                            icon: Icon(
                              Icons.send,
                              color: kprimaryColor,
                            )),
                        hintText: 'Enter your message',
                        hintStyle: const TextStyle(color: kprimaryColor),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: kprimaryColor)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kprimaryColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('Loading.....');
        }
      },
    );
  }
}
