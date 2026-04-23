import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:queue/ui/views/screens/sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    dotenv.load(fileName: ".env");
    return MaterialApp(
      title: 'Flutter Demo',
      home: SignIn(),
    );
  }
}

