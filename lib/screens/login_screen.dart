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

  final _formKey = GlobalKey<FormState>();
  String _password = "";
  String _email = "";
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child:  Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.jpg"),
                  fit: BoxFit.cover
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/images/logo.png'),width: 100, height: 150),
              Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                            ),
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
                              if (value != null && value.isEmpty) {
                                return "Enter your email";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _email = value;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            obscureText: _isPasswordVisible,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                            ),
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
                              hintStyle: const TextStyle(
                                color: Colors.redAccent,
                                fontFamily: 'OpenSans',
                              ),
                              filled: true,
                              fillColor: Colors.black54,
                            ),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return "Please Enter your password";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _password = value.trim();
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left:15, right: 15),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black54,
                              minimumSize: const Size.fromHeight(50),
                            ),
                            onPressed: () {
                              Provider.of<AuthProvider>(context, listen: false).login(context, _email, _password);
                            },
                            child: const Text(
                              'Log In',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}