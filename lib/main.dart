import 'package:flashcards/local.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'pages/home_page.dart';

void main() async {
  
  runApp(GetMaterialApp(home:Home()
  ,theme: ThemeData(fontFamily: 'Averta', primarySwatch: Colors.green),
  ));

  
}

