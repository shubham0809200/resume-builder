import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resume_builder/core/auth_check.dart';
import 'package:resume_builder/core/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.timmanaTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: const AuthCheck(),
    );
  }
}
