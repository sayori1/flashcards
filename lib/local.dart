import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/set_model.dart';

class Data {
  static late SharedPreferences pref;
  static late List<SetModel> sets;
  static init() async {
    pref = await SharedPreferences.getInstance();
    loadSets();
    return true;
  }

  static loadSets() {
    if (pref.containsKey('Sets')) {
      var setsString = pref.getString("Sets") ?? "";
      sets = [];
      var setsJson = jsonDecode(setsString);
      for (var setJson in setsJson['Sets']) {
        
        sets.add(SetModel.fromJson(setJson));
      }
    } else {
      sets = [];
    }
  }

  static saveSets() async {
    Map toSave = {"Sets": []};

    for (var set in sets) {
      toSave['Sets'].add(set.toJson());
    }

    pref.setString('Sets', jsonEncode(toSave));
  }
}
