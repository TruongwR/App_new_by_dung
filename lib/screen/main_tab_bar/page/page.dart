import 'package:flutter/material.dart';


class SamplePage extends StatefulWidget {
  const SamplePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          widget.title,
          style: const TextStyle(

            fontSize: 17,
            fontWeight: FontWeight.w600,
            height: 1.2575,
            letterSpacing: 1,
            color: Color(0xff1e2022),
          ),
        ),
      ),
    );
  }
}
