import 'package:flutter/material.dart';

import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name= '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Center(child: AppLogo()),
          Text('abbddjjdjdj'),
          Spacer(),

          Column(
            spacing: 16,
            children: [
              CircularProgressIndicator(),
              Text('Version 1.0.0'),
            ],
          ),
          const SizedBox(height: 16,),
        ],
      ),
    );
  }
}


