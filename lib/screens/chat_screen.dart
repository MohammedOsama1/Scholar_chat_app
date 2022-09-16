import 'package:chat_app/cubit/cubit.dart';
import 'package:chat_app/cubit/states.dart';
import 'package:chat_app/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/show_bubble.dart';
import '../widgets/show_fbubble.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  var controller = TextEditingController();
  var controllerOfListView = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return StreamBuilder<QuerySnapshot>(
          stream:
              cubit.messages.orderBy('CreatedAt', descending: true).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              List messageList = [];
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                messageList.add(snapshot.data!.docs[i]);
              }

              return Scaffold(
                appBar: AppBar(
                  backgroundColor: primaryClr,
                  centerTitle: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image1.png',
                        fit: BoxFit.cover,
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          'ChatScreen',
                          style: primaryStyle.copyWith(
                              fontSize: 24, fontWeight: FontWeight.w300),
                        ),
                      )
                    ],
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: controllerOfListView,
                        itemCount: messageList.length,
                        itemBuilder: (BuildContext context, index) {
                          return
                            messageList[index]['email'] == email?
                            BubbleChat(
                            text: messageList[index]['message'],
                          ):FBubbleChat(text: messageList[index]['message']);
                        },
                      ),
                    ),
                    TextFormField(
                      controller: controller,
                      style: const TextStyle(color: Colors.black, fontSize: 17),
                      decoration: InputDecoration(
                          hintText: 'Say Some Thing ... ',
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: primaryClr,
                            ),
                            onPressed: () {
                              cubit
                                  .sendingMessage(controller.text, email)
                                  .then((value) {
                                controller.clear();
                                controllerOfListView.jumpTo(0);
                              });
                            },
                          ),
                          hintStyle: const TextStyle(
                              color: Colors.black, fontSize: 17),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    )
                  ],
                ),
              );
            } else {
              return ModalProgressHUD(
                inAsyncCall: true,
                child: Container(),
              );
            }
          },
        );
      },
    );
  }
}
