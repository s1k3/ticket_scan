import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_scan/providers/auth_provider.dart';
import 'package:ticket_scan/providers/ticket_provider.dart';
import 'package:ticket_scan/routes/route.dart';

void main() {
  Routes.configure();

  runApp(const MainComponent());
}

class MainComponent extends StatelessWidget {
  const MainComponent({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TicketProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bangladesh Shilpakala Academy',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        initialRoute: '/',
        onGenerateRoute: Routes.router.generator,
      ),
    );
  }
}
