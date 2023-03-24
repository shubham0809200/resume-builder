import 'package:flutter/material.dart';
import 'package:resume_builder/core/auth_check.dart';
import 'package:resume_builder/core/route_constants.dart';
import 'package:resume_builder/ui/views/get_pdf/get_pdf_view.dart';
import 'package:resume_builder/ui/views/home_screen/home_screen_view.dart';
import 'package:resume_builder/ui/views/resume_screen/resume_screen_view.dart';
import 'package:resume_builder/ui/views/signin_screen/signin_screen_view.dart';
import 'package:resume_builder/ui/views/signup_screen/signup_screen_view.dart';
import 'package:resume_builder/ui/views/splash_screen/splash_screen_view.dart';

import 'fade_transition.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      //Basic Pages
      case authCheck:
        return FadeRoute(page: const AuthCheck());

      case splashScreen:
        return FadeRoute(page: const SplashScreenView());

      case signInScreen:
        return FadeRoute(page: const SigninScreenView());

      case signUpScreen:
        return FadeRoute(page: const SignupScreenView());

      case homeScreen:
        return FadeRoute(page: const HomeScreenView());

      case resumeScreen:
        ResumeScreenView? arguments = args as ResumeScreenView?;
        return FadeRoute(
            page: ResumeScreenView(
          resumeId: arguments!.resumeId,
        ));

      case getPdf:
        GetPdfView? arguments = args as GetPdfView?;
        return FadeRoute(
            page: GetPdfView(
          resume: arguments!.resume,
        ));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('ERROR ROUTE'),
        ),
      );
    });
  }
}
