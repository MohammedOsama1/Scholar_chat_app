

import 'package:chat_app/cubit/cubit.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/register_screen.dart';



void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();

  }

   runApp(const MyApp());

  // List <MessageModel> messageList = [];
  // for (int i = 0; i<snapshot.data!.docs.length; i ++) {
  //   messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));}
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => HomeCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,

        ),
        initialRoute:'LoginScreen' ,
        routes: {
          'LoginScreen':(_)=> LoginScreen(),
          'RegisterScreen':(_)=> RegisterScreen(),
          'ChatScreen' :(_) =>  ChatScreen()


        },
      ),
    );
  }
}

