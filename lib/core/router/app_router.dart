import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/router_transation.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/widgets/ExitConfirmWrapper_widget.dart';
import 'package:flutter_application_1/feature/Onboarding/onboarding_screen.dart';
import 'package:flutter_application_1/feature/auth/screens/login_screen.dart';
import 'package:flutter_application_1/feature/auth/screens/sign_up_screen.dart';

import 'package:flutter_application_1/feature/home/screens/main_screen.dart';
import '../../feature/Onboarding/splash_screen.dart';

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return RouterTransitions.build(
            ExitConfirmWrapper(child: SplashScreen()));

      case Routes.onBoardView:
        return RouterTransitions.build(
            ExitConfirmWrapper(child: OnboardingScreen()));

      case Routes.registerScreen:
        return RouterTransitions.build(
            ExitConfirmWrapper(child: const SignUpScreen()));

      case Routes.logInView:
        return RouterTransitions.build(const LoginScreen());
      case Routes.homeView:
        return RouterTransitions.build(const MainScreen());
      default:
        return RouterTransitions.build(
          Scaffold(body: Center(child: Text("No Route: ${settings.name}"))),
        );
    }
  }
}
