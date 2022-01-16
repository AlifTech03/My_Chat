//packages
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

//files
import 'screens/chat_screen.dart';
import 'screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Chat',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          backgroundColor: Colors.pink,
          colorScheme: ThemeData.light().colorScheme.copyWith(
                secondary: Colors.deepPurple,
                secondaryContainer: Colors.purple[600],
                brightness: Brightness.light,
              ),
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const ChatScreen();
              }
              return const AuthScreen();
            }));
  }
}
