import 'package:flashcards/models/card_model.dart';
import 'package:flutter/material.dart';

import '../../shared.dart';

class CardView extends StatelessWidget {
  CardView({Key? key, required this.card, required this.onDelete})
      : super(key: key);

  Function onDelete;
  CardModel card;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        heading(card.term, context),
        Text(card.definition),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete();
            },
          )
        ])
      ]),
    ));
  }
}
