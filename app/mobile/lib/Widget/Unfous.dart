import 'package:flutter/material.dart';

class Unfous extends StatelessWidget {
  const Unfous({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: child);
  }
}
