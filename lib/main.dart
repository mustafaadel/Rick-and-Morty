import 'package:flutter/material.dart';
import 'presentation/router/app_router.dart';

void main() {
  runApp(Rick_Morty());
}

class Rick_Morty extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter().generateRoute,
    );
  }
}
