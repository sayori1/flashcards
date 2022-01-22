import 'package:flutter/material.dart';

class BottomDialog extends StatefulWidget {
  @override

  BottomDialog({required this.children});
  _BottomDialogState createState() => _BottomDialogState();
  List<Widget> children;
}

class _BottomDialogState extends State<BottomDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: widget.children,
      ),
    ));
  }
}