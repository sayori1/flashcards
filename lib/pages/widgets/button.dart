import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({
    required this.text,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  String text;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onTap(),
      child: Container(

        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: const BorderRadius.all(
              Radius.circular(40.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 10,
                offset: Offset(0, 3),
              )
            ]),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: "Averta",
                fontWeight: FontWeight.w800,
                fontSize: 18,
                letterSpacing: 0.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
