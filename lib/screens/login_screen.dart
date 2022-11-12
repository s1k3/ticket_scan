import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  LogInScreenState createState() => LogInScreenState();
}

class LogInScreenState extends State<LogInScreen> {
  static final _formKey = GlobalKey<FormState>();
  String _email ="";
  String _password = "";
  bool _isPasswordVisible = true;

  Widget _buildEmailTF() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
          decoration: const InputDecoration(
            focusColor: Colors.redAccent,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.zero
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.zero
            ),
            border: OutlineInputBorder(),
            prefixIcon: Icon(
              Icons.email,
              color: Colors.redAccent,
            ),
            hintText: 'Enter Email',
            hintStyle: TextStyle(
              color: Colors.redAccent,
              fontFamily: 'OpenSans',
            ),
            filled: true,
            fillColor: Colors.black54,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter your email";
            }
            return null;
          },
          onChanged: (value) {
            _email = value;
          },
        ),
    );
  }

  Widget _buildPasswordTF() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: TextFormField(
          obscureText: _isPasswordVisible,
          style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
          decoration: InputDecoration(
            focusColor: Colors.redAccent,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.zero
            ),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.zero
            ),
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(
              Icons.remove_red_eye,
              color: Colors.redAccent,
            ),
            suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.lock_outline : Icons.lock_open,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                }
            ),
            hintText: 'Enter Password',
            hintStyle: const TextStyle( color: Colors.redAccent, fontFamily: 'OpenSans'),
            filled: true,
            fillColor: Colors.black54,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please Enter your password";
            }
            return null;
          },
          onChanged: (value) {
            _password = value.trim();
          },
        ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/images/logo.png", height: 120),
                    const SizedBox(height: 30.0),
                    _buildEmailTF(),
                    const SizedBox(height: 30.0),
                    _buildPasswordTF(),
                    const SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black54,
                          foregroundColor: Colors.red,
                          textStyle: const TextStyle(color: Colors.white38),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Provider.of<AuthProvider>(context, listen: false).login(context, _email, _password);
                          }
                        },
                        child: const Text('LOG IN'),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}