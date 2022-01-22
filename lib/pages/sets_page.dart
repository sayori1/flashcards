import 'package:flashcards/models/set_model.dart';
import 'package:flashcards/pages/set_page.dart';
import 'package:flashcards/pages/widgets/topbar.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../local.dart';
import '../shared.dart';
import 'widgets/button.dart';
import 'widgets/set.dart';

class SetsPage extends StatefulWidget {
  SetsPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<SetsPage> createState() => _SetsPageState();
}

class _SetsPageState extends State<SetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: widget.scaffoldKey,
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Stack(
            children: [
              Column(children: [
                TopBar(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Колоды',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
                    ],
                  ),
                  SizedBox(height: 10)
                ]),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: Data.sets.map((item) {
                          return SetView(
                              set: item,
                              onAddCard: () {
                                ShowBottomSheetAddCard(widget.scaffoldKey, context,
                                    () {
                                  setState(() {});
                                }, item);
                              });
                        }).toList()),
                  ),
                )
              
              ]),
              
              Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          color: Colors.transparent,
                          width: 230,
                          child: Button(
                            text: "Добавить колоду",
                            onTap: () {
                              ShowBottomSheetAddSet(widget.scaffoldKey, context, () {
                                setState(() {});
                              });
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
        ));
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
    Get.back();
  }
}

ShowBottomSheetAddSet(scaffoldKey, context, onComplete) {
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
              Text("Добавить колоду", style: TextStyle(fontSize: 25)),
              Spacer(),
              BackButton()
            ]),
            Column(children: [
              TextFormField(
                controller: name,
                decoration: new InputDecoration(hintText: "Название"),
              ),
              TextFormField(
                controller: description,
                decoration: new InputDecoration(hintText: "Описание"),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 300,
                child: Button(
                  text: "Добавить колоду",
                  onTap: () {
                    if (name.text == "") {
                      return;
                    }
                    Data.sets.add(SetModel(
                        name: name.text, description: description.text));
                    ScaffoldMessenger.of(context).showSnackBar(

                        SnackBar(
                          duration: Duration(milliseconds: 500),
                          content: Text('Колода добавлена!')));
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
