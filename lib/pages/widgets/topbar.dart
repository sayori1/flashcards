
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  TopBar({
    Key? key,required this.children,
  }) : super(key: key);

  List<Widget> children;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            children: [
              SizedBox(height: height + 10),
              ...children
            ],
          ),
        ));
  }
}
