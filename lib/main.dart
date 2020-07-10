import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/chat_screen.dart';
import './screens/splash_screen.dart';
import './screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat CHat',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        backgroundColor: Colors.orangeAccent,
        accentColor: Colors.blueGrey,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.teal,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: StreamBuilder(
              stream: FirebaseAuth.instance.onAuthStateChanged,
              builder: (ctx, userSnapshot){
                if(userSnapshot.connectionState == ConnectionState.waiting){
                  return SplashScreen();
                }
                if(userSnapshot.hasData){
                  return ChatScreen();
                }
                return AuthScreen();
              },
            ),
    );
  }
}

