//packages
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
//files
import '../widgets/Auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final authIns = FirebaseAuth.instance;
  var _isLoading = false;
  void _submittedForm(
    String? username,
    File? image,
    String? email,
    String? password,
    bool? isLogin,
    BuildContext? ctx,
  ) async {
    UserCredential auth;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin!) {
        auth = await authIns.signInWithEmailAndPassword(
            email: email!, password: password!);
      } else {
        auth = await authIns.createUserWithEmailAndPassword(
            email: email!, password: password!);
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(auth.user!.uid + '.jpg');
        await ref.putFile(image!);
        final imageUrl = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(auth.user!.uid)
            .set({'username': username, 'imageurl':imageUrl, 'email': email});
      }
    } on PlatformException catch (error) {
      var message = 'An error occured. Please check your credentials';
      if (error.message != null) {
        message = error.message!;
      }
      ScaffoldMessenger.of(ctx!).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print('its an errro of => $error');
      var message = 'An error occured. Please check your credentials';
      ScaffoldMessenger.of(ctx!).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: AuthForm(_submittedForm, _isLoading),
      ),
    );
  }
}
