import 'package:flutter/material.dart';

class TransitiveColorContainer extends StatelessWidget {
  final Widget child;
  final MaterialColor color;
  const TransitiveColorContainer(
      {Key? key, required this.child, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color[700]!, color[500]!, color[200]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.6, 0.8, 1])),
    );
  }
}
