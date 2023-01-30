import 'package:chat_up/widgets/constant_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/message_model.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key,required this.email}) : super(key: key);
  TextEditingController controller = TextEditingController();
  CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessagesCollection);
  final scrollController = ScrollController();
final String email;
// هنا عملت ايميل همرره من صفحة ال login او sign up
  //هنا خدت ref عشان اعمل بيه collection او اضيف بيه جوة collection موجودة
  @override
  Widget build(BuildContext context) {
    //بعمل  future builder ع اساس هيرجعلي بيانات هتجيلي ف المستقبل
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('created at',descending: true).snapshots(),
        // (reverse+descending)responsible for getting last msg
        //بستقبل الداتا ريال تايم عن طريق ستريم بيلدر وبرتبها عن طريق اوردر باي
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            //هنا عملت ليست فاضية هضيف فيهاالداتا اللي جيالي اللي هي عبارة عن مسج موديلز وكل موديل فيه داتا على هيآة ماب
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 45,
                    ),
                    const Text(
                      'Chat up!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      // (reverse+descending)responsible for getting last msg
                      controller: scrollController,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id==email?ChatBubble(
                          message: messagesList[index],
                        ):FriendsChatBubble(message: messagesList[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add(
                            {'messages': data, 'created at': DateTime.now(),'id':email});
                        //هنا بضيف الداتا عن طريق الref اللي انشأته عشان احط بيه داتا
                        controller.clear();

                        scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 300), curve:Curves.easeIn);
                      },
                      decoration: InputDecoration(
                          hintText: 'Send message',
                          hintStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
                          suffixIcon: const Icon(Icons.send,
                              color: kPrimaryColor, size: 35),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: kPrimaryColor, width: 1.5),
                              borderRadius: BorderRadius.circular(16)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: kPrimaryColor, width: 1.5),
                              borderRadius: BorderRadius.circular(16))),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
//وظيفة ال future builder انه بيعمل request من خلال الداله بتاعت get وف حالة ال snapshot فيه داتا هيرجعها مفيش هيرجع loading ويرجع يعمل req تاني لحد متيجي البيانات
