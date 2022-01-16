//packages
import 'dart:io';

import 'package:flutter/material.dart';
//files
import '/picker/image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String? username,
    File? imageFile,
    String? email,
    String? password,
    bool? isLoginn,
    BuildContext? ctx,
  ) _submitFn;
  final bool isLoading;
  AuthForm(this._submitFn, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _userName = '';
  var _emailAddress = '';
  var _password = '';
  var _isLogin = true;
  File? pickedImage;

  void _imagePicker(File? image) {
    pickedImage = image;
  }

  void _toSubmit() {
    var _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please upload an image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (_isValid) {
      _formKey.currentState!.save();
      widget._submitFn(_userName.trim(), pickedImage, _emailAddress.trim(), _password.trim(),
          _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: const Text(
            'Chat App',
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          margin: const EdgeInsets.all(25),
          alignment: Alignment.center,
          height: 100,
          width: 400,
        ),
        SingleChildScrollView(
          child: Center(
            child: Card(
              margin: const EdgeInsets.all(25),
              elevation: 7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!_isLogin) PickImage(_imagePicker),
                      const SizedBox(
                        height: 10,
                      ),
                      if (!_isLogin)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            key: const ValueKey('username'),
                            onSaved: (newValue) {
                              _userName = newValue!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please provide valid username';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: const ValueKey('email'),
                          onSaved: (newValue) {
                            _emailAddress = newValue!;
                          },
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please provide valid email address';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email Adress',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: const ValueKey('password'),
                          onSaved: (newValue) {
                            _password = newValue!;
                          },
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return 'Please provide password that atleast 7 characte long';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (widget.isLoading) const CircularProgressIndicator(),
                      if (!widget.isLoading)
                        ElevatedButton(
                          onPressed: _toSubmit,
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.pink),
                          ),
                          child: _isLogin
                              ? const Text('Login')
                              : const Text('SignUp'),
                        ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: _isLogin
                            ? const Text(
                                'create a new account',
                                style: TextStyle(color: Colors.pink),
                              )
                            : const Text(
                                'Already have an acoount',
                                style: TextStyle(color: Colors.pink),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
