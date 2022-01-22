import 'package:flashcards/models/set_model.dart';
import 'package:flashcards/pages/widgets/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class SetMemorize extends StatefulWidget {
  SetMemorize({required this.set});

  SetModel set;
  bool checkDef = false;

  @override
  _SetMemorizeState createState() => _SetMemorizeState();
}

class _SetMemorizeState extends State<SetMemorize>
    with TickerProviderStateMixin {
  List<String> welcomeImages = [
    "assets/welcome0.png",
    "assets/welcome1.png",
    "assets/welcome2.png",
  ];

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    return new Scaffold(
      body: Column(
        children: [
          TopBar(children: [
            Row(
              children: [
                BackButton(),
                SizedBox(width: 20),
                Text('Повторение',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
              ],
            ),
            SizedBox(height: 10)
          ]),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: new TinderSwapCard(
                orientation: AmassOrientation.BOTTOM,
                totalNum: widget.set.cards.length,
                stackNum: 3,
                swipeEdge: 4.0,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                maxHeight: MediaQuery.of(context).size.width * 0.9,
                minWidth: MediaQuery.of(context).size.width * 0.8,
                minHeight: MediaQuery.of(context).size.width * 0.8,
                cardBuilder: (context, index) {
                  return MemCard(
                      widget: widget, context: context, index: index);
                },
                cardController: controller = CardController(),
                swipeUpdateCallback:
                    (DragUpdateDetails details, Alignment align) {
                  /// Get swiping card's alignment
                  if (align.x < 0) {
                    //print("Card is LEFT swiping");
                  } else if (align.x > 0) {
                    //print("Card is RIGHT swiping");
                  }
                },
                swipeCompleteCallback:
                    (CardSwipeOrientation orientation, int index) {
                  if (!widget.checkDef)
                    widget.set.cards[index].correct += 1;
                  else
                    widget.set.cards[index].incorrect -= 1;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MemCard extends StatefulWidget {
  MemCard({
    Key? key,
    required this.widget,
    required this.context,
    required this.index,
  }) : super(key: key);

  SetMemorize widget;
  BuildContext context;
  bool visible = false;
  int index;

  @override
  State<MemCard> createState() => _MemCardState();
}

class _MemCardState extends State<MemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Spacer(),
        Text(widget.widget.set.cards[widget.index].term,
            style: Theme.of(context).textTheme.headline3),
        if (widget.visible)
          Text(widget.widget.set.cards[widget.index].definition,
              style: Theme.of(context).textTheme.headline5),
        Spacer(),
        IconButton(
            icon: Icon(Icons.remove_red_eye),
            color: Colors.grey,
            onPressed: () {
              widget.visible = true;
              widget.widget.checkDef = true;
              setState(() {});
            }),
        SizedBox(height: 10)
      ]),
    ));
  }
}
