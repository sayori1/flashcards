import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/models/set_model.dart';
import 'package:flashcards/pages/bottom_sheet.dart';
import 'package:flashcards/pages/widgets/button.dart';
import 'package:flashcards/pages/widgets/card.dart';
import 'package:flashcards/pages/widgets/topbar.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../local.dart';
import '../shared.dart';

class SetPage extends StatefulWidget {
  SetPage({Key? key, required this.set}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  SetModel set;

  @override
  State<SetPage> createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: widget.scaffoldKey,

        /* FloatingActionButton.extended(
            label: Text('Добавить карту'),
            onPressed: () {
              showBottomDialog();

              /* showDialog(
                  context: context,
                  builder: (BuildContext) {
                    return AddCardDialog(
                        set: widget.set,
                        onComplete: () {
                          setState(() {Data.saveSets();
                          });
                        });
                  }); */
            }) */
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    TopBar(children: [
                      Row(
                        children: [
                          BackButton(),
                          SizedBox(width: 20),
                          Text('Карты в колоде',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600))
                        ],
                      ),
                      SizedBox(height: 10)
                    ]),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Wrap(
                                  children: widget.set.cards.map((item) {
                                return CardView(
                                    card: item,
                                    onDelete: () {
                                      widget.set.cards.remove(item);
                                      setState(() {
                                        Data.saveSets();
                                      });
                                    });
                              }).toList())
                            ]),
                      ),
                    ),
                  ],
                ),
                

                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        color: Colors.transparent,
                        width: 200,
                        child: Button(
                          text: "Добавить карту",
                          onTap: () {
                            ShowBottomSheetAddCard(widget.scaffoldKey, context, () {
                              setState(() {});
                            }, widget.set);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

ShowBottomSheetAddCard(scaffoldKey, context, onComplete, set) {
  TextEditingController name = TextEditingController(text: "");
  TextEditingController description = TextEditingController(text: "");

  scaffoldKey.currentState!.showBottomSheet(
    (_) {
      return Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
        ),
        height: 400,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(children: [
              Text("Добавить карту", style: TextStyle(fontSize: 25)),
              Spacer(),
              BackButton()
            ]),
            Column(children: [
              TextFormField(
                controller: name,
                decoration: new InputDecoration(hintText: "Термин"),
              ),
              TextFormField(
                controller: description,
                decoration: new InputDecoration(hintText: "Описание"),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 300,
                child: Button(
                  text: "Добавить карту",
                  onTap: () {
                    if (name.text == "") {
                      return;
                    }
                    set.cards.add(CardModel(
                        term: name.text, definition: description.text));
                    ScaffoldMessenger.of(context).showSnackBar(

                        SnackBar(
                          duration: Duration(milliseconds: 500),
                          content: Text('Карта добавлена!')));
                    onComplete();
                    name.text = description.text = "";
                    //Navigator.of(context).pop();
                  },
                ),
              ),
            ])
          ],
        ),
      );
    },
  );
}
