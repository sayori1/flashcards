import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/models/set_model.dart';
import 'package:flashcards/pages/widgets/card.dart';
import 'package:flutter/material.dart';

import '../local.dart';
import '../shared.dart';

class SetPage extends StatefulWidget {
  SetPage({Key? key, required this.set}) : super(key: key);

  SetModel set;
  @override
  State<SetPage> createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext) {
                    return AddCardDialog(
                        set: widget.set,
                        onComplete: () {
                          setState(() {Data.saveSets();
                          });
                        });
                  });
            },
            child: const Icon(Icons.add)),
        body: Wrap(
            children: widget.set.cards.map((item) {
          return CardView(
              card: item,
              onDelete: () {
                widget.set.cards.remove(item);
                setState(() { Data.saveSets();});
              });
        }).toList()));
  }
}

class AddCardDialog extends StatelessWidget {
  TextEditingController name = TextEditingController(text: "");
  TextEditingController description = TextEditingController(text: "");
  Function onComplete;
  SetModel set;

  AddCardDialog({required this.onComplete, required this.set});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: heading("Добавить карту", context),
      actions: [
        Center(
            child: ElevatedButton(
                onPressed: () {
                  onAdd(context, set);
                },
                child: Text('Добавить'))),
        SizedBox(height: 10)
      ],
      content: Column(children: [
        TextFormField(
          controller: name,
          decoration: new InputDecoration(hintText: "Термин"),
        ),
        TextFormField(
          controller: description,
          decoration: new InputDecoration(hintText: "Описание"),
        ),
        SizedBox(height: 10)
      ]),
    );
  }

  void onAdd(BuildContext context, SetModel set) {
    print('sdfsdf');
    if (name.text == "") {
      return;
    }
    set.cards.add(CardModel(term: name.text, definition: description.text));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Карта добавлена!')));
    onComplete();
    Navigator.of(context).pop();
  }
}
