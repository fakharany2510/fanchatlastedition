import 'package:flutter/material.dart';

class FanScreen extends StatelessWidget {
  const FanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Fan Screen',style: TextStyle(
            fontSize: 22,
            color: Colors.red
        ),),
      ),

    );
  }
}
