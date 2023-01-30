import 'package:chat_up/models/message_model.dart';
import 'package:flutter/material.dart';

import 'constant_widget.dart';
class ChatBubble extends StatelessWidget {
   ChatBubble({
    Key? key,required this.message
  }) : super(key: key);
Message message;
//بعمل اوبجكت عشان اجيب قيمة ال message

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10))),
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical:10  ),
        padding: const EdgeInsets.only(left: 10.0,right:20,top:16,bottom: 16  ),
        child:  Text(
          message.message!,
          // بحط هنا الداتا ال انا مستقبلها ف المسج مودل
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class FriendsChatBubble extends StatelessWidget {
   FriendsChatBubble({Key? key,required this.message}) : super(key: key);
  Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.pinkAccent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10))),
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical:10  ),
        padding: const EdgeInsets.only(left: 20.0,right:10,top:16,bottom: 16  ),
        child:  Text(
          message.message!,
          // بحط هنا الداتا ال انا مستقبلها ف المسج مودل
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
