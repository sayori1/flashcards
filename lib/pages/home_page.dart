import "package:flutter/material.dart";

import '../local.dart';
import 'sets_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: Data.init(),
      builder: (context, snapshot) {
        if(snapshot.hasData)
          return SetsPage();
        else{
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      }
    );
  }
}
