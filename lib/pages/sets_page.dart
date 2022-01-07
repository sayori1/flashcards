import 'package:flashcards/models/set_model.dart';
import 'package:flutter/material.dart';

import '../local.dart';
import '../shared.dart';
import 'widgets/set.dart';

class SetsPage extends StatefulWidget {
  const SetsPage({Key? key}) : super(key: key);

  @override
  State<SetsPage> createState() => _SetsPageState();
}

class _SetsPageState extends State<SetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext) {
                    return AddSetDialog(onComplete: () {
                      setState(() {});
                    });
                  });
            },
            child: const Icon(Icons.add)),
        appBar: AppBar(),
        drawer: const Drawer(),
        body: ListView(
            children: Data.sets.map((item) {
          return SetView(set: item);
        }).toList()));
  }
}

class AddSetDialog extends StatelessWidget {
  TextEditingController name = TextEditingController(text: "");
  TextEditingController description = TextEditingController(text: "");
  Function onComplete;

  AddSetDialog({required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: heading("Добавить колоду", context),
      actions: [
        Center(
            child: ElevatedButton(
                onPressed: () {
                  onAdd(context);
                },
                child: Text('Добавить'))),
        SizedBox(height: 10)
      ],
      content: Column(children: [
        TextFormField(
          controller: name,
          decoration: new InputDecoration(hintText: "Название"),
        ),
        TextFormField(
          controller: description,
          decoration: new InputDecoration(hintText: "Описание(необязательно)"),
        ),
        SizedBox(height: 10)
      ]),
    );
  }

  void onAdd(BuildContext context) {
    print('sdfsdf');
    if (name.text == "") {
      return;
    }
    Data.sets.add(
        SetModel(name: name.text, description: description.text, cards: []));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Колода добавлена!')));
    onComplete();
    Navigator.of(context).pop();
  }
}
