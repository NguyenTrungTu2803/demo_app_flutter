import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_beats/bases/route/name_route.dart';
import 'package:flutter_app_beats/ui/pages/page.dart';
import 'package:flutter_app_beats/ui/widgets/animation_transition/slide_left_transition.dart';
import 'package:flutter_app_beats/ui/widgets/animation_transition/slide_top_transition.dart';

class CustomRoute {
  static Route<dynamic> allRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
        break;
      case eventPage:
        return MaterialPageRoute(builder: (_) => EventPage());
        break;
      case buyPaymentPage:
        return SlideLeftTransition(page: PayPage());
        break;
      case registerPage:
        return MaterialPageRoute(builder: (_)=> RegisterPage());
        break;
      case qrPage:
        return SlideTopRoute(page: QrPage());
        break;
      case forgotPassWord:
        return SlideLeftTransition(page: ForgotPasswordPage());
        break;
      case eventPaymentPage:
        return SlideLeftTransition(page: EventPaymentPage());
    }
    return MaterialPageRoute(builder: (_) => LoginPage());
  }
}
