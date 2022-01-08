import 'package:flashcards/models/set_model.dart';
import 'package:flashcards/pages/set_mem.dart';
import 'package:flashcards/shared.dart';
import 'package:flutter/material.dart';

import '../../local.dart';
import '../set_page.dart';

class SetView extends StatefulWidget {
  SetView({Key? key, required this.set}) : super(key: key);

  SetModel set;

  @override
  State<SetView> createState() => _SetViewState();
}

class _SetViewState extends State<SetView> {
  @override
  Widget build(BuildContext context) {
    return 
    InkWell(
      onTap:() async{
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => SetMemorize(set: widget.set)));
        setState(() { Data.saveSets();});
      },
      child: Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heading(widget.set.name, context),
                            Text(widget.set.description),
                          ]),
                      Spacer(),
                      Row(children: [
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => AddCardDialog(
                                    onComplete: () {
                                      setState(() {});
                                    },
                                    set: widget.set));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => SetPage(set: widget.set)));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () {},
                        ),
                      ])
                    ]),
                    SizedBox(height: 10),
                    Text(
                        '${widget.set.getCountOfMemorizedCards()}/${widget.set.cards.length} Cards memorized',
                        style: TextStyle(fontSize: 12.0)
                            .apply(color: Colors.grey)),
                    SizedBox(height: 10),
                    if (widget.set.cards.length != 0)
                      ProgressLine(
                          percentage: (widget.set
                                      .getCountOfMemorizedCards()
                                      .toDouble() /
                                  widget.set.cards.length.toDouble() *
                                  100.0)
                              .toInt())
                  ]),
            )));
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = Colors.green,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
