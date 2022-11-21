import 'package:flutter/material.dart';

class BuildPage extends StatelessWidget {
  IconData? icon;
  String? title;
  Color? color;
  BuildPage({super.key, this.icon, this.color, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 200.0, color: Colors.white),
            Text(
              title!,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
