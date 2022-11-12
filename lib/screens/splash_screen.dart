import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_scan/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget{

  const SplashScreen({super.key});

  @override
  createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AuthProvider>(context,listen: false).verify(context);
    });
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.jpg"),
                  fit: BoxFit.cover
              )
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(image: AssetImage('assets/images/logo.png'),width: 100, height: 150)
              ],
            ),
          ),
        )
    );
  }
}