import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  const AdaptativeButton(
      {super.key, required this.label, required this.onPress});

  final String label;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPress, color: Colors.amber, child: Text(label))
        : ElevatedButton(
            onPressed: onPress,
            style: Theme.of(context).elevatedButtonTheme.style,
            child: Text(label));
  }
}
