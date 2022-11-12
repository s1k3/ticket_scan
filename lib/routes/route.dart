
import 'package:fluro/fluro.dart';
import 'package:ticket_scan/screens/login_screen.dart';
import 'package:ticket_scan/screens/previous_scans_screen.dart';
import 'package:ticket_scan/screens/splash_screen.dart';
class Routes {

  static var router = FluroRouter();

  static final _splashScreenHandler = Handler(handlerFunc: (context, params) => const SplashScreen());
  static final _loginScreenHandler = Handler(handlerFunc: (context, params) => const LogInScreen());
  static final _previousScansHandler = Handler(handlerFunc: (context, params) => const PreviousScansScreen());

  static void configure() {
    router.define("/", handler: _splashScreenHandler);
    router.define("/login", handler: _loginScreenHandler);
    router.define("/previous/scans", handler: _previousScansHandler);
  }
}