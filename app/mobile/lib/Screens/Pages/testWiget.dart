import 'package:flutter/material.dart';

class testWiget extends StatefulWidget {
  const testWiget({super.key, required this.id});
  final String id;
  @override
  State<testWiget> createState() => _testWigetState();
}

class _testWigetState extends State<testWiget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id),
      ),
    );
  }
}
