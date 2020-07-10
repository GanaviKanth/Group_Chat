import 'dart:io';

import 'package:flutter/material.dart';

import './pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {

  final void Function(
    String email,
    String username,
    String password,
    File image,
    bool isLogin,
    BuildContext ctx,
  )submitFn;
  final bool isLoading;

  AuthForm(this.submitFn, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail ='';
  String _userPassword = '';
  String _username = '';
  var _isLogin = true;
  File _userImageFile;

  void _pickedImage(File image){
    _userImageFile = image;
  }

  void _trySubmit(){
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(_userImageFile == null && !_isLogin){
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please upload an image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if(isValid){
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _username.trim(),
        _userPassword.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if(!_isLogin) UserImagePicker(_pickedImage),
                    TextFormField(
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      key: ValueKey('email'),
                      validator: (value){
                        if(value.isEmpty || !value.contains('@')){
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                      ),
                      onSaved: (value){
                        _userEmail = value;
                      },
                    ),
                    if(!_isLogin)
                    TextFormField(
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      key: ValueKey('username'),
                      validator: (value){
                        if(value.isEmpty || value.length < 4){
                          return 'Enter a Username with atleast 4 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'User name',
                      ),
                      onSaved: (value){
                        _username = value;
                      },
                    ),
                    TextFormField(
                      key: ValueKey('password'),
                      validator: (value){
                        if(value.isEmpty || value.length < 7){
                          return ' enter a valid password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'password',
                      ),
                      obscureText: true,
                      onSaved: (value){
                        _userPassword = value;
                      },
                    ),
                    SizedBox(height: 10,),
                    if(widget.isLoading)
                      CircularProgressIndicator(),
                    if(!widget.isLoading)
                    RaisedButton(
                      child: Text(_isLogin ? 'Login' : 'SignUp'),
                      onPressed: _trySubmit,
                    ),
                    if(!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(_isLogin ? 'Create new account' : 'Account Exists'),
                      onPressed: (){
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}